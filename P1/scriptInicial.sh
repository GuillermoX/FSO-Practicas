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
functExcluirExtensio=1
functIgnoraSubdir=1
functComparaPermis=1
#Es comprova quines opcions s'han indicat
while getopts "dse:i:p" opt; do
	case $opt in
		d) functLiniesDiff=0;;
		s) functSimilitud=0;;
		e) functExcluirExtensio=0
		   extensions=$(echo $OPTARG | tr "," " " );;
		i) functIgnoraSubdir=0
		   dirIgnorar=$(echo $OPTARG | cut -f1 -d" ")	#Asegurem que només s'ignori un únic subdirectori	   
		   pathDir1Ignorar=$(find $DIR1 -name $dirIgnorar -print)
		   pathDir2Ignorar=$(find $DIR2 -name $dirIgnorar -print)
		   if [ "$pathDir1Ignorar" != "" ]; then
			echo "Subdirectori ignorat: $pathDir1Ignorar"
		   	filesIgnorar1=$(find "$pathDir1Ignorar" -type f -printf "%f\n")
		   fi
		   if [ "$pathDir2Ignorar" != "" ]; then
			echo "Subdirectori ignorat: $pathDir2Ignorar"
		   	filesIgnorar2=$(find "$pathDir2Ignorar" -type f -printf "%f\n")
		   fi;;
		p) functComparaPermis=0;;
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
fitxersDir=$(comm -23 <(find "$DIR1" -type f -printf "%f\n" | sort) <(find "$DIR2" -type f -printf "%f\n" | sort))
#Si hi ha un directori a ignorar no es mostren els fitxer d'aquest
if [ $functIgnoraSubdir -eq 0 ] && [ "$pathDir1Ignorar" != "" ]; then
	fitxersDir=$(comm -23 <(echo -e "$fitxersDir") <(echo -e "$filesIgnorar1" | sort))
fi

#Si está activada la opció d'excluir extensions, per cada extensió es filtra la llista de fitxers unics del directori 1
if [ $functExcluirExtensio -eq 0 ]; then
	for ext in $extensions; do
		fitxersDir=$(echo -e "$fitxersDir" | grep -v "$ext")
	done
fi
echo -e "$fitxersDir"

#Es fa el mateix pels fitxers que només són al segon directori
echo "Fitxers només a $DIR2:"
fitxersDir=$(comm -13 <(find "$DIR1" -type f -printf "%f\n" | sort) <(find "$DIR2" -type f -printf "%f\n" | sort))
#Si hi ha un directori a ignorar no es mostren els fitxer d'aquest
if [ $functIgnoraSubdir -eq 0 ] && [ "$pathDir2Ignorar" != "" ]; then
	fitxersDir=$(comm -23 <(echo -e "$fitxersDir") <(echo -e "$filesIgnorar2" | sort))
fi
#Si está activada la opció d'excluir extensions, per cada extensió es filtra la llista de fitxers unics del directori 2
if [ $functExcluirExtensio -eq 0 ]; then
	for ext in $extensions; do
		fitxersDir=$(echo -e "$fitxersDir" | grep -v "$ext")
	done
fi
echo -e "$fitxersDir"

fitsSimilars=""
#S'obtenen tots els fitxers dins de dir1
files=$(find "$DIR1" -type f -printf "%f\n")
#En cas que hi hagi extensions a ignorar s'eliminen de la llista de fitxers
if [ $functExcluirExtensio -eq 0 ]; then
	for ext in $extensions; do
		files=$(echo -e "$files" | grep -v "$ext")
	done
fi

#Si hi ha un subdirectori a ignorar s'eliminen els fitxers que es trobin dins
if [ $functIgnoraSubdir -eq 0 ]; then
	files=$(comm -23 <(echo -e "$files" | sort) <(echo -e "$filesIgnorar1" | sort))
fi

#Per a cada fitxer de dir1
for file in $files; do
   #Si aquest fitxer existeix a dir 2 (i no es un directori) 
   pathFileDir2=$(find "$DIR2" -name $file -print)	#Es busca el fitxer a dir2
   #Si hi ha un subdirectori a ignorar es comprova que el fitxer no hi sigui dins
   if [ $functIgnoraSubdir -eq 0 ] && [ "$pathDir2Ignorar" != "" ]; then
	   pathFileDir2=$(echo "$pathFileDir2" | grep -v /"$dirIgnorar")
   fi
   if [ "$pathFileDir2" != "" ]; then		#Si la variable es buida vol dir que no s'ha trobat o que está a un subdirectori ignorat
      #Es compara si el contingut dels fitxers son iguals
      #Si son iguals "diff" retorna 0 (Éxit) per tant al negar-ho (!) no s'executa el bloc if
      #Si son diferents "diff" retorna 1 (Fracás) i al negar-ho (!) la condició es Vertadera
      pathFileDir1=$(find $DIR1 -name $file -print)
      if ! diff -q $pathFileDir1 $pathFileDir2 > /dev/null; then
	 #S'indica que els fitxers tenen el mateix nom pero contingut diferent
         echo "Contingut diferent en fitxers $file"
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
      #Si está activada la comparació de permisos
      if [ $functComparaPermis -eq 0 ]; then
              diffPermis=$(diff --normal <(ls -l $pathFileDir1 | cut -c1-10) <(ls -l $pathFileDir2 | cut -c1-10) | grep -E "<|>" | \
      		      sed -e 's/</- permisos dir 1:/g' -e 's/>/- permisos dir 2:/g')
	      if [ "$diffPermis" != "" ]; then
		      echo -e "Permisos diferents en fitxers $file:\n$diffPermis"
	      fi
      fi
   fi
done

if [ $functSimilitud -eq 0 ]; then
	echo -e "\nFitxers de noms iguals amb una similitud major o igual 90%"
        echo -e "$fitsSimilars"
fi	

