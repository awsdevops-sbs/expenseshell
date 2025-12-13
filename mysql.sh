source common.sh
mysql_password=$1

if [ -z "${mysql_password}" ]; then
  Print_Task_Heading "Password Missing"
  exit 1
 fi

Print_Task_Heading "Install mysql server"
dnf install mysql-server -y &>>$Log
check_status $?

Print_Task_Heading "Start mysql server"
systemctl enable mysqld &>>$Log
systemctl start mysqld &>>$Log
check_status $?

Print_Task_Heading "Connect Mysql server"
echo 'show databases' | mysql -h mysql-dev.awsdevops.sbs -uroot -p${mysql_password} &>>$Log
if [ $? -ne 0 ]; then
  mysql_secure_installation --set-root-pass ${mysql_password} &>>$Log
fi
check_status $?