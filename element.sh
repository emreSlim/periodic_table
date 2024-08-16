#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument.\n"
else
  if [[ $1 -gt 0 ]]
  then
    # arg is atomic number
    echo 0
  else
    if [[ $(echo -n $1 | wc -m) -gt 2  ]]
    then
      #arg is name
      echo 1
    else 
      #arg is symbol
      echo 2
    fi
  fi
fi
