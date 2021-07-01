@echo off
if not exist sfk.exe (
	echo Arquivo SFK.exe nao encontrado.
	goto:fim
)
setlocal EnableExtensions
setlocal EnableDelayedExpansion
SET /p user=*DIGITE O USUARIO*: 
SET /p senha=*DIGITE A SENHA*: 
cls
	
: start
	SET /p ip="Digite o IP/HOSTNAME da maquina: "
	wmic /node:!ip! /user:%user% /password:%senha% computersystem get name |find /n "0">var0.tmp
	if %errorlevel% EQU 0 (
		set /p tmp0=<var0.tmp
		set valor0=!tmp0:~3!
		echo Host Name = !valor0!
		del var0.tmp
		
		wmic /node:!ip! /user:%user% /password:%senha% csproduct get version |find /n "2">var.tmp
		set /p tmp=<var.tmp
		set valor=!tmp:~3!
		echo Modelo = !valor!
		del var.tmp
		
		wmic /node:!ip! /user:%user% /password:%senha% csproduct get vendor |findstr /v /i "vendor">var1.tmp
		set /p tmp1=<var1.tmp
		echo Marca = !tmp1!
		del var1.tmp
		
		wmic /node:!ip! /user:%user% /password:%senha% bios get serialnumber |find /n "0">var2.tmp
		set /p tmp2=<var2.tmp
		set valor2=!tmp2:~3!
		echo Numero de Serie = !valor2!
		del var2.tmp
		
		wmic /node:!ip! /user:%user% /password:%senha% path Win32_NetworkAdapter get MacAddress |find /n "1">var3.tmp
		set /p tmp3=<var3.tmp
		set valor3=!tmp3:~3!
		echo MAC = !valor3!
		del var3.tmp
		
		wmic /node:!ip! /user:%user% /password:%senha% cpu get name |find /n "0">var4.tmp
		set /p tmp4=<var4.tmp
		set valor4=!tmp4:~3!
		echo Processador = !valor4!
		del var4.tmp

		wmic /node:!ip! /user:%user% /password:%senha% memorychip get capacity|sfk filter -no-empty-lines +count  +calc "#text-1" +tofile Count.tmp
		set /p CNT=<Count.tmp
		wmic /node:!ip! /user:%user% /password:%senha% memorychip get capacity|sfk filter -no-empty-lines -line=2 +calc "#text/1024/1024/1024*!CNT!" -dig=0 +filt -format "$col1 GB" +tofile var5.tmp
		set /p Memoria=<var5.tmp
		echo Quantidade Memoria = !Memoria!
		wmic /node:!ip! /user:%user% /password:%senha% MEMORYCHIP get capacity|sfk filter -no-empty-lines +count  +calc "#text-1" +tofile Pentes.tmp
		set /p NumPentes=<Pentes.tmp
		echo Num de Pentes = !NumPentes!
		del Count.tmp
		del Pentes.tmp
		del var5.tmp
		
		wmic /node:!ip! /user:%user% /password:%senha% diskdrive get size |sfk filter -line=2 +calc "#text/1024/1024/1024" -dig=0 +tofile var6.tmp
		set /p disk1=<var6.tmp
		echo Tamanho do HD = !disk1! GB
		del var6.tmp
		
		
	) else (
		echo Maquina esta Desligada ou IP/HOSTNAME INCORRETO!
		del var0.tmp
	)
echo  ___  ___       
echo  )_    )   )\/) 
echo (    _(_  (  (  
echo.
goto:start
:fim
pause