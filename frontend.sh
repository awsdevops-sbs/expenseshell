source common.sh

Print_Task_Heading "Install Nginx"
 dnf install nginx -y &>>$Log
check_status $?

Print_Task_Heading "Start Nginx service"
 systemctl enable nginx &>>$Log
 systemctl start nginx &>>$Log
check_status $?

Print_Task_Heading "Clean old app content"
 rm -rf /usr/share/nginx/html/* &>>$Log
 check_status $?

 Print_Task_Heading "Download app content"
 curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$Log
check_status $?

Print_Task_Heading "Copy Expense config "
cp expense.conf /etc/nginx/default.d/expense.conf &>>$Log
check_status $?

Print_Task_Heading "Extract app Content "
 cd /usr/share/nginx/html &>>$Log
 unzip /tmp/frontend.zip &>>$Log

check_status $?

Print_Task_Heading "Restart nginx"
 systemctl restart nginx &>>$Log

 check_status $?