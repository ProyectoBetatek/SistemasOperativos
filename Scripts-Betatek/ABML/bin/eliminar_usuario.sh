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

}
#FinFunciones

while true
do
	clear
	FuncionEncabezado
	echo -e "Ingrese el nombre del usuario a eliminar.\n(Ingrese '0' para salir) o (Ingrese '*lista*' para poder ver los grupos existentes\n)"
	read -p "_: " NombreUsuario
		
	if [ "$NombreUsuario" = "*Lista*" ] || [ "$NombreUsuario" = "*lista*" ] || [ "$NombreUsuario" = "*LISTA*" ]
	then
		echo ""
		echo ""
		FuncionListar
		read -p "_: " NombreUsuario
	fi
	if ! [  -z $NombreUsuario ]
	then
		
		if [ "$NombreUsuario" = 0 ]
		then
			FuncionSalir
		
		elif [ `cat /etc/passwd | cut -f 1 -d ':' | grep -x $NombreUsuario | wc -l` = 1 ]
		then
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
						echo -e "\t3- Cancelar."
						read -p "Opcion_: " opcion
				
						case $opcion in
					
						1)
							echo "#elimimnar usuario y home"
							#elimimnar usuario y home
							sudo userdel -r $NombreUsuario
							if [ $? = 0 ] 
							then
								echo "Se ha eliminado el usuario y su informacion"
							else
								echo "No se ha eliminado el usuario"

							fi
						;;
						2)
							echo "#eliminar usuario"
							echo "#pregunatar donde guardar el home."
							#eliminar usuario
							#pregunatar donde guardar el home.
						;;
						3)
						break 2
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
		else
			echo -e "\nEl usuario ingresado no es correcto!..."
			sleep 2
			
		fi
	fi
	#sleep 1
done
#FinEliminarUsuario


