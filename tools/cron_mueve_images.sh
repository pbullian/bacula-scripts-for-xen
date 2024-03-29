#!/bin/bash

#
#copia las imagenes logicas al storage
#

#
STORAGE=192.168.1.1
PATH_STORAGE=/storage/images_a_mano/
PATH_XEN_VM=/etc/xen/*



if [ -z $1 ] || [ -z $2 ] ; then
printf "USO: script.sh [nombre del lvm o imagen] [nombre del volumen]\nBy: PB [pbullian@unsam.edu.ar]\n"
exit 1
else

	if [ -z $3 ]; then
		ENCONTRADO=$( grep -R $1 $PATH_XEN_VM );
		if [ -n "$ENCONTRADO" ]; then
			printf "\n\nCUIDADO: esta imagen posiblemente se este usando, verificar o agregar una f al final del comando \n\"script.sh [lvm] [nombre del volumen] f\"\nBy: PB [pbullian@unsam.edu.ar]\n"
			printf "\n----\nDonde se encontro:\n $ENCONTRADO\n----\n"
			exit 1
		else
	                printf "\nCopiando..."
			dd if=/dev/$2/$1 | gzip -c --fast | ssh root@$STORAGE 'dd of='$PATH_STORAGE''$1'.img.gz'
		fi
	else
		printf "\nForzado activado:\nCopiando..."
                dd if=/dev/$2/$1 | gzip -c --fast | ssh  root@$STORAGE 'dd of='$PATH_STORAGE''$1'.img.gz'  

	fi
fi

