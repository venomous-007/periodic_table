PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  ELEMENT_INFO=$($PSQL "select * from elements where atomic_number::text='$1' or symbol='$1' or name='$1'")