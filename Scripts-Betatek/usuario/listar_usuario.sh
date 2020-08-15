#!/bin/bash
#Betatek
#ListarUsuario
#Funciones
FuncionEncabezado(){
clear
echo -e "\n\t\t--Listar Usuarios--\n\n\n"

}
FuncionSalir(){
		clear 
		sleep 1
		exit
}
#FinFunciones
FuncionEncabezado
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
#FinListarUsuario

