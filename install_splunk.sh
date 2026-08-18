#!/bin/bash

#======================
#Instalacion de Splunk
#======================

echo "================================"
echo "Iniciando instalacion de Splunk"
echo "================================"

#Variables
SPLUNK_URL="https://download.splunk.com/products/splunk/releases/9.3.0/linux/splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb"
SPLUNK_DEB="splunk-9.3.0-51ccf43db5bd-linux-2.6-amd64.deb"
SPLUNK_DIR="/opt/splunk/bin"

#Verificar y limpiar locks de dpkg si quedaron atascados
if sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; then
	echo "[!] dpkg está en uso por otro proceso, esperando..."
	while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
		sleep 2
	done
fi

#Descarga de Splunk
echo "[+] Descargando Splunk..."
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

#Verificar si dpkg tuvo errores (ej. dependencias faltantes) y corregirlos
if [ $? -ne 0 ]; then
	echo "[!] dpkg reportó errores, intentando resolver dependencias..."
	sudo apt-get install -f -y
fi

#Verificar que splunk se instaló
if [ -d "$SPLUNK_DIR" ]; then
	echo "[+] Splunk instalado correctamente"
else
	echo "[-] Error: Splunk no se instaló correctamente"
	exit 1
fi

#Directorio de Splunk
cd "$SPLUNK_DIR" || exit 1

#Habilitarlo como servicio
echo "[+] Habilitando Splunk para iniciar en el arranque"
sudo ./splunk enable boot-start --accept-license

#Iniciar Splunk
echo "[+] Iniciando Splunk"
sudo ./splunk start

#Mensaje final
echo "================================"
echo "Splunk instalado y en ejecución"
echo "================================"
