#!/usr/bin/env python3

import numpy as np
import cv2

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
    import sys
    try:
        fn = sys.argv[1]
        out_fn = sys.argv[2]
    except:
        print(help_message)
        sys.exit(1)

    encoding = 'MP4V'
    cam = cv2.VideoCapture(fn, cv2.CAP_FFMPEG)
    if not cam.isOpened():
        print('unable to open source: ', fn)
        sys.exit(1)

    fps = cam.get(cv2.CAP_PROP_FPS) * 2
    ret, prev = cam.read()
    prevgray = cv2.cvtColor(prev, cv2.COLOR_BGR2GRAY)
    prevflow = None
    h, w = prevgray.shape[:2]
    out = cv2.VideoWriter(out_fn, cv2.VideoWriter_fourcc(*encoding), fps, (w, h), 1)

    while True:
        out.write(prev)
        ret, img = cam.read()
        if not ret:
            break

        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        # if prevflow is not None:
        #     flags = cv2.OPTFLOW_USE_INITIAL_FLOW | cv2.OPTFLOW_FARNEBACK_GAUSSIAN
        # else:
        #     flags = cv2.OPTFLOW_FARNEBACK_GAUSSIAN

        flow = cv2.calcOpticalFlowFarneback(
            prevgray,
            gray,
            prevflow,
            0.5,    # pyr_scale
            5,      # number of pyramid layers including the initial image
            256,    # averaging window size; larger values increase the algorithm robustness
            5,      # number of iterations the algorithm does at each pyramid level
            7,      # poly_n, size of the pixel neighborhood used to find polynomial expansion
            1.2,    # poly_sigma, standard deviation of the Gaussian that is used to smooth derivatives
            cv2.OPTFLOW_FARNEBACK_GAUSSIAN)

        warped_img = warp_flow(prev.copy(), img.copy(), flow.copy())
        cv2.imshow('in', warped_img)

        out.write(warped_img)

        prevgray = gray
        prevflow = flow.copy()
        prev = img.copy()

        ch = 0xFF & cv2.waitKey(1)
        if ch == 27:
            break
    cv2.destroyAllWindows()
