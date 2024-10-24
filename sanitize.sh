#!/bin/bash

# Make an array of directories to sanitize
dir_array=(./Good ./Bad ./Request)

# Delete all non-gif files and, in folders ending with _files, delete gif files not starting with 'giphy'
for dir in "${dir_array[@]}"; do
    # Delete all non-gif files
    find "$dir" -type f ! -name "*.gif" -delete

    # For directories ending with _files, delete gif files not starting with 'giphy'
    find "$dir" -type d -name "*_files" | while read folder; do
        find "$folder" -type f -name "*.gif" ! -name "giphy*" -delete
    done
done

# Rename all remaining gif files and move them to their parent directory
for dir in "${dir_array[@]}"; do
    find "$dir" -mindepth 1 -type d | while read folder; do
        parent_dir=$(dirname "$folder")
        dir_name=$(basename "$folder")
        dir_name_no_suffix=${dir_name%_files}
        
        for file in "$folder"/*.gif; do
            if [ -f "$file" ]; then  # Check if file exists
                # Get the filename without the path
                filename=$(basename "$file")
                
                # Remove "giphy" prefix and replace it with the directory name without _files suffix
                new_name="${filename/giphy/$dir_name_no_suffix}"
                
                # Rename the file and move it to the parent directory
                mv "$file" "$parent_dir/$new_name"
            fi
        done
        
        # Remove the now-empty subdirectory
        rmdir "$folder" 2>/dev/null
    done
done

# Rename folders ending with _files by removing the _files suffix
find "${dir_array[@]}" -type d -name "*_files" | while read folder; do
    new_folder_name=${folder%_files}
    mv "$folder" "$new_folder_name"
done
