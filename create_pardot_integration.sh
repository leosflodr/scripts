#!/bin/bash

# This script take its parameters and use them for inserting nev project in connectors database.  

set -e

insert_new_project () {
if [ "x$1" == "x" ]; then 
    echo "Script needs project's id as parameter;"
    exit 1
else
    export proj=$1  
fi

echo "will create project $proj" 



echo mysql -uroot -p`cat /etc/gdc/etc/mysql ` connectors -e "set @project_uri:=/gdc/projects/$proj; set @account_id:='5552'; source insert-pardot-integration.sql;"


}


# main body

export projects=$@

echo toto jsou parametry $projects

for pr in $projects ; do
  insert_new_project $pr;
done 





