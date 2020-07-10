#!/usr/bin/env zsh

# This script locates and replaces spaces in filenames
DIR=$(pwd)

# Controlling a loop with bash read command by redirecting STDOUT
#  as STDIN to while loop
#  find will not truncate filenames containing spaces
#  f = file d = directory maxdepth self-explanatory
find $DIR -type f -maxdepth 1 | while read file; do

# Using POSIX class [:space] to find space in filename
if [[ "$file" = *[[:space:]]* ]]; then

# Substitute space with _ character and consequently rename the file
mv "$file" `echo $file | tr ' ' '_'`
fi;

done

exit 0
