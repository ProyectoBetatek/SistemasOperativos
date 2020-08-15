#!/bin/bash
#Betatek
#ListarGrupo
#Funciones
FuncionEncabezado(){
clear
echo -e "\n\t\t--Listar Grupos--\n\n\n"

}
FuncionSalir(){
		clear 
		sleep 1
		exit
}
#FinFunciones
FuncionEncabezado
Gid=`cat /etc/login.defs | egrep  "^GID_MIN*" |tr -s " " | cut -f2 -d" "`
#echo "gid $Gid"
TotalLineas=`cat /etc/group | wc -l`
#echo "$TotalLineas"
Linea=`cat /etc/group | egrep -n "$Gid" | cut -f1 -d":"`
let Linea=$Linea-1
let Tail=$TotalLineas-$Linea

cat /etc/group | tail -n"$Tail" | cut -f1 -d: | column
echo -e "\n\n"
read -p "Presione una tecla para salir..." basura
FuncionSalir
#FinListarGrupo

