#!/usr/bin/env python3

import setuptools

setuptools.setup(
    name='mdi-video-server',
    install_requires=['xdg_base_dirs'],
    scripts=['video-server.py']
)
