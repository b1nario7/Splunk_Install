Splunk_Install
🇬🇧 English | 🇪🇸 Español
A Bash script that automates the download and installation of Splunk on a Debian/Ubuntu-based Linux system (uses `dpkg` and `apt`).
What the script does
Downloads the Splunk `.deb` package from the official URL.
Verifies the download completed successfully.
Installs Splunk using `dpkg`.
If `dpkg` fails due to missing dependencies, attempts to fix them automatically.
Verifies the installation was successful.
Enables Splunk to start automatically on boot.
Starts the Splunk service.
Prerequisites
Debian/Ubuntu-based Linux system (uses `dpkg` and `apt`).
`sudo` access.
Internet connection.
`wget` installed.
Usage
Give the script execute permissions and run it:
```bash
chmod +x install_splunk.sh
./install_splunk.sh
```
The script will ask for your `sudo` password to install the package and enable the service.
Verifying that Splunk is running
Once the script finishes, you can check the service status with:
```bash
sudo /opt/splunk/bin/splunk status
```
And access the web interface from your browser at:
```
http://<server-IP>:8000
```
Known issue: dpkg lock
If the script fails during installation with an error like:
```
dpkg: error: dpkg frontend lock was locked by another process with pid XXXX
```
It means another process (e.g. `unattended-upgrades`) has the package manager locked. The script includes an automatic wait for this case, but if the problem persists, you can check manually:
```bash
sudo fuser /var/lib/dpkg/lock-frontend
```
If no process is actively using the lock, you can release it with:
```bash
sudo rm -f /var/lib/dpkg/lock-frontend
sudo dpkg --configure -a
```
⚠️ Never remove the lock file if a real process is using it — doing so can corrupt the package management system.
Notes
The Splunk version and download URL are defined as variables at the top of the script (`SPLUNK_URL`, `SPLUNK_DEB`), so they can easily be updated to install a different version.
This script was tested manually; minor adjustments may be needed depending on the exact Linux distribution or version used.

## Notas

- La versión de Splunk y la URL de descarga están definidas como variables al inicio del script (`SPLUNK_URL`, `SPLUNK_DEB`), por lo que puedes actualizarlas fácilmente para instalar otra versión.
- Este script fue probado de forma manual; puede requerir ajustes menores según la distribución o versión exacta de Linux que uses.
