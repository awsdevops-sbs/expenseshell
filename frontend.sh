source common.sh
component=frontend
app_dir=/usr/share/nginx/html/*

Print_Task_Heading "Install Nginx"
dnf install nginx -y &>>$Log
check_status $?

Print_Task_Heading "Copy Expense config "
cp expense.conf /etc/nginx/default.d/expense.conf &>>$Log
check_status $?

app_pre

Print_Task_Heading "Enable and reStart Nginx service"
systemctl enable nginx &>>$Log
systemctl restart nginx &>>$Log
check_status $?