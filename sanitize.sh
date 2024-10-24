# Make an array of directories to sanitize
dir_array=(./Good ./Bad ./Request)

# Delete all non-gif files and gif files not starting with 'giphy' in each directory
for dir in "${dir_array[@]}"; do
    find "$dir" -type f \( ! -name "*.gif" -o \( -name "*.gif" ! -name "giphy*" \) \) -delete
done

# Rename all remaining gif files to have the name of their directory
for dir in "${dir_array[@]}"; do
    # Get the base name of the directory
    dir_name=$(basename "$dir")
    
    for file in "$dir"/*.gif; do
        if [ -f "$file" ]; then  # Check if file exists
            # Get the filename without the path
            filename=$(basename "$file")
            
            # Remove "giphy" prefix and replace it with the directory name
            new_name="${filename/giphy/$dir_name}"
            
            # Rename the file
            mv "$file" "$dir/$new_name"
        fi
    done
done