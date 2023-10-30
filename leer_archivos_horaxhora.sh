#!/bin/bash
clear;
DIR="/iis/desa/cdc/"
fechas=`ls -ltrh $DIR | awk '{print $6 $7}'  | uniq | sed '/^$/d'`

echo "------------------------------------------"
echo " Tamaño x hora  | Cant. archivos x hora"
echo "------------------------------------------"
acumulado=0
for j in $fechas
  do
  fecha=`date -d $j +%d-%m-%Y`
  echo "------------------------------------------"
  echo              $fecha
  echo "------------------------------------------"
  mes=${j:0:3}
  dia=${j:3:6}
  horas=$(ls -ltrh $DIR |egrep -n "$mes $dia" | awk '{print $8}'  | awk -F: '{print $1}' | uniq | sed '/^$/d')
  acumuladodia=0
  for i in  $horas
      do 
	    suma=0;
            cant_archivos=0
            total=0;
	    archivos=$(ls -l $DIR |grep $dia | grep $i: | tr -s " "| cut -f 5 -d " ");
	    while read bytes
		do
 		  suma=$((suma+bytes));
	          cant_archivos=$((cant_archivos+1))
		done <<< "$archivos"
	   totalGB=$(echo "scale=2; $suma/1073741824" | bc)
	   echo ".- $i hrs: $totalGB GB     |   $cant_archivos";
           #echo "........................................"
	  acumulado=$((suma+acumulado))
	  acumuladodia=$((suma+acumuladodia))

      done
      acumuladodiaGB=$(echo "scale=2; $acumuladodia/1073741824" | bc)
      echo "Total dia $fecha : $acumuladodiaGB"
done 
acumuladoGB=$(echo "scale=2; $acumulado/1073741824" | bc)
echo ""
echo "------------------------------------------"
echo "Total: $acumuladoGB GB"
echo "------------------------------------------"
echo "Cantidad de archivos: $(ls -l $DIR | wc -l)"
echo "------------------------------------------"
echo $(df -h | grep sde1 | awk '{print "Usado:", $5, "de", $2, "en", $6}')
echo "------------------------------------------"
echo " "
