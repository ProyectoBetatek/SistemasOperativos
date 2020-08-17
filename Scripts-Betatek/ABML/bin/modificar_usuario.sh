#!/bin/bash
#Betatek
#ModificarUsuario
#Funciones
FuncionEncabezado(){
clear
echo -e "\n\t\t--Modificar Usuarios--\n\n\n"

}
FuncionSalir(){
		clear 
		sleep 1
		exit
}

#FinFunciones

while true
do
	FuncionEncabezado
	Nombre=""
	Comentario=""
	Home=""
	Contrasenia=""
	Grupos=""

	echo -e "\n"
	echo -e "\tMenu:"
	echo -e "\n\t1-Nombre: $NombreUsuario"
	echo -e "\n\t2-Comentario: $Comentario"
	echo -e "\n\t3-Home: $Home"
	echo -e "\n\t4-Contraseña: $Contrasenia"
	echo -e "\n\t5-Grupos: $Grupos"
	echo -e "\n\n\t0-Crear Usuario."
	echo -e "\t00-Salir."

	read -p "_: " Opcion

	case in $Opcion
	
		1) FuncionNombre	
		;;
		2) FuncionComentario
		;;
		3) FuncionHome
		;;
		4) FuncionContrasena
		;;
		5) FuncionGrupos
		;;
		0) FuncionCrearUsuario
		;;
		*) echo -e "\n\nOpcion Equivocada..."
	
	esac 

done


#FinModificarUsuario

