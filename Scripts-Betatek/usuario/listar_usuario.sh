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
		exit
}
FuncionListar(){
Uid=`cat /etc/login.defs | egrep  "^UID_MIN*" |tr -s " " | cut -f2 -d" "`
TotalLineas=`cat /etc/passwd | wc -l`
Linea=`cat /etc/passwd | egrep -n "$Uid" | cut -f1 -d":"`
let Linea=$Linea-1
let Tail=$TotalLineas-$Linea
cat /etc/passwd | tail -n"$Tail" | cut -f1 -d: | column
echo -e "\n\n"
read -p "Presione una tecla para salir..." basura
}
#FinFunciones
FuncionEncabezado
FuncionListar
FuncionSalir
#FinListarUsuario

