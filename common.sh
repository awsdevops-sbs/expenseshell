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

app_pre(){


  Print_Task_Heading "Clean old content"
  rm -rf ${app_dir} &>>$Log
  check_status $?

  Print_Task_Heading "Create App Directory "
  mkdir ${app_dir} &>>$Log
  check_status $?

  Print_Task_Heading "Download App Content"
  curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$Log
  check_status $?



  Print_Task_Heading "Extract App content"
   cd ${app_dir} &>>$Log
  unzip /tmp/${component}.zip &>>$Log
  check_status $?



}