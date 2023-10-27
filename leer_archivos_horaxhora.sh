#!/bin/bash
clear;
DIR="/iis/desa/cdc/"
horas=`ls -ltrh $DIR | awk '{print $8}'  | awk -F: '{print $1}' | uniq | sed '/^$/d'`
echo "---------------------------------"
echo "Tamaño x hora"
echo "---------------------------------"
let acumulado=0
for i in  $horas
	do 
	    suma=0;
        total=0;
		archivos=$(ls -l $DIR | grep $i: | tr -s " "| cut -f 5 -d " ");
		#echo archivos $archivos
	while read bytes
		do
  			suma=$((suma+bytes));
		done <<< "$archivos"
	totalGB=$(echo "scale=2; $suma/1073741824" | bc)
	echo ".- $i hrs: $totalGB GB";

	acumulado=$((suma+acumulado))

done
acumuladoGB=$(echo "scale=2; $acumulado/1073741824" | bc)
echo "---------------------------------"
echo "Total: $acumuladoGB GB"
echo "---------------------------------"
echo "Cantidad de archivos: $(ls -l $DIR | wc -l)"
echo "---------------------------------"
echo $(df -h | grep sde1 | awk '{print "Usado:", $5, "de", $2, "en", $6}')
echo "---------------------------------"
echo " "
