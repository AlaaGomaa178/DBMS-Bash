#!/bin/bash

# Global variable to store the selected database name
selected_db=""

connecttoDB(){
    
    echo
    read -p " >   Enter DB Name : " DB_name
    echo
    
    allowed_pattern='^[A-Za-z0-9]+$'
    
    while [[ ! $DB_name =~ $allowed_pattern || $DB_name =~ ^[0-9] ]]
    do
        echo
        echo  "      Invalid name! DB name must start with a letter and contain only letters and numbers!      "
        echo
        
        read -p "$ >   Enter DB Name : " DB_name
    done
    if [ -d "$DB_name" ]; 
    then
        # Store the selected database name in a global variable
        export selected_db=$DB_name

        echo
        echo "                        ~~~ Selected DB: $selected_db ~~~" 
        echo 

        # Navigate to the tables menu
        source ./tablesMenu.sh
        tables_menu     

    else
        echo " !!! DB doesn't exist !!!"
        source ./DBMS_Bash.sh
        main_menu
        
    fi
}

connecttoDB
