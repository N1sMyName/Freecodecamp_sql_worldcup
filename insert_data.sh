#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games,teams;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
 if [[ $YEAR != "year" ]]
 then
  INSERTED_TEAM=$($PSQL "INSERT INTO teams(name) values('$OPPONENT')");
  INSERTED_TEAM=$($PSQL "INSERT INTO teams(name) values('$WINNER')");
  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
 if [[ $YEAR != "year" ]]
 then
    WINNER_ID=$($PSQL "select team_id from teams where name = '$WINNER'");
  OPPONENT_ID=$($PSQL "select team_id from teams where name = '$OPPONENT'");
  echo $WINNER_ID VS $OPPONENT_ID;
  echo $WINNER VS $OPPONENT;
  INSERTED_GAME=$(
    $PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals)
     values($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)");
    echo $INSERTED_GAME;
  fi
done


