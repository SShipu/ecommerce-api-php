#!/bin/sh
vendor/bin/doctrine orm:schema-tool:update --force
#vendor/bin/doctrine orm:schema-tool:update --force --dump-sql
#vendor/bin/doctrine orm:schema-tool:drop --force
#vendor/bin/doctrine orm:schema-tool:create

#mysqldump -u root -p YourDatabaseName > wantedsqlfile.sql
#mysqldump --no-data -uroot -p YourDatabaseName > wantedsqlfile.sql //for take database structure not deleting/droping database with no data
