#!/bin/bash
dateAndTime=$(date "+Дата: %D%nТекущее Время: %T")
timeWork=$(uptime -p)
process=$(ps -e --format="pid")
str="PID"
count=0
for var in $process
do
if [ $str != $var ]
then
count=$(( $count + 1 ))
fi
done
echo "Имя пользователя: $USER" > $1
echo "$dateAndTime" >> $1
echo "Текущий каталог: $PWD" >> $1
echo "Число всех запущенных процессов в системе: $count" >> $1
echo "Время работы: $timeWork" >> $1
echo "finish"
