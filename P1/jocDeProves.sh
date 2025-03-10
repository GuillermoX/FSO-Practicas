#! /bin/bash
	
nomDirPrincipal=$1

# Crear directori general
mkdir $nomDirPrincipal

# Crear directori 1
mkdir $nomDirPrincipal/dir1
cd $nomDirPrincipal/dir1/
touch  fA fB.c fC f1 f2 f6

# Crea subdirectoris del dir 1
mkdir dir1_1
mkdir dirCopia
cd dir1_1
touch fH f3 f.txt4 f5.txt
cd ../
touch dirCopia/fK

#Retornem al directori principal
cd ../

# Crea directori 2
mkdir dir2
cd dir2
touch fD fE

# Crea subdirectoris del dir 2
mkdir dir2_1
mkdir dirCopia
touch dirCopia/fL
cd dir2_1
touch fI.c

#Crea subdirectori del subdirectori del dir 2
mkdir dir2_1_1
touch dir2_1_1/fJ

#Retornem al directori principal
cd ../../

# Afegir contingut als fitxers del dir 1
echo -e "Linia1\nLinia2\nLinia3\nLinia4" > dir1/f1
echo -e "Linia1\nLinia2\nLinia3\nLinia4\nLinia5\nLinia6\nLinia7\nLinia8\nLinia9\nLinia10" > dir1/f2
echo -e "Linia1\nLinia2\nLinia3\nLinia4" > dir1/f6
echo -e "Linia1\nLinia2\nLinia3\nLinia4" > dir1/dir1_1/f3
echo -e "Linia1\nLinia2\nLinia3\nLinia4" > dir1/dir1_1/f.txt4
echo -e "Linia1\nLinia2\nLinia3\nLinia4\nLinia5\nLinia6\nLinia7\nLinia8\nLinia9\nLinia10" > dir1/dir1_1/f5.txt

# Copiar alguns fitxers de dir 1 a dir 2 i subdirectoris seus
cp dir1/f1 dir1/f2 dir2/
cp dir1/dir1_1/f3 dir1/dir1_1/f.txt4 dir2/dir2_1
cp dir1/dir1_1/f5.txt dir2/
cp dir1/f6 dir2/dir2_1/dir2_1_1

# Canviar el contingut d'alguns fitxers copias de dir1 a dir2
echo -e "Linia1\nLinia2\nLinia3\nLinia4\nLinia5\n \nLinia6\nLinia7\nLinia8\nLinia9\nLinia10Diferent" > dir2/f2
echo -e "Linia1\nLinia2\nLinia3\nLinia4\nLinia5\nLinia6\nLinia7\nLinia8\nLinia9\nLinia10Diferent" > dir2/f5.txt
echo -e "Linia1\nLinia2Diferent\nLinia3\nLinia4Diferent" > dir2/dir2_1/f.txt4
echo -e "Linia1\nLinia2\nLinia3Diferent\nLinia4Diferent\nLiniaExtra\nLiniaExtra" > dir2/dir2_1/dir2_1_1/f6

# Canviar els permisos d'alguns fitxers amb noms iguals
chmod u+x dir2/f5.txt
chmod 707 dir2/dir2_1/f3


