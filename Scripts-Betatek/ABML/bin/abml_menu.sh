#! /bin/bash
#Betatek
#Script menú.

let op=-1

while true

do	
   
	clear

	echo -e "\n\t\t\t---MENÚ PRINCIPAL--- \n

\t--USUARIOS--\t\t|\t--GRUPOS-- \n
\t1- Crear Usuario\t|\t4- Crear Grupo 
\t2- Eliminar Usuario\t|\t5- Eliminar Grupo 
\t3- Mostrar Usuarios\t|\t6- Mostrar Grupos
\t------------------\tLogs\t-----------------
\t7- Intentos de login fallidos.
\t8- Login exitoso.
\t-------------------\t|\t-------------------

\t\t\t\t0-Salir\n"
	
	read -p "Ingrese la opción deseada: " op

 
	
	case $op in
		1) 
			sh ./alta_usuario.sh
	
		;;

		2) 
			 sh ./eliminar_usuario.sh
		;;


		3) 
			sh ./listar_usuario.sh

		;;


		4)	
			sh ./alta_grupo.sh

		;;


		5) 
			sh ./eliminar_grupo.sh
		;;

		6) 
			sh ./listar_grupo.sh

		;;

		7) 
			sh ./Log_Fallido.sh	
		;;

		8) 
			sh ./Log_Exitoso.sh	
		;;


		0) clear 
		echo -e "\n\e[0;32m\n\t\t---FIN DE EJECUCION---\e[0m\n"
		sleep 1
		clear
		exit
		;;
		*) echo -e "\n\e[0;31mOpcion Incorrecta!...\e[0m\n"
		sleep 1

	esac
	
	
done

#FIN MENU_ABML

