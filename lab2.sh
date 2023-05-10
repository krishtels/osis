lab2.sh
#!/bin/bash
field=(- - - - - - - - -)
team="x"

while true
do
  clear
  if [ $team == "o" ]; then
    echo "Turn o"
  else
    echo "Turn x"
  fi
  echo -e "\n ${field[0]}|${field[1]}|${field[2]}"
  echo " ${field[3]}|${field[4]}|${field[5]}"
  echo -e " ${field[6]}|${field[7]}|${field[8]}\n"

  while true
  do
      echo "Cell number:"
      read turn
      if ((turn >= 0 && turn <= 9)); then

        if (( $turn == 0 )); then
          echo -e "Turn: $team \n ${field[0]}|${field[1]}|${field[2]}\n ${field[3]}|${field[4]}|${field[5]}\n ${field[6]}|${field[7]}|${field[8]}" > Screenshot.txt
          echo "Board saved."
          continue
        fi
        turn=$((turn-1))

        if [ ${field[turn]} == "-" ]; then
          field[turn]=$team
          break
        else
          echo "Error: Cell is occupied."
        fi
      else
        echo "Error: Wrong input."
      fi
  done

  if [[ ${field[0]} == $team && ${field[1]} == $team && ${field[2]} == $team ]] ||
     [[ ${field[3]} == $team && ${field[4]} == $team && ${field[5]} == $team ]] ||
     [[ ${field[6]} == $team && ${field[7]} == $team && ${field[8]} == $team ]] ||
     [[ ${field[0]} == $team && ${field[3]} == $team && ${field[6]} == $team ]] ||
     [[ ${field[1]} == $team && ${field[4]} == $team && ${field[7]} == $team ]] ||
     [[ ${field[2]} == $team && ${field[5]} == $team && ${field[8]} == $team ]] ||
     [[ ${field[0]} == $team && ${field[4]} == $team && ${field[8]} == $team ]] ||
     [[ ${field[2]} == $team && ${field[4]} == $team && ${field[6]} == $team ]]; then
    clear
    echo "Winner: $team"
    echo "${field[0]}|${field[1]}|${field[2]}"
    echo "${field[3]}|${field[4]}|${field[5]}"
    echo "${field[6]}|${field[7]}|${field[8]}"
    break
  fi

  if [[ ${field[0]} != "-" && ${field[1]} != "-" && ${field[2]} != "-" ]] &&
     [[ ${field[3]} != "-" && ${field[4]} != "-" && ${field[5]} != "-" ]] &&
     [[ ${field[6]} != "-" && ${field[7]} != "-" && ${field[8]} != "-" ]]; then
    clear
    echo "draw"
    echo "${field[0]}|${field[1]}|${field[2]}"
    echo "${field[3]}|${field[4]}|${field[5]}"
    echo "${field[6]}|${field[7]}|${field[8]}"
    break
  fi

  if [ $team == "o" ]; then
    team="x"
  else
    team="o"
  fi
done
