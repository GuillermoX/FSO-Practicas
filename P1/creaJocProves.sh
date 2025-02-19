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
#Afegir contingut als fitxers de dir1
ls JocDeProves/dir1 > JocDeProves/dir1/fit1
ls JocDeProves/dir1 > JocDeProves/dir1/fit2
ls JocDeProves/dir1 > JocDeProves/dir1/fit3
ls JocDeProves/dir1 > JocDeProves/dir1/fit4
#Afegir un subdirectori amb fitxers al dir 1
mkdir JocDeProves/dir1/dir1_1
touch JocDeProves/dir1/dir1_1/fit7
touch JocDeProves/dir1/dir1_1/fit8
#Afegir contingut als fitxers de dir1/dir1_1
ls JocDeProves/dir1 > JocDeProves/dir1/dir1_1/fit7
ls JocDeProves/dir1 > JocDeProves/dir1/dir1_1/fit8
#Copiar fitxers del directori dir1 al subdirectori dir1_1
cp JocDeProves/dir1/fit3 JocDeProves/dir1/dir1_1
cp JocDeProves/dir1/fit4 JocDeProves/dir1/dir1_1

#Afegir fitxers al directori 2
touch JocDeProves/dir2/fit5
touch JocDeProves/dir2/fit6
#Afegir contingut als fitxers de dir1
ls JocDeProves/dir2 > JocDeProves/dir2/fit5
ls JocDeProves/dir2 > JocDeProves/dir2/fit6
#Copiar fitxers del directori 1 al 2
cp JocDeProves/dir1/fit1 JocDeProves/dir2
cp JocDeProves/dir1/fit2 JocDeProves/dir2
cp JocDeProves/dir1/fit4 JocDeProves/dir2
#Canviar el contingut de fitxers copiats de dir1
ls JocDeProves/dir2 > JocDeProves/dir2/fit1
#Afegir un subdirectori amb fixers al dir 2
mkdir JocDeProves/dir2/dir2_1
touch JocDeProves/dir2/dir2_1/fit9
touch JocDeProves/dir2/dir2_1/fit10
#Afegir contingut als fitxers de dir2/dir2_1
ls JocDeProves/dir2 > JocDeProves/dir2/dir2_1/fit9
ls JocDeProves/dir2 > JocDeProves/dir2/dir2_1/fit10
#Copiar fitxers del dir2 al subdirectori dir2_1
cp JocDeProves/dir2/fit5 JocDeProves/dir2/dir2_1


