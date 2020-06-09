# convertir.sh

###### Script para saltar los errores de permisos al crear archivos PDF y otros.

Se trata de un script muy simple para facilitar el uso del comando `convert` pues en algunas versiones de Ubuntu da unos errores de permisos al tratar de crear archivos PDF e igualmente con algunos otros tipos de archivos.

Para evitar el error se puede renombrar el archivo `/etc/ImageMagick-6/policy.xml` con permisos de administrador y tras usar el comando `convert` volverlo a restaurar a su estado inicial.

## Instalación

Su instalación es muy sencilla, se descarga el script `convertir.sh` situándolo preferiblemente en tu carpeta de scripts `$HOME/scripts` aunque puede ser en cualquier otra carpeta. Y desde ahí lo ejecutas una primera vez y te pedirá permiso de administrador para instalarse y poder renombrar el archivo `policy.xml`:

```bash
./convertir.sh
```

Si es la primera vez que se ejecuta, creará un enlace simbólico en `/usr/bin` y a partir de ese momento lo podrás ejecutar en cualquier momento exactamente como el mismísimo comando `convert`:

```bash
convertir *.jpg resultado.pdf
```

## Errores conocidos

Al hacer el enlace con el script, se realiza con el comando `ln -s` en lugar de `ln -f` porque en el ordenador del desarrollador principal con el enlace fuerte daba error (sin una explicación clara). Aunque este error no afecta si no vas a modificar el script, lo que sería muy raro que necesitaras.

## About convertir.sh

Versiones 1.0 a 1.1
Creador Jesús Abad
Fecha 09-06-2020
Web https://que-cosas.blogspot.com
Con la ayuda del grupo de Telegram **Shell_Cli_Bash_Scripting** (https://t.me/shell_cli_bash_scripting)
