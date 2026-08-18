[README.md](https://github.com/user-attachments/files/31161370/README.md)
# Splunk_Install

Script en Bash para automatizar la descarga e instalación de Splunk en un sistema Linux basado en Debian/Ubuntu (usa `dpkg` y `apt`).

## ¿Qué hace el script?

1. Descarga el paquete `.deb` de Splunk desde la URL oficial.
2. Verifica que la descarga se haya completado correctamente.
3. Instala Splunk usando `dpkg`.
4. Si `dpkg` falla por dependencias faltantes, intenta corregirlo automáticamente.
5. Verifica que la instalación haya sido exitosa.
6. Habilita Splunk para que inicie automáticamente al arrancar el sistema.
7. Inicia el servicio de Splunk.

## Requisitos previos

- Sistema Linux basado en Debian/Ubuntu (usa `dpkg` y `apt`).
- Acceso a `sudo`.
- Conexión a internet.
- `wget` instalado.

## Uso

Dale permisos de ejecución al script y córrelo:

```bash
chmod +x install_splunk.sh
./install_splunk.sh
```

El script pedirá tu contraseña de `sudo` para instalar el paquete y habilitar el servicio.

## Verificar que Splunk está corriendo

Una vez finalizado el script, puedes comprobar el estado del servicio con:

```bash
sudo /opt/splunk/bin/splunk status
```

Y acceder a la interfaz web desde el navegador en:

```
http://<IP-del-servidor>:8000
```

## Problema conocido: dpkg lock

Si el script falla en la etapa de instalación con un error como:

```
dpkg: error: dpkg frontend lock was locked by another process with pid XXXX
```

Significa que otro proceso (por ejemplo `unattended-upgrades`) tiene bloqueado el gestor de paquetes. El script incluye una espera automática para este caso, pero si el problema persiste, puedes revisar manualmente:

```bash
sudo fuser /var/lib/dpkg/lock-frontend
```

Si no hay ningún proceso activo usando el lock, puedes liberarlo con:

```bash
sudo rm -f /var/lib/dpkg/lock-frontend
sudo dpkg --configure -a
```

⚠️ Nunca elimines el archivo de lock si hay un proceso real usándolo — puede corromper el sistema de paquetes.

## Notas

- La versión de Splunk y la URL de descarga están definidas como variables al inicio del script (`SPLUNK_URL`, `SPLUNK_DEB`), por lo que puedes actualizarlas fácilmente para instalar otra versión.
- Este script fue probado de forma manual; puede requerir ajustes menores según la distribución o versión exacta de Linux que uses.
