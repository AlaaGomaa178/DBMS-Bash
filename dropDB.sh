#! /bin/bash

dropDB () {
    read -p "Enter DB you want to drop : " DB_name
    if [ -d $DB_name ];
    then
        rm -r $DB_name
        echo "Dropped"
    else
        echo " There is no DB named '$DB_name'"
    fi
}
