#!/bin/bash

if [[ "$#" -gt 0 ]]; then
    folder="$1"
else
    folder="."
fi

if [[ -d "$folder" ]]; then
    abs_folder=$(cd "$folder" && pwd)
    echo "Organising $abs_folder "

    #sorting items directly inside the folder.
    for file in "$folder"/*; do

            # Skip items that are not files and ignore folders
            if [[ -f "$file" ]] && [[ ! -L "$file" ]]; then

                # Get the filename from the full path
                filename="${file##*/}"

                # Extract the file extension
                extension="${filename##*.}"

                # Convert the extension to lowercase
                extension="${extension,,}"

                # Determine the category of the file
                if [ "$filename" = "$extension" ]; then
                    category="Other"
            else
                #determine the category based on the extensions
                case "$extension" in
                    jpg|jpeg|png|gif|webp)
                    category="images"
                        ;;
                    pdf|doc|docx|txt|xlsx|pptx)
                        category="Documents"
                            ;;
                    mp3|mkv|mov)
                        category="video"
                            ;;
                    zip|rar|tar|gz)
                        category="Archives"
                            ;;
                    *)
                       category="other"
                            ;;
                    esac 
                
                fi

                # Display the filename and its category
                echo "$filename -> $category"
                #create target directory if it doesn't exist
                target_dir="$folder/$category"
                mkdir -p "$target_dir"

                target_file="$target_dir/$filename"
            counter=1

            while [ -f "$target_file" ]; do
                target_file="$target_dir/${filename}(${counter})${extension}"
                ((counter++))
            done

            # Extract the final destination filename for logging
            final_filename="${target_file##*/}"

            # Move the file to its final, unique destination
            mv "$file" "$target_file"

             #Print each individual move
            if [ "$filename" = "$final_filename" ]; then
                echo "Moved:  $filename -> $category/"
            else
                echo "Renamed & Moved: $filename -> $category/$final_filename"
            fi

            # Increment final summary counter
            ((files_moved_count++))

            fi
    done
# else
#     echo "Error: Folder '$folder' does not exist." >&2
#     exit 1
fi
