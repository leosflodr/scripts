#!/bin/bash

# This script take its parameters and use them for inserting nev project in connectors database.  
# ASSUMPTION - sql skript insert-pardot-integration.sql is on the same directory as this script. In other case you should edit variable insert_sgl


set -e
export work_dir=`dirname $0`
export insert_sql=${work_dir}/insert-pardot-integration.sql


insert_new_project () {
if [ "x$1" == "x" ]; then 
    echo "Script needs project's id as parameter;"
    exit 1
else
    export proj=$1  
fi

echo "will create project $proj" 

echo mysql -uroot -p`cat /etc/gdc/etc/mysql ` connectors -e "set @project_uri:='/gdc/projects/$proj'; set @account_id:='5552'; source ${insert_sql};"
mysql -uroot -p`cat /etc/gdc/etc/mysql ` connectors -e "set @project_uri:='/gdc/projects/$proj'; set @account_id:='5552'; source ${insert_sql};"

}


# main body

export projects=$@

for pr in $projects ; do
  insert_new_project $pr;
done 





