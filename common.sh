Log=/tmp/expense.log

Print_Task_Heading(){

  echo $1
  echo "#################$1###############" &>>$Log

}

check_status(){

  if [ $1 -eq 0 ]; then

  echo -e "\e[32mSuccess\e[0m"
    else
  echo -e "\e[31mFail\e[0m"

  exit 2

    fi
}