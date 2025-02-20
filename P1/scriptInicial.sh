#!/bin/bash
# Script per comparar dos directoris
# Es verifica el numero de arguments que no es igual a 2
if [ "$#" -ne 2 ]; then
   # En cas de error, >&2 redigeix la sortida de error estandart a stderr
   echo "Ús: $0 <directori1> <directori2>" >&2 
   exit 1
fi
# Es assigna dos primers arguments (DIR1 Y DIR2)
DIR1=$1
DIR2=$2
# Es comprova si els directoris existen i són directoris (no fitxers)
if [ ! -d "$DIR1" ] || [ ! -d "$DIR2" ]; then
   echo "Un o ambdós directoris no existeixen." >&2
   exit 1
fi
# Es comparan llistant dos directoris on es mostraran solament els arxius del primer directori
echo "Fitxers només a $DIR1:"
comm -23 <(ls "$DIR1" | sort) <(ls "$DIR2" | sort)
# Es comparan llistant dos directoris on es mostraran solament els arxius del segon directori
echo "Fitxers només a $DIR2:"
comm -13 <(ls "$DIR1" | sort) <(ls "$DIR2" | sort)
# Es fara el recorregut de cada arxiu de primer directori
for file in $(ls "$DIR1"); do
   # Es verifica si l'arxiu de primer directori tambe existeix en segon 
   if [ -f "$DIR2/$file" ]; then
      # Si aixo compleix, es compraran els arxius per saber si son diferents dins
      # Per la diff -q (quiet mode) no es mostren las diferencies entre arxius, sino indicara si hay canvis con un codi de la sortida
      # Si el contingut de dos fitxers es igual, el codi de sortida sera 0 (0 - identics, 1 - iguals), llavors s'enviara al /dev/null
      if ! diff -q "$DIR1/$file" "$DIR2/$file" > /dev/null; then
         # En cas, si el contingut de arxius del mateix nom es diferent, per tant es mostrara per pantalla
         echo "Fitxer diferent: $file"
      fi
   fi
done
