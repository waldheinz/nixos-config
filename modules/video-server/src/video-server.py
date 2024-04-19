#!/usr/bin/env python3

from http import HTTPStatus
from http.server import HTTPServer, BaseHTTPRequestHandler
from xdg_base_dirs import xdg_data_dirs
import hashlib
import json
import logging
import os
import subprocess
import threading
import time
import sys
from random import getrandbits
from socket import inet_ntop, AF_INET6
from struct import pack


logging.basicConfig(stream=sys.stderr, level=logging.INFO)
log = logging.getLogger(__name__)

def recurse_video_files(dir: os.PathLike):
    f = []

    for (dirpath, dirnames, filenames) in os.walk(dir):
        f.extend([os.path.join(dirpath, f) for f in filenames])
        for d in dirnames:
            f.extend(recurse_video_files(os.path.join(dirpath, d)))

    return f

def find_video_files():
    f = []

    for dir in xdg_data_dirs():
        f.extend(recurse_video_files(dir))

    return f

video_map = { }

def random_mc_group():
    return inet_ntop(AF_INET6, pack('<QQ', 0x05ff, getrandbits(64)))

def build_video_map(files: list[os.PathLike]):
    result = { }
    cnt = 0

    for f in files:
        id = hashlib.sha1(f.encode('utf-8')).hexdigest()
        url = ""
        if id in video_map:
            url = video_map[id]["url"]
        else:
            url = f"udp://[{random_mc_group()}]:6312"

        result[id] = {
            'name' : os.path.basename(f),
            'file' : f,
            'url' : url
        }

        cnt = cnt + 1

    return result

video_map = build_video_map(find_video_files())
videos_active = { }

def periodic_cleanup():
    while True:
        now = time.time()
        obsolete = []

        for k, v in videos_active.items():
            if now - v["requested"] > 60:
                log.info(f"stopping stream for {k} (not requested since { now - v['requested'] }s)")
                obsolete.append(k)
                v["proc"].kill()

        for k in obsolete:
            del videos_active[k]

        time.sleep(30)

t = threading.Thread(target=periodic_cleanup)
t.daemon = True
t.start()

class RequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        global video_map
        video_map = build_video_map(find_video_files())

        self.send_response(HTTPStatus.OK.value)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

        self.wfile.write(json.dumps(video_map).encode('utf-8'))

    def do_POST(self):
        length = int(self.headers['Content-Length'])
        list = json.loads(self.rfile.read(length))
        self.start_videos(list)

    def start_videos(self, ids: list[str]):
        now = time.time()

        for video_id in ids:
            if video_id in videos_active:
                videos_active[video_id]["requested"] = now
            else:
                if not video_id in video_map:
                    log.warning(f"not starting unknown video {video_id}")
                else:
                    log.info(f"starting stream for {video_id}")
                    entry = video_map[video_id]

                    cmd = [
                        "ffmpeg",
                        "-loglevel", "panic",
                        "-stream_loop", "-1",
                        "-re", "-i", entry["file"], "-c", "copy", "-f", "mpegts",
                        f"{ entry['url'] }?pkt_size=1316" ]

                    videos_active[video_id] = {
                        "proc" : subprocess.Popen(cmd),
                        "requested" : now
                    }

def main():
    server_address = ('', 8001)
    httpd = HTTPServer(server_address, RequestHandler)
    print('serving at %s:%d' % server_address)
    httpd.serve_forever()


if __name__ == "__main__":
    main()
