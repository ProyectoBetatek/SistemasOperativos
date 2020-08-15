#!/bin/bash
#Betatek
#BajaUsuario
#Funciones

FuncionEncabezado(){

echo -e "\n\t\t--Eliminar Usuario--\n\n\n"

}
FuncionSalir(){
		clear 
		sleep 1
		exit
}
FuncionListar(){
Uid=`cat /etc/login.defs | egrep  "^UID_MIN*" |tr -s " " | cut -f2 -d" "`
#echo "Uid $Uid"
TotalLineas=`cat /etc/passwd | wc -l`
#echo "total linea $TotalLineas"
Linea=`cat /etc/passwd | egrep -n "$Uid" | cut -f1 -d":"`
#echo "linea $Linea"
let Linea=$Linea-1
let Tail=$TotalLineas-$Linea
#echo "tail $Tail"
cat /etc/passwd | tail -n"$Tail" | cut -f1 -d: | column
echo -e "\n\n"
read -p "Presione una tecla para salir..." basura
FuncionSalir

}
#FinFunciones

while true
do
	clear
	FuncionEncabezado
	echo -e "Ingrese el nombre del usuario a eliminar.\n(Ingrese '0' para salir) o (Ingrese '*lista*' para poder ver los grupos existentes\n)"
	read -p "_: " NombreUsuario
		
	
	if [ "$NombreUsuario" = 0 ]
	then
		FuncionSalir
	elif [ "$NombreUsuario" = "*Lista*" ] || [ "$NombreUsuario" = "*lista*" ] || [ "$NombreUsuario" = "*LISTA*" ]
	then
		echo ""
		echo ""
		FuncionListar
	else
	
	while true
	do
		echo -e "\n Esta seguro que desea elminar al usuario '$NombreUsuario'? s/n \n"
		read -p "_: " Opcion
		
		case "$Opcion" in
		
		s|S)
			sleep 1
			clear
			while true
			do
				echo -e "\tElija una opcion:"
                echo -e "\t1- Eliminar usuario y home del usuario."
				echo -e "\t2- Eliminar usuario y conservar los datos del home del usuario."
				
				read -p "Opcion_: " opcion
		
				case $opcion in
			
				1)
					echo "#elimimnar usuario y home"
					#elimimnar usuario y home
				;;
				2)
					echo "#eliminar usuario"
					echo "#pregunatar donde guardar el home."
					#eliminar usuario
					#pregunatar donde guardar el home.
				;;
				*)
					echo "Opcion incorrecta!..."
					sleep 1
					echo ""
				esac
			sleep 2

			done
			
		;;
		n|N)
		break
		;;
		*)
			echo -e "\n Opcion Incorrecta!"
		esac
	done
	
		
	fi
	#sleep 1
done
#FinEliminarUsuario

sudo groupdel "$NombreGrupo" 2> null
			Resultado="$?"
			
			case "$Resultado" in
			0)
				echo -e "\n Grupo eliminado con exito!."
			;;
			6) 
				echo -e "\n El grupo especificado no existe!."
			;;	
			8)
				echo -e "\n No se ha podido eliminar al grupo: $NombreGrupo . Debido a que el mismo sigue siendo el grupo primariode algun usuario. \ (Para eliminarlo , no debe ser grupo primario de ningun usuario del sistema)"
			;;
			2)
				echo -e "\n Sintaxis del comando no valida!!"
			;;
			10)
				echo -e "\n No se pudo actualizar el archivo de grupo!"
			esac
			echo 
			echo -e "\n\n"
			read -p "Presione una tecla para continuar..." basura
			break

