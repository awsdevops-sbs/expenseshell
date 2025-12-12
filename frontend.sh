 dnf install nginx -y &>>/tmp/log.txt
 systemctl enable nginx &>>/tmp/log.txt
 systemctl start nginx &>>/tmp/log.txt

 rm -rf /usr/share/nginx/html/* &>>/tmp/log.txt
 curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/log.txt

cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/log.txt

 cd /usr/share/nginx/html &>>/tmp/log.txt
 unzip /tmp/frontend.zip &>>/tmp/log.txt




 systemctl restart nginx &>>/tmp/log.txt