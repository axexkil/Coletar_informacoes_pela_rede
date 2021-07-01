@echo off
: start
setlocal EnableExtensions
setlocal EnableDelayedExpansion
SET /p ip="Digite o ip da maquina: "

wmic /node:"!ip!" /user:"/*DIGITE O USUARIO/*" /password:"/*DIGITE A SENHA/*" computersystem get name |find /n "0">var0.tmp
if %errorlevel% EQU 0 (
	set /p tmp0=<var0.tmp
	set valor0=!tmp0:~3!
	echo Host Name = !valor0!
	del var0.tmp
	
	wmic /node:"!ip!" /user:"/*DIGITE O USUARIO/*" /password:"/*DIGITE A SENHA/*" csproduct get version |find /n "2">var.tmp
	set /p tmp=<var.tmp
	set valor=!tmp:~3!
	echo Modelo = !valor!
	del var.tmp
	
	wmic /node:"!ip!" /user:"/*DIGITE O USUARIO/*" /password:"/*DIGITE A SENHA/*" csproduct get vendor |findstr /v /i "vendor">var4.tmp
	set /p tmp4=<var4.tmp
	echo Marca = !tmp4!
	del var4.tmp
	
	wmic /node:"!ip!" /user:"/*DIGITE O USUARIO/*" /password:"/*DIGITE A SENHA/*" bios get serialnumber |find /n "0">var2.tmp
	set /p tmp2=<var2.tmp
	set valor2=!tmp2:~3!
	echo Numero de Serie = !valor2!
	del var2.tmp
	
	wmic /node:"!ip!" /user:"/*DIGITE O USUARIO/*" /password:"/*DIGITE A SENHA/*" path Win32_NetworkAdapter get MacAddress |find /n "1">var3.tmp
	set /p tmp3=<var3.tmp
	set valor3=!tmp3:~3,17!
	echo MAC = !valor3!
	del var3.tmp
	
) else (
	echo Maquina esta Desligada!
	del var0.tmp
)
echo  ___  ___       
echo  )_    )   )\/) 
echo (    _(_  (  (  
echo .

goto:start