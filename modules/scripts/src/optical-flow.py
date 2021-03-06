#!/usr/bin/env python3

import argparse
import concurrent.futures
import cv2
import numpy as np
import os
import queue

parser = argparse.ArgumentParser(description="Optical flow video interpolation.")

parser.add_argument("--layers", type=int, default=5)
parser.add_argument("--wnd-size", type=int, default=32)
parser.add_argument("--iterations", type=int, default=5)
parser.add_argument("--poly-n", type=int, default=7)
parser.add_argument("input", type=str)
parser.add_argument("output", type=str)

def warp_flow(img_p, img_n, flow):
    h, w = flow.shape[:2]

    flow_p = -flow.copy()
    flow_p[:,:,0] /= 2.0
    flow_p[:,:,1] /= 2.0
    flow_p[:,:,0] += np.arange(w)
    flow_p[:,:,1] += np.arange(h)[:,np.newaxis]

    flow_n = flow.copy()
    flow_n[:,:,0] /= 2.0
    flow_n[:,:,1] /= 2.0
    flow_n[:,:,0] += np.arange(w)
    flow_n[:,:,1] += np.arange(h)[:,np.newaxis]

    return cv2.addWeighted(
        cv2.remap(img_p, flow_p, None, cv2.INTER_CUBIC, borderMode=cv2.BORDER_REPLICATE), 0.5,
        cv2.remap(img_n, flow_n, None, cv2.INTER_CUBIC, borderMode=cv2.BORDER_REPLICATE), 0.5,
        0)

if __name__ == '__main__':
    args = parser.parse_args()

    encoding = 'MP4V'
    cam = cv2.VideoCapture(args.input, cv2.CAP_FFMPEG)
    if not cam.isOpened():
        print('unable to open source: ', args.input)
        sys.exit(1)

    fps = cam.get(cv2.CAP_PROP_FPS) * 2
    w = int(cam.get(cv2.CAP_PROP_FRAME_WIDTH))
    h = int(cam.get(cv2.CAP_PROP_FRAME_HEIGHT))
    out = cv2.VideoWriter(args.output, cv2.VideoWriter_fourcc(*encoding), fps, (w, h), 1)
    threads = os.cpu_count()

    with concurrent.futures.ThreadPoolExecutor(max_workers=threads) as exec:
        pending = queue.Queue(maxsize=threads)

        def go(prev, curr):
            flow = cv2.calcOpticalFlowFarneback(
                prev['gray'],
                curr['gray'],
                None,
                0.5,    # pyr_scale
                args.layers,        # number of pyramid layers including the initial image
                args.wnd_size,      # averaging window size; larger values increase the algorithm robustness
                args.iterations,    # number of iterations the algorithm does at each pyramid level
                args.poly_n,        # poly_n, size of the pixel neighborhood used to find polynomial expansion
                1.2,    # poly_sigma, standard deviation of the Gaussian that is used to smooth derivatives
                cv2.OPTFLOW_FARNEBACK_GAUSSIAN)

            return prev['img'], warp_flow(prev['img'].copy(), curr['img'].copy(), flow)

        keep_submitting = True

        def submit_work():
            ret, img = cam.read()
            gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            prev = { "gray" : gray, "img" : img}

            while keep_submitting:
                ret, img = cam.read()
                if not ret:
                    break

                gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
                curr = { "gray" : gray, "img" : img}
                pending.put(exec.submit(go, prev, curr))
                prev = curr

        submitter = exec.submit(submit_work)

        while not (submitter.done() and pending.empty()):
            try:
                img1, img2 = pending.get().result()
                out.write(img1)
                out.write(img2)
            except KeyboardInterrupt:
                keep_submitting = False
