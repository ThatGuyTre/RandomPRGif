# Find all GIF files in the Good directory
good_files=(Good/*/*.gif)

# Check if there are any GIF files in Good
if [ ${#good_files[@]} -eq 0 ]; then
    echo "No GIF files found in the Good directory."
    exit 1
fi

# Select a random GIF file from the Good directory
random_good_file=${good_files[RANDOM % ${#good_files[@]}]}
cp "$random_good_file" "./Good.gif"

# Find all GIF files in the Bad directory
bad_files=(Bad/*/*.gif)

# Check if there are any GIF files in Bad
if [ ${#bad_files[@]} -eq 0 ]; then
    echo "No GIF files found in the Bad directory."
    exit 1
fi

# Select a random GIF file from the Bad directory
random_bad_file=${bad_files[RANDOM % ${#bad_files[@]}]}
cp "$random_bad_file" "./Bad.gif"

# Print the results
echo "Copied $random_good_file to ./Good.gif and $random_bad_file to ./Bad.gif"