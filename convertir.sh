#!/bin/bash
# Versión 1.1
# VARIABLES Y FORMATOS
declare -a array_argumentos=($@)
declare -i var_numero_argumentos=$#
col_yellow='\033[1;33m'
col_red='\033[31m'
nc='\033[0m'

printf "${col_yellow}Ejecutando script ...${nc}\n"

# COMPROBACIÓN DE LA INSTALACIÓN DEL SCRIPT
if [ ! -e "/usr/bin/convertir" ]; then
        printf "${col_red}No existe el enlace simbólico, así que lo creo.${nc}\n"
        sudo ln -s $PWD/convertir.sh /usr/bin/convertir
fi

# COMPROBACIÓN DE SI SE HAN INTRODUCIDO ARGUMENTOS
if [ $var_numero_argumentos = 0 ]; then
        printf "${col_red}No has introducido argumentos. Por ejemplo 'convertir *.jpg resultado.pdf'${nc}\n"
        exit 1
fi

# MODIFICO EL ARCHIVO `policy.xml` A FIN DE EVITAR LA LIMITACIÓN DE `convert`
sudo mv /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml_tmp

# EJECUTO LA ACCIÓN
echo convert ${array_argumentos[@]}
convert ${array_argumentos[@]}

# RECUPERO EL ARCHIVO `policy.xml` PARA DEJAR LAS RESTRICCIONES COMO ESTABAN
sudo mv /etc/ImageMagick-6/policy.xml_tmp /etc/ImageMagick-6/policy.xml

printf "${col_yellow}Conversión aparentemente realizada${nc}\n"
ls ${array_argumentos[-1]}
exit 0
