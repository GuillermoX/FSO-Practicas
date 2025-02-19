#!/bin/bash
# Script per comparar dos directoris

#En cas de que no s'hagin introduit dos parámetres s'informa a l'usuari.
if [ "$#" -ne 2 ]; then
   echo "Ús: $0 <directori1> <directori2>" >&2	#Es redirecciona el missatge d'error al canal Stderror
   exit 1
fi

DIR1=$1
DIR2=$2
#Es comprova si els parámetres son directoris
if [ ! -d "$DIR1" ] || [ ! -d "$DIR2" ]; then
#  En cas que no ho siguin s'informa a l'usuari
   echo "Un o ambdós directoris no existeixen." >&2
   exit 1
fi

#Es mostra els fitxers que només son al primer directori
#Per això s'utilitza la comanda "comm" i es mostra només la primera columna
#(que correspon als elements que només es troben a la primera entrada)
echo "Fitxers només a $DIR1:"
comm -23 <(find "$DIR1" -type f -printf "%f\n" | sort) <(find "$DIR2" -type f -printf "%f\n" | sort)

#Es fa el mateix pels fitxers que només són al segon directori
echo "Fitxers només a $DIR2:"
comm -13 <(find "$DIR1" -type f -printf "%f\n" | sort) <(find "$DIR2" -type f -printf "%f\n" | sort)

#Per a cada fitxer de dir1
for file in $(find "$DIR1" -type f -printf "%f\n"); do
   #Si aquest fitxer existeix a dir 2 (i no es un directori) 
   pathFileDir2=$(find "$DIR2" -name $file -print)	#Es busca el fitxer a dir2
   if [ "$pathFileDir2" != "" ]; then			#Si find no mostra res es que no s'ha trobat
      #Es compara si el contingut dels fitxers son iguals
      #Si son iguals "diff" retorna 0 (Éxit) per tant al negar-ho (!) no s'executa el bloc if
      #Si son diferents "diff" retorna 1 (Fracás) i al negar-ho (!) la condició es Vertadera
      pathFileDir1=$(find $DIR1 -name $file -print)
      if ! diff -q $pathFileDir1 $pathFileDir2 > /dev/null; then
	 #S'indica que els fitxers tenen el mateix nom pero contingut diferent
         echo "Fitxer diferent: $file"
      fi
   fi
done
