#!/bin/bash
# Versión 2.0
# VARIABLES Y FORMATOS
declare -a array_argumentos=("$@")
declare -i var_numero_argumentos=$#
col_yellow='\033[1;33m'
col_red='\033[31m'
nc='\033[0m'
printf "${col_yellow}Ejecutando script ...${nc}\n"

# COMPROBACIÓN DE LA INSTALACIÓN DEL SCRIPT
if [ ! -e "/usr/local/bin/convertir" ]; then
    printf "${col_yellow}No existe el enlace simbólico, así que lo creo.${nc}\n"
    sudo ln -s "$PWD/convertir.sh" /usr/local/bin/convertir
fi

# COMPROBACIÓN DE SI SE HAN INTRODUCIDO ARGUMENTOS
if [ $var_numero_argumentos = 0 ]; then
    printf "${col_red}No has introducido argumentos. Por ejemplo 'convertir *.jpg resultado.pdf'${nc}\n"
    exit 1
fi

# NUEVO: EVITAR SOBREESCRITURA DEL ARCHIVO DE SALIDA
if [ -e "${array_argumentos[-1]}" ]; then
    printf "${col_red}El archivo de salida '%s' ya existe. Abortando para evitar sobrescritura.${nc}\n" "${array_argumentos[-1]}"
    exit 1
fi

# MODIFICO EL ARCHIVO `policy.xml` A FIN DE EVITAR LA LIMITACIÓN DE `convert`
# NUEVO: Usar trap para garantizar la restauración incluso si el script falla
var_policy_file="/etc/ImageMagick-6/policy.xml"
var_policy_backup="${var_policy_file}_tmp_$$"

# Función de limpieza que se ejecutará al salir (normalmente o por error)
cleanup() {
    if [ -f "$var_policy_backup" ]; then
        sudo mv "$var_policy_backup" "$var_policy_file"
    fi
}
trap cleanup EXIT

# Mover el archivo de política original
sudo mv "$var_policy_file" "$var_policy_backup"

# EJECUTO LA ACCIÓN
echo convert "${array_argumentos[@]}"
convert "${array_argumentos[@]}"
var_conversion_status=$?

# El trap se encargará de restaurar el archivo automáticamente
printf "${col_yellow}Conversión aparentemente realizada${nc}\n"
ls -lh "${array_argumentos[-1]}"
exit $var_conversion_status
