#!/bin/bash
# Script per comparar dos directoris

#En cas de que no s'hagin introduit mínim dos parámetres s'informa a l'usuari.
if [ "$#" -lt 2 ]; then
   echo "Ús: $0 <directori1> <directori2>" >&2	#Es redirecciona el missatge d'error al canal Stderror
   exit 1
fi

DIR1=$1
DIR2=$2
#Es desplacen els parametres obligatoris per desprès tractar els opcionals
shift 2

#Es presuposa que totes les opcions addicionals están desactivades
functLiniesDiff=1
functSimilitud=1
#Es comprova quines opcions s'han indicat
while getopts "ds" opt; do
	case $opt in
		d) functLiniesDiff=0;;
		s) functSimilitud=0;;
		?) echo Opció incorrecta; exit 1;;
	esac
done

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
fitsSimilars=""
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
	 if [ $functLiniesDiff -eq 0 ] || [ $functSimilitud -eq 0 ]; then
	 	liniesDiff=$(diff --suppress-common-lines $pathFileDir1 $pathFileDir2 | grep -E "<|>" | sed -e 's/</dir 1:/g' -e 's/>/dir 2:/g')
	 fi
	 if [ $functLiniesDiff -eq 0 ]; then
	 	echo "Diferències en els fitxers:"
		echo -e "$liniesDiff"
	 fi
	 if [ $functSimilitud -eq 0 ]; then	 
		 numLinies1=$(wc -l < "$pathFileDir1")
		 numLinies2=$(wc -l < "$pathFileDir2")
		 numLiniesDiff=$(echo -e "$liniesDiff" | wc -l)
		 similitud=$(( 100 - (numLiniesDiff * 100 / (numLinies1 + numLinies2) / 2) ))
		 if [ $similitud -ge 90 ]; then fitsSimilars+="$file\n"; fi
		 echo "Similitud: $similitud%"
	 fi
      fi
   fi
done

if [ $functSimilitud -eq 0 ]; then
	echo -e "\nFitxers de noms iguals amb una similitud major o igual 90%"
        echo -e "$fitsSimilars"
fi	

