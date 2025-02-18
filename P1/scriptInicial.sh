#!/bin/bash
# Script per comparar dos directoris
if [ "$#" -ne 2 ]; then
   echo "Ús: $0 <directori1> <directori2>" >&2
   exit 1
fi
DIR1=$1
DIR2=$2
if [ ! -d "$DIR1" ] || [ ! -d "$DIR2" ]; then
   echo "Un o ambdós directoris no existeixen." >&2
   exit 1
fi
echo "Fitxers només a $DIR1:"
comm -23 <(ls "$DIR1" | sort) <(ls "$DIR2" | sort)
echo "Fitxers només a $DIR2:"
comm -13 <(ls "$DIR1" | sort) <(ls "$DIR2" | sort)
for file in $(ls "$DIR1"); do
   if [ -f "$DIR2/$file" ]; then
      if ! diff -q "$DIR1/$file" "$DIR2/$file" > /dev/null; then
         echo "Fitxer diferent: $file"
      fi
   fi
done
