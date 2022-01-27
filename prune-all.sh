#! /usr/bin/env bash

cd "$(dirname $0)"
if [ ! -f ./prune.sh ]; then
   echo "Script prune.sh is not found."
   exit
fi
if [ -z "$1" ]; then
   echo "Please provide the paper size."
   exit 1
fi
if [ -z "$2" ]; then
   echo "Please provide the input directory."
   exit 1
fi
if [ -z "$3" ]; then
   echo "Please provide the output directory."
   exit 1
fi
if [ ! -d "$2" ]; then
   echo "Input directory $2 is not found."
   exit 1
fi
if [ ! -d "$3" ]; then
   echo "Output directory $3 is not found."
   exit 1
fi

RESOLUTION=300
PAPER="$1"
FOLDER_IN="$2"
FOLDER_OUT="$3"
#PARALLEL=4
#index=1

for path_in in "${FOLDER_IN}"/*; do
   if [ ! -f "${path_in}" ]; then
      continue
   fi
   name="${path_in##*/}"
   bare="${name%.*}"
   extension="${name##*.}"
   path_out="${FOLDER_OUT}/${bare}.pdf"

   if [ "${extension}" != pdf ]; then
      continue
   fi
   echo "pruning document" "${path_in}" "with Ghostscript..."
   #((index=index%PARALLEL))
   #((index++==0)) && wait
   rm -f "${path_out}"
   ./prune.sh "${PAPER}" "${path_in}" "${path_out}" "$5"
done
