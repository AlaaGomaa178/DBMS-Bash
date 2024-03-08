#!/bin/bash

# Global variable to store the selected database name
selected_db=""

connecttoDB(){
    read -p " >   Enter DB Name : " DB_name
    if [ -d "$DB_name" ]; then
    
        # Store the selected database name in a global variable
        selected_db=$DB_name
        echo "Selected DB: $selected_db"  
       
        # return to the tables menu
        source ./tablesMenu.sh
        tables_menu
           
    else
        echo "DB doesn't exist"
        source ./DBMS_Bash.sh
        main_menu
    fi
}

connecttoDB
