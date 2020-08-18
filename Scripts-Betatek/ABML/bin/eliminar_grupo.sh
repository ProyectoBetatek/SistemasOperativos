#!/bin/bash
#Betatek
#EliminarGrupo
#Funciones
FuncionEncabezado(){

echo -e "\n\t\t--Eliminar Grupo--\n\n\n"

}
FuncionSalir(){
		clear 
		sleep 1
		exit
}
FuncionListar(){
Gid=`cat /etc/login.defs | egrep  "^GID_MIN*" |tr -s " " | cut -f2 -d" "`
#echo "gid $Gid"
TotalLineas=`cat /etc/group | wc -l`
#echo "$TotalLineas"
Linea=`cat /etc/group | egrep -n "$Gid" | cut -f1 -d":"`
let Linea=$Linea-1
let Tail=$TotalLineas-$Linea

cat /etc/group | tail -n"$Tail" | cut -f1 -d: | column

}
#FinFunciones

while true
do
	clear
	FuncionEncabezado
	echo -e "Ingrese el nombre del grupo a eliminar.\n(Ingrese '0' para salir) o (Ingrese '*lista*' para poder ver los grupos existentes\n)"
	read -p "_: " NombreGrupo
		
	if [ "$NombreGrupo" = "*Lista*" ] || [ "$NombreGrupo" = "*lista*" ] || [ "$NombreGrupo" = "*LISTA*" ]
	then
		echo -e "\n\n"
		FuncionListar
		echo -e "\n\n"
		read -p "Ingrese nombre grupo_: " NombreGrupo
	fi
	
	if [ "$NombreGrupo" = 0 ]
	then
		FuncionSalir
	else
		while true
		do
			echo -e "\n Esta seguro que desea elminar al grupo '$NombreGrupo'? s/n \n"
			read -p "_: " Opcion
			
			case "$Opcion" in
			
			s|S)
			
				sudo groupdel "$NombreGrupo" 2> /dev/null
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
#FinEliminarGrupo
