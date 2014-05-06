#!/bin/bash

#
#PABLO B. pbullian@unsam.edu.ar
#

APAGO="false";

#esto se deberia de tomar de un archivo de propiedades
NOMBRE=$1
IP=$2
VOL=$3
IMAGEN=$4
USER=$5
CARPETA_BACKS=/backs
count=0
#
#FUN BEGINSSS

#apago la machine
ssh $USER@$IP 'halt'

#espero hasta que desaparezca o 3 min
while [ "$APAGO" != "false" -o $count = 90 ] 
do
  if [[ -n $(xm list|grep $NOMBRE) ]]; then
	APAGO="true";
	count=$(($count + 1))
  fi
sleep 2;
done

#una vez que apago, comprimo la imagen
dd if=/dev/$VOL/$IMAGEN | gzip -c --fast | dd of='$CARPETA_BACKS'/'$IMAGEN'.img.gz

#si todo fallo, me tiro a un pozo y devuelvo 1
if [[ -n $(ls $CARPETA_BACKS |grep $IMAGEN) ]]; then
	exit 1;
else
	exit 0;
fi
