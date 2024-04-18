mysqldump -u root -p -h localhost --opt ottoman_db -d --single-transaction --no-data | sed 's/ AUTO_INCREMENT=[0-9]*//g'
