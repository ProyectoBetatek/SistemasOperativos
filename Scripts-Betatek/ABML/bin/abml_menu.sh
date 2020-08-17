#! /bin/bash
#Betatek
#Script menú.

let op=-1

while true

do	
   
	clear

	echo -e "\n\t\t\t---MENÚ PRINCIPAL--- \n

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
			sh ./alta_usuario.sh
		;;

		2) 
			sh ./modificar_usuario.sh
		;;


		3) 
			sh ./eliminar_usuario.sh
		;;


		4) 
			sh ./listar_usuario.sh
		;;


		5) 
			sh ./alta_grupo.sh
		;;

		6) 
			sh ./modificar_grupo.sh
		;;

		7) 
			sh ./eliminar_grupo.sh
		;;

		8) 
			sh ./listar_grupo.sh
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
