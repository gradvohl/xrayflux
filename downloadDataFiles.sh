#!/bin/bash
# Script to download datasets with X-ray fluxes from the Sun.
# The user should provide a file with a list of datasets to download.
# The script download at the current directory.
#
# Autor: Andre Leon S. Gradvohl, Dr.
# Last version: Seg 23 Out 2017 21:41:47 -02

# Number of simultaneous connections
NUMCONN=8

# Check the number of arguments. Only one argument is necessary
if [[ $# -ne 1 ]]; then
  echo "Wrong number of arguments."
  echo -e "Usage:\n\t $0 <file with a list of datasets>" 
  exit 1
fi

#Check if the first argument is a file.
if [[ -f $1 ]]; then
  FILE=$1
else
  echo "$1 is not a file."
  exit 1
fi

LINE=" "

# Get the list of files that will be downloaded.
for LINE in `cat ${FILE}`; do
  LIST=${LIST}" "${LINE}
done

# Create NUMCONN parallel conections with wget.
echo ${LIST} | xargs -n 1 -P ${NUMCONN} wget -q --no-check-certificate 

if [ $? -eq 123 ]; then
  echo "Not all files were downloaded. Please check if its ok!"
else
  echo "All files downloaded."
fi

exit 0
