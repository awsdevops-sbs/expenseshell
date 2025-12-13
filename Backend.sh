source common.sh

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


Print_Task_Heading "Clean old content"
rm -rf /app/* &>>$Log
check_status $?

Print_Task_Heading "Create App Directory "
mkdir /app &>>$Log
check_status $?

Print_Task_Heading "Download App Content"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>$Log
check_status $?

cd /app &>>$Log

Print_Task_Heading "Extract App content"
unzip /tmp/backend.zip &>>$Log
check_status $?

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
mysql -h 172.31.71.114 -uroot -p${mysql_password} < /app/schema/backend.sql