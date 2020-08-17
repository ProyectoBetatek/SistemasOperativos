#!/bin/bash
#Betatek
#AltaUsuario
#Funciones

FuncionEncabezado(){
clear
echo -e "\n\t\t--Alta Usuarios--\n\n\n"

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
FuncionNombreUsuario(){

while true

do	
	echo -e "\nIngrese nombre del usuario.\n(Ingrese '0' para salir)\n"
	read -p "_: " NombreUsuario
	
	if [ "$NombreUsuario" = 0 ]
	then
		FuncionSalir
	fi
	
	#Revisamos campo vacio
	if ! [ -z "$NombreUsuario" ]
	then
		#Revisamos que haya ingresado solo carateres alfanumericos
		if [[ -z `echo $NombreUsuario | tr -d "[:alnum:]"` ]]
		then

			CantidadCaracter=`printf $NombreUsuario | wc -c`
			#Revisamos que el nombre tenga entre 4 y 30 caracteres
			if [[ $CantidadCaracter -le 30 ]] && [[ $CantidadCaracter -ge 4 ]]
			then
				#Revisamos que no haya espacios
				if [[ `echo $NombreUsuario | grep " " | wc -l` = 0 ]]
				then 
				
					#Revisamos que el nombre ya no este en uso
					
					let=ExisteNombre=-1
					
					ExisteNombre=`cat /etc/passwd | cut -f 1 -d ':' | grep -x $NombreUsuario | wc -l`
					
					if [ $ExisteNombre = 1 ]
					then
						echo -e "\n No se puede utilizar '$NombreUsuario' como nombre de usuario dado que el mismo ya esta en uso..."
		
					else

					break
			
					fi
					
				else
					echo -e "\nNo se permite que el nombre del usuario contenga espacios."
				fi
			else
				echo -e "\nEl nombre debe contener entre 4 y 30 caracteres.!"
			fi
		else
			echo -e "\nSolo se permite como nombre de usuario,caracteres alfanumericos.!"
		fi
	else
		echo -e "\nEl campo no puede estar vacio!"
	fi




done
}

FuncionNombreHome(){
while true
do
	clear

	echo -e 
	read -p "Ingrese nombre para el home : " NombreHome

	#Revisamos campo vacio
	if ! [ -z "$NombreHome" ]
	then
		#Revisamos que haya ingresado solo carateres alfanumericos
		if [[ -z `echo $NombreHome | tr -d "[:alnum:]"` ]]
		then

			CantidadCaracter=`printf $NombreHome | wc -c`
			#Revisamos que el nombre tenga entre 4 y 30 caracteres
			if [[ $CantidadCaracter -le 30 ]] && [[ $CantidadCaracter -ge 4 ]]
			then
				#Revisamos que no haya espacios
				if [[ `echo $NombreHome | grep " " | wc -l` = 0 ]]
				then 
				
					break
				
				else
					echo -e "\nNo se permite que el nombre del home contenga espacios."
				fi
			else
				echo -e "\nEl nombre debe contener entre 4 y 30 caracteres.!"
			fi
		else
			echo -e "\nSolo se permite como nombre del home ,caracteres alfanumericos.!"
		fi
	else
		echo -e "\nEl campo no puede estar vacio!"
	fi

done
}
FuncionRutaHome(){
while true
do
	read -p "Ingrese ruta del home : " RutaHome
	if [ ! -z $RutaHome ]
	then
		if [ ! `echo "$RutaHome" | egrep "*/$" | wc -l` = "1" ]
		then
			RutaHome=`echo "$RutaHome/"`
		fi
		
		
		if [ ! -d $RutaHome ] 
		then
			echo -e "\nLa ruta especificada no es correcta..."
			sleep 1
		else
			echo "La ruta existe."
			sleep 1
			break
		fi
	else
		echo -e "\nCampo Vacio!.."
		sleep 1
	fi
done
}
#FinFunciones

#RutaHome
while true
do
	FuncionEncabezado
	echo -e "\nDesea especificar una ruta para el home del usuario? s/n (Por defecto '/home') \n"
	read -p "_: " Respuesta

	
		
	if [ -z "$Respuesta" ] || [ "$Respuesta" = "n" ] || [ "$Respuesta" = "N" ] 
	then
		RutaHome="/home"
		break
		
	
	elif [ "$Respuesta" = "s" ] || [ "$Respuesta" = "S" ]
	then
		FuncionRutaHome
		break
	else
		echo -e "\n Opcion Invalida...!"
	fi
	
done


#FinRutaHome
#NombreHome
while true
do
	FuncionEncabezado
	echo -e "\nDesea especificar un nombre para el home del usuario? s/n (Por defecto '$NombreUsuario') \n"
	read -p "_: " Respuesta

	
		
	if [ -z "$Respuesta" ] || [ "$Respuesta" = "n" ] || [ "$Respuesta" = "N" ] 
	then
		NombreHome=`echo "$NombreUsuario"`
		break
		
	
	elif [ "$Respuesta" = "s" ] || [ "$Respuesta" = "S" ]
	then
		FuncionNombreHome
		break
	else
		echo -e "\n Opcion Invalida...!"
	fi
	sleep 1
done
#FinNombreHome
echo "Fin"
sleep 2
exit	

FuncionHome

#d
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


#FinAltaUsuario














