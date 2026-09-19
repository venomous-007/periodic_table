PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

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