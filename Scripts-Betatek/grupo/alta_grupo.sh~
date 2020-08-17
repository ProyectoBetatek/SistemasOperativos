#!/bin/bash
#Betatek
#AltaGrupo


FuncionEncabezado(){
clear
echo -e "\t\n--Crear Grupo--\n\n\n"

}

FuncionSalir(){
		clear 
		sleep 1
		exit
}

FuncionContrasena(){
while true
do	
	clear
	FuncionEncabezado
	echo -e " Se exige que la contraseña, contenga al menos uno de los siguientes caracteres: 
una letra mayúzcula, una letra minúzcula, un numero , y un signo.\n\n (signos permitidos: '+' '?' '.' '*' '_' '/')\n\n(Ingrese '0' para salir  o '00' Para crear el grupo sin contraseña.)\n\n"
	read -p "Ingrese contraseña: " Clave
	
	if [ "$Clave" = 0 ]
	then
		FuncionSalir
	elif [ "$Clave" = 00 ]
	then
		Clave=""
		break
	else
	
	

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
									echo -e "\nContraseña Aceptada!"
									sleep 1
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
	fi
sleep 2
clear
done


}
FuncionNombre(){

while true

do	
	echo -e "\nIngrese nombre del grupo.\n(Ingrese '0' para salir)\n"
	read -p "_: " Nombre
	
	if [ "$Nombre" = 0 ]
	then
		FuncionSalir
	fi
	
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
#Nombre
while true
do
	FuncionEncabezado
	FuncionNombre
	#FinNombre

	#Contraseña
	clear
	FuncionEncabezado

	while true
	do

		echo ""
		read -p "Desea ingresar una contraseña al grupo '$Nombre'?. s/n (Por Defecto : No): " Respuesta
		
		if [ -z "$Respuesta" ] || [ "$Respuesta" = "n" ] || [ "$Respuesta" = "N" ] 
		then
			Contrasena=""
			break
		
		elif [ "$Respuesta" = "s" ] || [ "$Respuesta" = "S" ]
		then
			FuncionContrasena
			Contrasena=$Clave
			break
		else
			echo -e "\n Opcion Invalida...!"
		fi

		
	sleep 2

	done
	clear
	#FinContraseña
	#Ejecutamos la alta al grupo

	FuncionEncabezado
	if [ -z "$Contrasena"  ]
	then
	Pregunta="Desea dar de alta al grupo: $Nombre?? . S/N"

	else
	Pregunta="Desea dar de alta al grupo: $Nombre, con la contraseña : $Contrasena?? . S/N"
	fi

	while true
	do
		echo "$Pregunta"
		read -p "_: " Opcion
		case $Opcion in

		S|s)
			sudo groupadd ${Nombre}
			if [ "$?" = 0 ]
			then		 
				echo -e "\n El grupo se ha creado con exito!"
				
			else
				echo -e "\n Error-El grupo no se ha creado...!"
				
			fi

			if [ ! -z "$Contrasena" ]
			then
				sudo groupmod $Nombre -p $Contrasena 

				if [ "$?" = 0 ]
				then
					echo -e "\n Se ha agregado la contraseña al grupo."
				else
					echo -e "\n Error- La contraseña no se pudo guardar."
				fi
			fi
			sleep 2
			break
		;;
		n|N)
			echo -e "\n Se ha cancelado el alta..."
			break
		;;
		*)
			echo -e "\n Opcion Incorrecta!"
		esac
	done
	while true
	do
		FuncionEncabezado
		echo -e "Desea agregar otro grupo? s/n "
		read -p "_: " Opcion
		
		case "$Opcion" in
		s|S)
			break
		;;
		n|N)
			FuncionSalir
		;;
		*)
			echo -e "\n Opcion Incorrecta!"
		esac
	done
done
	
#Fin Alta Grupo
