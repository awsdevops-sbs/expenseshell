Log=/tmp/expense.log

Print_Task_Heading(){

  echo $1
  echo "#################$1###############" &>>$Log

}

check_status(){

  if [ $1 -eq 0 ]; then

  echo -e "\e[31m Success [0m\e" &>>$Log
    else
  echo -e "\e[32m Fail [0m\e" &>>$Log

  exit 2

    fi
}