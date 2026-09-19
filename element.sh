PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  ELEMENT_INFO=$($PSQL "select * from elements where atomic_number::text='$1' or symbol='$1' or name='$1'")
  IFS="|" read ATOMIC_NUMBER SYMBOL NAME <<< "$ELEMENT_INFO"
  if [[ -z $ELEMENT_INFO ]]
  then
   echo "I could not find that element in the database."
  else
    ATOMIC_MASS=$($PSQL "select atomic_mass from properties where atomic_number='$ATOMIC_NUMBER'")
    MELTING_POINT=$($PSQL "select melting_point_celsius from properties where atomic_number='$ATOMIC_NUMBER'")
    BOILING_POINT=$($PSQL "select boiling_point_celsius from properties where atomic_number='$ATOMIC_NUMBER'")
    TYPE_ID=$($PSQL "select type_id from properties where atomic_number='$ATOMIC_NUMBER'")
    TYPE=$($PSQL "select type from types where type_id='$TYPE_ID'")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi