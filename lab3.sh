#!/bin/bash

table_name=""
counter=0
var1=""
while IFS= read -r line
do
if [[ "$counter" == 0 ]] ; then
  table_name=${line//[[:blank:]]/}
elif [[ "$counter" == 1 ]] ; then
  var1="INSERT INTO $table_name(${line//[[:blank:]]/}) VALUES"
else
  echo "$var1" >> sql_sqript.sql
  var1='('${line//[[:blank:]]/}'),'
fi
((counter++))
done < table.csv
echo ${var1::-1}';' >> sql_sqript.sql

