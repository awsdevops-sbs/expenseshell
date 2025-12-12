dnf module disable nodejs -y &>>/tmp/log.txt
dnf module enable nodejs:20 -y &>>/tmp/log.txt

dnf install nodejs -y &>>/tmp/log.txt

cp backend.service /etc/systemd/system/backend.service
rm -rf /tmp/* &>>/tmp/log.txt
useradd expense &>>/tmp/log.txt

mkdir /app &>>/tmp/log.txt


curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/log.txt
cd /app &>>/tmp/log.txt
unzip /tmp/backend.zip &>>/tmp/log.txt


cd /app &>>/tmp/log.txt
npm install &>>/tmp/log.txt


systemctl daemon-reload &>>/tmp/log.txt

systemctl enable backend &>>/tmp/log.txt
systemctl start backend &>>/tmp/log.txt

dnf install mysql -y

mysql -h 172.31.71.114 -uroot -pExpenseApp@1 < /app/schema/backend.sql