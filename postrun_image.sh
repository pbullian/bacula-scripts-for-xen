#!/bin/bash

PRENDIO="false";
IP=$2
NOMBRE=$1
VOL=$3
IMAGEN=$4
count=0

#borro la imagen creada
rm -rf /backs_tmp/'$IMAGEN'.img.gz

xm create /etc/xen/auto/$NOMBRE

#espero hasta que aparesca o hasta que pasen 2 minutos
while [ "$PRENDIO" != "false" -o $count = 90 ] 
do
  if [[ -n $(xm list|grep $NOMBRE) ]]; then
        APAGO="false";
	count=$(($count + 1));
  else
	APAGO="true";
  fi
sleep 2;
done

if [ $count = 90 ];then
  exit 1
else
  exit 0
fi
