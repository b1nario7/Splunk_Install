#!/bin/bash

#======================
#Instalacion de Splunk
#======================

echo "================================"
echo "Iniciando intalacion de Splunk"
echo "================================"

#Variables
SPLUNK_URL="https://download.splunk.com/products/splunk/releases/9.3.0/linux/splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb"
SPLUNK_DEB="splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb"
SPLUNK_DIR="/opt/splunk/bin"

#Descarga de Splunk
echo "[+] Descargando Spluk..."
wget -O "$SPLUNK_DEB" "$SPLUNK_URL"

#Verificacion del archivo descargado
if [ -f "$SPLUNK_DEB" ]; then
	echo "[+] Archivo descargado correctamente"
else
	echo "[-] Error: El archivo de Splunk no se descargó."
	exit 1
fi

#Instalar Splunk
echo "[+] Instalando Splunk"
sudo dpkg -i "$SPLUNK_DEB"

#Verificar que splunk se instaló
if [ -d "$SPLUNK_DIR" ]; then
	echo "[+] Splunk instalado correctamente"
else
	echo "[-] Error: Splunk no se instalo correctamente"
	exit 1
fi

#Directorio de Splunk
cd "$SPLUNK_DIR" || exit 1

#Habilitarlo como servicio
echo " [+] Habilitando Splunk para iniciar el arranque"
sudo ./splunk enable boot-start --accept-license

#Iniciar Splunk
echo "[+] Iniciando Splunk"
sudo ./splunk start

#Mensaje final
echo "================================"
echo "Splunk instalado y en ejecución"
echo "================================"

