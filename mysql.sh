dnf install mysql-server -y &>>/tmp/log.txt

systemctl enable mysqld &>>/tmp/log.txt
systemctl start mysqld &>>/tmp/log.txt

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>/tmp/log.txt
