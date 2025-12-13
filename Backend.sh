source common.sh
component=backend
app_dir=/app
mysql_password=$1

if [ -z "${mysql_password}" ]; then

  Print_Task_Heading "Password Missing"
  exit 1
   fi

Print_Task_Heading "Disable default Nodejs version"
dnf module disable nodejs -y &>>$Log
check_status $?

Print_Task_Heading "Enable nodejs module for v20  "
dnf module enable nodejs:20 -y &>>$Log
check_status $?

Print_Task_Heading "Install NodeJS"
dnf install nodejs -y &>>$Log
check_status $?

Print_Task_Heading "Add Application User"

id expense &>>$Log

if [ $? -ne 0 ]; then

   useradd expense &>>$Log

   fi

check_status $?

Print_Task_Heading "Copy Backend service file"
cp backend.service /etc/systemd/system/backend.service
check_status $?

app_pre



Print_Task_Heading "Download NodeJS Dependencies"
cd /app &>>$Log
npm install &>>$Log
check_status $?

Print_Task_Heading "Start backend service"
systemctl daemon-reload &>>$Log
systemctl enable backend &>>$Log
systemctl start backend &>>$Log
check_status $?

Print_Task_Heading "Install mysql Client"
dnf install mysql -y &>>$Log
check_status $?

Print_Task_Heading "Load Sechma"
mysql -h mysql-dev.awsdevops.sbs -uroot -p${mysql_password} < /app/schema/backend.sql

check_status $?