PART 1:

# RUTES PER LA COMPILACIÓ
	dir1 = P1/JocDeProves/dir1
	dir2 = P1/JocDeProves/dir2

DONAR PERMISOS D'EXECUCIÓ:

	chmod +x scriptInicial.sh JocDeProves.sh
	
EXECUCIÓ DEL SCRIPT PER CREAR LES DADES Y FITXERS DE PROVA:

	./JocDeProves.sh

EXECUCIÓ DEL SCRIPT DE COMPARACIÓ:

	P1/scriptInicial.sh $(dir1) $(dir2)