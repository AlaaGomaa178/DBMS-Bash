#!/bin/bash

tables_menu() {
    
    PS3="Enter your choice: " # ==> change it based on menu 
  
    select Table in "Enter [C] to Create Table" s"Enter [L] to List Tables" "Enter [D] to Drop Table" "Enter [I] to Insert into Table" "Enter [S] to Select from Table" "Enter [R] to Delete from Table" "Enter [U] to Update Table" "Enter [Q] to Exit"
    do
        case $REPLY in
            "C" | "c" ) 
                source ./createTable.sh
                createTable $DB_name
                ;;
            "L" | "l" ) 
                listTables
                ;;
            "D" | "d" )
                dropTable
                ;;
            "I" | "i" ) 
                source ./insertIntoTable.sh
                insertIntoTable 
                ;;
            "S" | "s" ) 
                selectfromtable
                ;;
            "R" | "r" ) 
                deletefromtable
                ;;
            "U" | "u" ) 
                updatetable
                ;;
            "Q" | "q" ) # exit
                source ./DBMS_Bash.sh
                main_menu
                ;;
            * )
                echo "Error: Invalid Choice"
                ;;
        esac
    done
}

tables_menu
