#! /bin/bash
#Betatek
#Script menu.

let op=-1

while true

do	
   
	clear

	echo -e "\n\t\t---MENÚ PRINCIPAL--- \n

\t--USUARIOS--\t\t|\t--GRUPOS-- \n
\t1- Crear Usuario\t|\t5- Crear Grupo
\t2- Modificar Usuario\t|\t6- Modificar Grupo 
\t3- Eliminar Usuario\t|\t7- Eliminar Grupo 
\t4- Mostrar Usuarios\t|\t8- Mostrar Grupos 
\t-------------------\t|\t-------------------

\t\t\t\t0-Salir\n"
	
	read -p "Ingrese la opción deseada: " op

 
	
	case $op in
		1) 
			sh ./usuario/alta_usuario.sh
		;;

		2) 
			sh ./usuario/modificar_usuario.sh
		;;


		3) 
			sh ./usuario/eliminar_usuario.sh
		;;


		4) 
			sh ./usuario/listar_usuario.sh
		;;


		5) 
			sh ./grupo/alta_grupo.sh
		;;

		6) 
			sh ./grupo/modificar_grupo.sh
		;;

		7) 
			sh ./grupo/eliminar_grupo.sh
		;;

		8) 
			sh ./grupo/listar_grupo.sh
		;;

		0) clear 
		echo -e "\n\e[0;32m\n\t\t---FIN DE EJECUCION---\e[0m\n"
		sleep 1
		clear
		exit
		;;
		*) echo -e "\n\e[0;31mOpcion Incorrecta!...\e[0m\n"

	esac
	sleep 1s
	
done

#FIN MENU_ABML
