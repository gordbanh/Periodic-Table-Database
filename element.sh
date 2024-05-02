#!/bin/bash

#PSQL statement
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
  #get atomic_number, name, symbol, type, mass, melting point, and boiling point
  ELEMENT_RESULT=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1")
  
  #if not found
  if [[ -z ELEMENT_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    #echo result
    echo "$ELEMENT_RESULT" | while IFS="|" read ELEMENT_ATOMIC_NUMBER ELEMENT_NAME ELEMENT_SYMBOL ELEMENT_TYPE ELEMENT_ATOMIC_MASS ELEMENT_MELTING_POINT ELEMENT_BOILING_POINT
    do
      echo -e "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    done
  fi

elif [[ ! $1 =~ ^[0-9]+$ ]]
then
  #get atomic_number, name, symbol, type, mass, melting point, and boiling point
  ELEMENT_RESULT=$($PSQL "SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
  
  #if not found
  if [[ -z $ELEMENT_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$ELEMENT_RESULT" | while IFS="|" read ELEMENT_ATOMIC_NUMBER ELEMENT_NAME ELEMENT_SYMBOL ELEMENT_TYPE ELEMENT_ATOMIC_MASS ELEMENT_MELTING_POINT ELEMENT_BOILING_POINT
    do
      echo -e "The element with atomic number $ELEMENT_ATOMIC_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
    done
  fi
fi
