#! /bin/bash
#Generador de directoris pel Joc de Proves

#Creacio dels dos directoris
mkdir JocDeProves
mkdir JocDeProves/dir1
mkdir JocDeProves/dir2

#Afegir fitxers al directori 1
touch JocDeProves/dir1/fit1
touch JocDeProves/dir1/fit2
touch JocDeProves/dir1/fit3
touch JocDeProves/dir1/fit4
touch JocDeProves/dir1/fitExt1.txt
touch JocDeProves/dir1/fitExt2.c
#Afegir contingut als fitxers de dir1
ls JocDeProves/dir1 > JocDeProves/dir1/fit1
ls JocDeProves/dir1 > JocDeProves/dir1/fit2
ls JocDeProves/dir1 > JocDeProves/dir1/fit3
ls JocDeProves/dir1 > JocDeProves/dir1/fit4
ls JocDeProves/dir1 > JocDeProves/dir1/fitExt1.txt
#Afegir un subdirectori amb fitxers al dir 1
mkdir JocDeProves/dir1/dir1_1
touch JocDeProves/dir1/dir1_1/fit7
touch JocDeProves/dir1/dir1_1/fit8
touch JocDeProves/dir1/dir1_1/fitExt3.txt
#Afegir contingut als fitxers de dir1/dir1_1
ls JocDeProves/dir1 > JocDeProves/dir1/dir1_1/fit7
ls JocDeProves/dir1 > JocDeProves/dir1/dir1_1/fit8

#Afegir fitxers al directori 2
touch JocDeProves/dir2/fit5
touch JocDeProves/dir2/fit6
#Afegir contingut als fitxers de dir1
ls JocDeProves/dir2 > JocDeProves/dir2/fit5
ls JocDeProves/dir2 > JocDeProves/dir2/fit6
#Copiar fitxers del directori 1 al 2
cp JocDeProves/dir1/fit1 JocDeProves/dir2
cp JocDeProves/dir1/fit4 JocDeProves/dir2
cp JocDeProves/dir1/fitExt1.txt JocDeProves/dir2
cp JocDeProves/dir1/dir1_1/fit7 JocDeProves/dir2
#Canviar el contingut de fitxers copiats de dir1
ls JocDeProves/dir2 > JocDeProves/dir2/fit1
ls JocDeProves/dir2 > JocDeProves/dir2/fit7
ls JocDeProves/dir2 > JocDeProves/dir2/fitExt1.txt
#Canviar els permisos de fitxers copiats de dir1
chmod u+x JocDeProves/dir2/fit1
#Afegir un subdirectori amb fixers al dir 2
mkdir JocDeProves/dir2/dir2_1
touch JocDeProves/dir2/dir2_1/fit9
touch JocDeProves/dir2/dir2_1/fit10
#Afegir contingut als fitxers de dir2/dir2_1
ls JocDeProves/dir2 > JocDeProves/dir2/dir2_1/fit9
ls JocDeProves/dir2 > JocDeProves/dir2/dir2_1/fit10
#Copiar fitxers del dir2 al subdirectori dir2_1
cp JocDeProves/dir2/fit5 JocDeProves/dir2/dir2_1
#Copiar fitxers del dir1 al subdirectori dir2_1
cp JocDeProves/dir1/fit2 JocDeProves/dir2/dir2_1
#Cambiar el contingut d'algun fitxer copiat de dir1 en dir2_1
ls JocDeProves/dir2 > JocDeProves/dir2/dir2_1/fit2
#Cambiar permisos d'algun fitxer de dir1 en dir2_1
chmod 007 JocDeProves/dir2/dir2_1/fit2


