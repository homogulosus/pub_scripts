#!/usr/bin/env zsh

# This script locates and replaces spaces in filenames
DIR="."

# Controlling a loop with bash read command by redirecting STDOUT
#  as STDIN to while loop
#  find will not truncate filenames containing spaces
find $DIR -type f | while read file; do

# Using POSIX class [:space] to find space in filename
if [[ "$file" = *[[:space:]]* ]]; then

# Substitute space with _ character and consequntly rename the file
mv "$file" `echo $file | tr ' ' '_'`
fi;

# End of while loop
done

exit 0
