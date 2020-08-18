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
FuncionListarGrupos(){
Gid=`cat /etc/login.defs | egrep  "^GID_MIN*" |tr -s " " | cut -f2 -d" "`
TotalLineas=`cat /etc/group | wc -l`
Linea=`cat /etc/group | egrep -n "$Gid" | cut -f1 -d":"`
let Linea=$Linea-1
let Tail=$TotalLineas-$Linea
cat /etc/group | tail -n"$Tail" | cut -f1 -d: | column
}
FuncionContrasena(){
while true
do	
	clear
	FuncionEncabezado
	echo -e " Se exige que la contraseña, contenga al menos uno de los siguientes caracteres: 
una letra mayúzcula, una letra minúzcula, un numero , y un signo.\n\n (signos permitidos: '+' '?' '.' '*' '_' '/')\n\n(Ingrese '0' para salir  o '00' Para crear el usuario sin contraseña.)\n\n"
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
	FuncionEncabezado
	echo -e "\nIngrese nombre del usuario.\n(Ingrese '0' para salir)\n"
	read -p "_: " NombreUsuario
	NombreUsuario=`echo $NombreUsuario | tr [:upper:] [:lower:]`
	
	if [ "$NombreUsuario" = 0 ]
	then
		FuncionSalir
	fi
	
	#Revisamos campo vacio
	if ! [ -z "$NombreUsuario" ]
	then
		#Revisamos que haya ingresado solo carateres alfanumericos o guion bajo
		if [[ -z `echo $NombreUsuario |tr -d "_"| tr -d "[:alnum:]"` ]]
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
			echo -e "\nSolo se permite como nombre de usuario,caracteres alfanumericos, ademas del guion bajo(_).!"
		fi
	else
		echo -e "\nEl campo no puede estar vacio!"
	fi
	
	read -p "Presione para continuar" basura



done
}

FuncionNombreHome(){
while true
do
	FuncionEncabezado

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
	FuncionEncabezado
	read -p "Ingrese ruta del home : " RutaHome
	if ! [ -z $RutaHome ]
	then
		if ! [ `echo "$RutaHome" | egrep "*/$" | wc -l` = "1" ]
		then
			RutaHome=`echo "$RutaHome/"`
		fi
		
		
		if ! [ -d $RutaHome ] 
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

FuncionGrupo(){
while true
do
	
	while true
	do
		FuncionEncabezado
		
		echo -e "Desea establecer un grupo primario para el usuario? s/n (Por defecto '$NombreUsuario')\n"
		
		read -p "_: " Respuesta
			if [ "$Respuesta" = "n" ] || [ "$Respuesta" = "N" ] 
		then
			GrupoPrimario=`echo "$NombreUsuario"`
			break 2
				
		elif [ "$Respuesta" = "s" ] || [ "$Respuesta" = "S" ]
		then
			while true
			do

				FuncionEncabezado
				echo "Ingrese grupo:"
				echo -e "(ingrese 0 para utilizar el grupo por defecto, ingrese 00 para volver al Menu Principal.)\n"
				read -p "_: " GrupoPrimario
				if [ -z $GrupoPrimario ]
				then
					echo -e "\nCampo Vacio!.."
				else
					if [ "$GrupoPrimario" = "0" ]
					then
						GrupoPrimario=`echo $NombreUsuario`
						break 2
					elif [ "$GrupoPrimario" = "00" ]
					then
						FuncionSalir
					fi
		
					if [ `cat /etc/group | cut -f1 -d: | grep -x $GrupoPrimario | wc -l` = 1 ]
					then
						break 2
					else
						echo -e "\nEl grupo no existe!.."
												
					fi
				fi
			sleep 1
			done
			
		else
			echo -e "\n Opcion Invalida...!"
		fi
		
		
		sleep 1
	done
	
	#GruposSecundarios
	while true
	do
		FuncionEncabezado
		
		echo -e "Desea agregar el usuario a otros grupos? s/n"
		echo -e "(Grupos actuales del usuario.Primario:'$GrupoPrimario'.Secundario:'$GrupoSecundario')\n"
		
		read -p "_: " Respuesta
			if [ -z "$Respuesta" ] || [ "$Respuesta" = "n" ] || [ "$Respuesta" = "N" ] 
		then
			break 2
				
		elif [ "$Respuesta" = "s" ] || [ "$Respuesta" = "S" ]
		then
			while true
			do

				FuncionEncabezado
				echo "(Grupos secundarios actuales del usuario :'$GrupoSecundario')"
				echo -e "(Ingrese 0 para salir , Ingrese 00 para cancelar los grupos secundarios)"
				echo -e "(Ingrese '*Lista*' para listar los grupos existentes)\n" 
				read -p "Ingrese grupo: " Grupo

						

				if [ -z $Grupo ]
				then
					echo -e "\nCampo Vacio!.."
				elif [ "$Grupo" = "0" ]
				then

					break 3
				elif [ "$Grupo" = "00" ]	
				then
					GrupoSecundario=""
					break 3
				elif [ "$GrupoSecundario" = "*Lista*" ] || [ "$NombreGrupo" = "*lista*" ] || [ "$NombreGrupo" = "*LISTA*" ]
				then
				FuncionListar
				fi	
		
					if ! [ `cat /etc/group | cut -f1 -d: | grep -x $Grupo | wc -l` = 1 ]
					then
						echo -e "\nGrupo Agregado..\n"
						GrupoSecundario=`echo "$GrupoSecundario,$Grupo"`
						while true
						do
							echo -e "Desea agregar otro usuario? s/n"
							read -p "_: " Opcion
							
							case $Opcion in
							s|S)
								break
							;;
							n|N)
								break 4
							;;
							*)
								echo -e "\nOpcion Invalida!..."
								sleep 1
							esac
						done
					else
						echo -e "\nEl grupo no existe!.."
					fi
				fi
			sleep 1
			done
			
		else
			echo -e "\n Opcion Invalida...!"
		fi
		
		
		sleep 1
	done
	
	
done

}
#FinFunciones

#Ejecucion
while true
do
	NombreUsuario=""
	Clave=""
	RutaHome=""
	NombreHome=""
	GrupoPrincipal=""
	GrupoSecundario=""
	#Nombre
	FuncionNombreUsuario
	#FinNombre
	
	#Contraseña
	FuncionContrasena
	#FinContraseña

	#Grupo
	FuncionGrupo
	#FinGrupo
		
	#RutaHome
	while true
	do
		FuncionEncabezado
		echo -e "\nDesea especificar una ruta para el home del usuario? s/n (Por defecto '/home/') \n"
		read -p "_: " Respuesta

		
			
		if [ "$Respuesta" = "n" ] || [ "$Respuesta" = "N" ] 
		then
			RutaHome="/home/"
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

		
			
		if [ "$Respuesta" = "n" ] || [ "$Respuesta" = "N" ] 
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
	
	#EjecutarAlta
	while true
	do
		Home=`echo "-d $RutaHome$NombreHome -m"`

		if [ $GrupoPrimario = $NombreUsuario ]
		then
			if [ `cat /etc/group | cut -f1 -d: | grep -x $GrupoPrimario | wc -l` = 1 ]
			then
				a=1
				GrupoP=`echo "-g $GrupoPrimario"`
			else
				#el grupo no existe
				a=0
				sudo groupadd ${GrupoPrimario}
				if ! [ $? = 0 ]
				then
					echo -e "\nNo se pude crear el usuario, porque no se pudo crear el grupo '$GrupoPrincipal'"
					sleep 1
					while true
					do					
						echo -e "\nIngrese '1'  para cambiar el grupo o '0' para cancelar alta y volver al Menu Principal"
						read -p "_: " Opcion

						case Opcion in
						1)
							while true
							do

								FuncionEncabezado
								echo "Ingrese grupo:"
								echo -e "(Ingrese 00 para volver al Menu Principal.)\n"
								read -p "_: " GrupoPrimario

								if [ -z $GrupoPrimario ]
								then
									echo -e "\nCampo Vacio!.."
								
								elif [ "$GrupoPrimario" = "00" ]
								then
									FuncionSalir
								
								fi
						
								if [ `cat /etc/group | cut -f1 -d: | grep -x $GrupoPrimario | wc -l` = 1 ]
								then
									break 2
								else
									echo -e "\nEl grupo no existe!.."
									
								fi
							sleep 1
							done
						;;
						0)
							FuncionSalir
						;;
						*)
							echo -e "\nOpcion Invalida!..."
						esac
					done
				fi
	
			fi
		else
			GrupoP=`echo "-g $GrupoPrimario"`
		fi
		
		if [ -z $GrupoSecundario ]
		then
			GrupoS=""
		else
			GrupoS=`echo "-G $GrupoSecundario"`
		fi

		while true
		do
			echo "$GrupoP"
			read basura
			sudo useradd  ${GrupoP} ${GrupoS} ${Home} ${NombreUsuario}

			if [ $? = 0 ]
			then
				sudo echo "$NombreUsuario:$clave" | chpasswd
				if [ $? = 0 ]
				then
					echo "Se ha creado el usuario correctamente"
								
				else
					echo "El usuario se ha creado sin contraseña, intente ingresar la contraseña manualmente."
					
				fi
				
			else
				echo "No se creo el usuario"
				if [ "$a" = 0 ]
				then
					sudo grupdel ${GrupoPrimario}

					if ! [ $? = 0 ]
					then
						echo "El grupo $GrupoPrincipal no se ha podido elimiar. Se debera eliminar manualmente."
					
					fi
				fi
			fi
			read -p "Presione una tecla para continuar..." basura
			while true
			do
				read -p "presione tecla" basura

				FuncionEncabezado
				echo -e "Desea agregar otro usuario? s/n "
				read -p "_: " Opcion
				
				case "$Opcion" in
				s|S)
					break 3
				;;
				n|N)
					FuncionSalir
				;;
				*)
					echo -e "\n Opcion Incorrecta!"
				esac
			done
		done
			#FinEjecutarAlta
	done	
done
#FinEjecucion





#FinAltaUsuario














