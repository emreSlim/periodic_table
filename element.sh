#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

print_info(){
  read an bar nm bar sb bar tp bar am bar mp bar bp <<< $($PSQL "
    select atomic_number,
    name,
    symbol,
    type,
    atomic_mass,
    melting_point_celsius,
    boiling_point_celsius
    from elements 
    left join properties using(atomic_number) 
    left join types using(type_id)
    where $1
    ")

    if [[ -n $an ]]
    then
      echo "The element with atomic number $an is $nm ($sb). It's a $tp, with a mass of $am amu. $nm has a melting point of $mp celsius and a boiling point of $bp celsius."
    else
      echo "I could not find that element in the database."
    fi
}

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  if [[ $1 -gt 0 ]]
  then
    # arg is atomic number
    print_info "atomic_number = $1"
  else
    if [[ $(echo -n $1 | wc -m) -gt 2  ]]
    then
      #arg is name
       print_info "name = '$1'"
    else 
      #arg is symbol
       print_info "symbol = '$1'"
    fi
  fi
fi
