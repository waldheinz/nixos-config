#!/usr/bin/env bash

source="$1"

function probe {
    return $(ffprobe -v error -select_streams v:0 -show_entries stream="$1" \
        -of default=noprint_wrappers=1:nokey=1 "$source")
}

cspace=$(probe "color_space")
ctrans=$(probe "bt2020nc")
cprim=$(probe "bt2020nc")
x265_color="colorprim=$cprim:transfer=$ctrans:colormatrix=$cspace"

ffmpeg \
    -i "$source" \
    -vf scale=-2:1080:flags=lanczos \
    -c:v libx265 -preset slow -x265-params "crf=16:$x265_color" \
    -c:a libfdk_aac -strict experimental \
    "$source.mkv"
