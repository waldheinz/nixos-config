#!/usr/bin/env bash

set -eou pipefail

source="$1"

function probe() {
    ffprobe \
        -v error -select_streams v:0 -show_entries stream="$1" \
        -of default=noprint_wrappers=1:nokey=1 "$source"
}

cspace=$(probe "color_space")
ctrans=$(probe "color_transfer")
cprim=$(probe "color_primaries")
x265_color="colorprim=$cprim:transfer=$ctrans:colormatrix=$cspace"

ffmpeg \
    -i "$source" \
    -vf scale=-2:1080:flags=lanczos \
    -c:v libx265 -preset slow -x265-params "crf=18:$x265_color" \
    -c:a libfdk_aac -strict experimental \
    "$source.mkv"
