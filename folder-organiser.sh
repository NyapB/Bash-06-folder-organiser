#!/bin/bash

if [[ "$#" -gt 0 ]]; then
    folder="$1"
else
    folder="."
fi

if [[ -d "$folder" ]]; then
    abs_folder=$(cd "$folder" && pwd)
    echo "Organising $abs_folder "
else
    echo "Error: Folder '$folder' does not exist." >&2
    exit 1
fi