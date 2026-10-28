#!/bin/bash

# Check how many arguments the user provides
if [ "$#" -gt 0 ]; then
    folder="$1"

    # Check if the provided folder exists
    if [ -d "$folder" ]; then
        echo "Organising: $folder"

        #counting the number of files moved correctly
        n=0

            #sorting items directly inside the folder.
            for file in "$folder"/*; do

            # Skip items that are not regular files
            if [ -f "$file" ]; then

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

                #move the file to increment counter if successful
                if mv "$file" "$target_dir/"; then
                    # Prints the filename with 20 spaces of padding, a right arrow, and the category folder
                    printf " %-20s → %s/\n" "$filename" "$category"
                    ((n++))
                else
                    echo "Error: Failed to move $filename" >&2
                fi


            fi
        done
    else
        echo "Error: Folder '$folder' does not exist." >&2
        exit 1
    fi

else
    # No folder argument was provided
    echo "Error: Please provide a folder to organise." >&2
    exit 1
fi