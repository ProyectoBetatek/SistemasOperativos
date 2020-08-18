#!/bin/bash
#Betatek
#ModificarGrupo
#FinModificarGrupo

clear
#Funciones
FuncionEncabezado(){

echo -e "\n\t\t--Modificar Grupo--\n\n\n"

}

FuncionContrasena(){
while true
do	
	clear
	FuncionEncabezado
	echo -e " Se exige que la contraseña, contenga al menos uno de los siguientes caracteres: 
una letra mayúzcula, una letra minúzcula, un numero , y un signo.\n\n (signos permitidos: '+' '?' '.' '*' '_' '/')\n\n\n"
	read -p "Ingrese la nueva contraseña: " Clave
	
	
	

	if ! [ -z "$Clave" ]
	then		
	local Clave2=`printf $Clave |tr -d [:alnum:]|tr -d "/"|tr -d "*"|tr -d "+"|tr -d "_"|tr -d "?"|tr -d "."` 
	local CantidadCaracter=`printf $Clave | wc -c`
		
		if [[ $CantidadCaracter -le 16 ]] && [[ $CantidadCaracter -ge 8 ]]
		then
				if [[ `echo $Clave | grep " " | wc -l` = 0 ]]
				then
					if [ -z "$Clave2" ]
					then
						local a=0

						if [[ `echo "$Clave" | grep [A-Z] | wc -l` = 0 ]]
						then
							let a=$a+1
							local Falta=`echo -e "\n-Una letra mayuzcula."`
						fi

						if [[ `echo "$Clave" | grep [a-z] | wc -l` = 0 ]]
						then
							let	a=$a+1
							Falta=`echo "$Falta\n-Una letra minuzcula."`
						fi

						if [[ `echo "$Clave" | grep [0-9] | wc -l` = 0 ]]
						then
							let	a=$a+1
							Falta=`echo "$Falta\n-Un numero."`
						fi

						if [[ `echo "$Clave" | grep [\/:*:+:_:?:.] | wc -l` = 0 ]] 
						then
							Falta=`echo "$Falta\n-Un simbolo."`
							let	a=$a+1
						fi
		
						if [ $a = 0 ]
						then
							sleep 1
							clear
							FuncionEncabezado
							read -p "Ingrese nuevamente la contraseña: " ClaveRepetida
							
							if [ $Clave = $ClaveRepetida ]
							then
								echo "Contraseña Aceptada!"
								sleep 2
								break	
							else
								echo -e "\n Las contraseñas son distintas!"							
							fi
 						
						else
							echo -e "\n La contraseña no fue aceptada..!"
							echo -e "\nFalta: \n$Falta"
						fi

										
					
					else
						echo -e "\n La contraseña contiene caracteres no admitidos '$Clave2'."
					fi
				else
					echo -e "\n La contraseña no debe contener espacios.!"		
				fi
		else 
			echo -e "\n La contraseña debe tener un largo de 8 a 16 caracteres!."
		fi
	else
	echo -e "\n La contraseña debe tener contenido.!"

	fi
sleep 2
clear
done


}
FuncionNombre(){

while true

do	
	echo ""
	read -p "Ingrese nuevo nombre del grupo: " Nombre
	Nombre=`echo $Nombre | tr [:upper:] [:lower:]`
	#Revisamos campo vacio
	if ! [ -z "$Nombre" ]
	then
		#Revisamos que haya ingresado solo carateres alfanumericos
		if [[ -z `echo $Nombre | tr -d "[:alnum:]"` ]]
		then

			CantidadCaracter=`printf $Nombre | wc -c`
			#Revisamos que el nombre tenga entre 4 y 30 caracteres
			if [[ $CantidadCaracter -le 30 ]] && [[ $CantidadCaracter -ge 4 ]]
			then
				#Revisamos que no haya espacios
				if [[ `echo $Nombre | grep " " | wc -l` = 0 ]]
				then 
				
					#Revisamos que el nombre ya no este en uso
					
					let=ExisteNombre=-1
					
					ExisteNombre=`cat /etc/group | cut -f 1 -d ':' | grep -x $Nombre | wc -l`
					
					if [ $ExisteNombre = 1 ]
					then
						echo -e "\n No se puede utilizar '$Nombre' como nombre de grupo dado que el mismo ya esta en uso..."
		
					else

					break
			
					fi
					
				else
					echo -e "\nNo se permite que el nombre del grupo contenga espacios."
				fi
			else
				echo -e "\n El nombre debe contener entre 4 y 30 caracteres.!"
			fi
		else
			echo -e "\nSolo se permite como nombre de grupo,caracteres alfanumericos.!"
		fi
	else
		echo -e "\nEl campo no puede estar vacio!"
	fi




done
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
echo -e "\n\n"

}
#FinFunciones






while true
do
	clear
	FuncionEncabezado
	echo -e "Ingrese el nombre del grupo a modificar.\n(Ingrese '0' para salir) o (Ingrese '*lista*' para poder ver los grupos existentes\n)"
		
	read -p "_:" NombreGrupo
	
	if [ "$NombreGrupo" = "*Lista*" ] || [ "$NombreGrupo" = "*lista*" ] || [ "$NombreGrupo" = "*LISTA*" ]
	then
		FuncionListar
		read -p "Ingrese nombre grupo_:" NombreGrupo
	fi
	echo "$NombreGrupo" | tr '[:upper:]' '[:lower:]'
	Resultado=`cat /etc/group | cut -d: -f1 | grep -x "$NombreGrupo" | wc -l`
	if [ "$NombreGrupo" = 0 ]
	then
		FuncionSalir
	else
	
		if [ "$Resultado" = 1 ]
		then
			Nombre=""
			Contrasena=""
			LimpiarDatos=""
			while true
			do
				
				clear
				FuncionEncabezado
				echo -e "Grupo a modificar: $NombreGrupo.\n\n"
				echo -e "Menu:"
				if [ -z "$Nombre" ]
				then
					echo -e "\n1-Modificar Nombre."
				else
				echo -e "\n1-Modificar Nombre.(Nuevo nombre: '$Nombre' )"
				fi
				if [ -z "$Contrasena" ]
				then
					echo -e "2-Modificar Contraseña."
				else
					echo -e "2-Modificar Contraseña. (Nueva contraseña: '$Contrasena' )"
				fi
				if [ ! -z "$Nombre" ] || [ ! -z "$Contrasena" ]
				then
					echo -e "3-Aplicar Cambios."
				fi
				
				echo -e "00-Volver atras.\n"
				echo -e "0-Salir.\n"
				read -p "_: " Opcion
				case "$Opcion" in
				1)
				FuncionNombre
				Nombre="$Nombre"
				;;
				2)
				FuncionContrasena
				Contrasena="$Clave"
				#Seguridad=1
				;;
				3)
				if [ ! -z "$Nombre" ] && [ ! -z "$Contrasena" ]
				then
					#Aplicar Cambios
					sudo groupmod -n "$Nombre" "$NombreGrupo"
					if [ "$?" = 0 ]
					then
						#read -p "1 " basura
						echo -e "\n Se ha cambiado el nombre correctamente."
						NombreGrupo="$Nombre"
						Nombre=""
						sudo groupmod -p $NombreGrupo $Contrasena 

						if [ "$?" = 0 ]
						then
							#read -p "2 " basura
							echo -e "\n Se ha cambiado la contraseña correctamente."
							Contrasena=""
							
						else
							echo -e "\n Error- La contraseña no se pudo guardar."
						fi
						
					else
						echo -e "\n Error- El nombre no se pudo guardar."
					fi

					
				elif [ ! -z "$Nombre" ]
				then
				#read -p "3 " basura
				sudo groupmod -n "$Nombre" "$NombreGrupo"
					if [ "$?" = 0 ]
					then
						echo -e "\n Se ha cambiado el nombre correctamente."
						NombreGrupo="$Nombre"
						Nombre=""
						
					else
						echo -e "\n Error- El nombre no se pudo guardar."
					fi
				elif [ ! -z "$Contrasena" ]
				then
					sudo groupmod $NombreGrupo -p $Contrasena 

					if [ "$?" = 0 ]
					then
						echo -e "\n Se ha cambiado la contraseña correctamente."
						Contrasena=""
						
					else
						echo -e "\n Error- La contraseña no se pudo guardar."
					fi
				else
				echo "Opcion Incorrecta"
				fi
				sleep 2
				;;
				0)
					FuncionSalir
				;;
				00)
					break
				;;
				*)
					echo -e "\n Opcion Incorrecta!"
				esac
				#read -p "presione para salir" basura
			done
			#while true
			#	do
			#		clear
			#		FuncionEncabezado
			#		echo -e "\n Desea volver a buscar? S/n"
			#		read -p "_: " Opcion
			#		case "$Opcion" in
			#		s|S) 
			#			clear
			#			break
			#		;;
			#		n|N)
			#			break 2
			#		;;
			#		*)
			#			echo -e "\n Opcion Incorrecta..."
			#		esac
			#
			#	done
		else
			echo -e "\n El nombre ingresado no pertenece a un grupo existente."
			
			
			sleep 2
		fi
		
	fi
	
done

	#echo "$NombreGrupo"
	#read basura
	
	#read -p "presione para salir" basura
#clear
#sleep 1
#exit
