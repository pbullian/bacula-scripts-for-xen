#!/bin/bash

#
#PABLO B. pbullian@unsam.edu.ar
#

APAGO="false";

#esto se deberia de tomar de un archivo de propiedades
NOMBRE=$2
IP=$1
VOL=$3
IMAGEN=$4
USER=$5
CARPETA_BACKS=/backups
count=0
#
#FUN BEGINSSS

#apago la machine
ssh $USER@$IP 'halt'

#espero hasta que desaparezca o 3 min
while [ "$APAGO" != "true" -o $count = 90 ] 
do
  if [[ -n $(xm list|grep $NOMBRE) ]]; then
	APAGO="false";
	count=$(($count + 1))
  else
	APAGO="true";
  fi
sleep 2;
done

if [ "$APAGO" != "true" ];then
  exit 1;
fi

#una vez que apago, comprimo la imagen
dd if=/dev/$VOL/$IMAGEN | gzip -c --fast | dd of=$CARPETA_BACKS/$IMAGEN.img.gz

#si todo fallo, me tiro a un pozo y devuelvo 1
if [[ -n $(ls $CARPETA_BACKS |grep $IMAGEN) ]]; then
	exit 0;
else
	exit 1;
fi
