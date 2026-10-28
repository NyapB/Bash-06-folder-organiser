#!/bin/bash

if [[ "$#" -gt 0 ]]; then
    folder="$1"
else
    folder="."
fi

if [[ -d "$folder" ]]; then
    abs_folder=$(cd "$folder" && pwd)
    echo "Organising $abs_folder "
fi