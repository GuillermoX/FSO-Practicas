#! /bin/bash
# Generador de directoris pel Joc de Proves

# Creacio dels dos directoris
mkdir JocDeProves
mkdir -p JocDeProves/dir1
mkdir -p JocDeProves/dir2

# Afegir fitxers al dir1
touch JocDeProves/dir1/fit1
touch JocDeProves/dir1/fit2
touch JocDeProves/dir1/fit3
touch JocDeProves/dir2/fit4
touch JocDeProves/dir2/fit5
touch JocDeProves/dir1/fitExt1.txt
touch JocDeProves/dir1/fitExt2.c

# Afegir el contingut als fitxers de dir1
ls JocDeProves/dir1 > JocDeProves/dir1/fit1
ls JocDeProves/dir1 > JocDeProves/dir1/fit2
ls JocDeProves/dir1 > JocDeProves/dir1/fit3
ls JocDeProves/dir1 > JocDeProves/dir1/fit4
ls JocDeProves/dir1 > JocDeProves/dir1/fit5
echo "Text del fitxer" > JocDeProves/dir1/fitExt1.txt
echo "#include <stdio.h> \nint main() {return 0;}"

# Afegir un subdirectori amb fitxers al dir1
mkdir JocDeProves/dir1/dir1_1
touch JocDeProves/dir1/dir1_1/fit6
touch JocDeProves/dir1/dir1_1/fit7
touch JocDeProves/dir1/dir1_1/fitExt3.txt

#Afegir contingut als fitxers de dir1/dir1_1
ls JocDeProves/dir1 > JocDeProves/dir1/dir1_1/fit6
ls JocDeProves/dir1 > JocDeProves/dir1/dir1_1/fit7
echo "HOLA MUNDO" > JocDeProves/dir1/dir1_1/fitExt3.txt

# Afegir fitxers al dir2
touch JocDeProves/dir2/fit8
touch JocDeProves/dir2/fit9
touch JocDeProves/dir2/fit10

# Afegir contingut als fitxers de dir2
ls JocDeProves/dir2 > JocDeProves/dir2/fit8
ls JocDeProves/dir2 > JocDeProves/dir2/fit9
ls JocDeProves/dir2 > JocDeProves/dir2/fit10

# Afegir un subdirectori amb fitxers al dir2
mkdir JocDeProves/dir2/dir2_1
touch JocDeProves/dir2/dir2_1/fit11
touch JocDeProves/dir2/dir2_1/fit12

#Afegir contingut als fitxers de dir2/dir2_1
ls JocDeProves/dir2 > JocDeProves/dir2/dir2_1/fit11
ls JocDeProves/dir2 > JocDeProves/dir2/dir2_1/fit12

# Copiar fitxers de dir1 a dir2
cp JocDeProves/dir1/fit4 JocDeProves/dir2
cp JocDeProves/dir1/fit5 JocDeProves/dir2
cp JocDeProves/dir1/dir1_1/fit6 JocDeProves/dir2
cp JocDeProves/dir1/dir1_1/fit7 JocDeProves/dir2

# Modificar el contingut de fitxers copiats
echo "HELLO" > JocDeProves/dir2/fit4
echo "HOLA" > JocDeProves/dir2/fit5
echo "BONJOUR" > JocDeProves/dir2/fit6
echo "HALLO" > JocDeProves/dir2/fit7

# Avís sobre la finalització de l'execucio
echo "Ja esta creat el joc de proves!"