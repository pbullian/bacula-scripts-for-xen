#!/bin/bash

PRENDIO="false";
IP=$1
NOMBRE=$2
VOL=$3
IMAGEN=$4
ARCHIVO_CREACION=$5
count=0
CARPETA_BACKS=/backups
XENPWD=/etc/xen/apagadas

#borro la imagen creada
rm -rf $CARPETA_BACKS/$IMAGEN.img.gz

xm create $XENPWD/$ARCHIVO_CREACION

#espero hasta que aparesca o hasta que pasen 2 minutos
while [ "$PRENDIO" != "true" -o $count = 90 ] 
do
  if [[ -n $(xm list|grep $NOMBRE) ]]; then
        PRENDIO="true";
  else
	PRENDIO="false";
	count=$(($count + 1));
  fi
sleep 2;
done

if [ "$PRENDIO" != "true" ];then
#printf "\n\nerror\n\n"
  exit 1
else
#printf "\n\nok\n\n"
  exit 0
fi
