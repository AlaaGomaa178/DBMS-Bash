#!/bin/bash

tables_menu() {
    # Prompt the user to enter their choice
    
    PS3="Enter your choice: " # ==> change it based on menu 
  
    select Table 
    in "Enter [C] to Create Table" "Enter [L] to List Tables" "Enter [D] to Drop Table" "Enter [I] to Insert into Table" "Enter [S] to Select from Table" "Enter [R] to Delete from Table" "Enter [U] to Update Table" "Enter [Q] to Exit"
    do
        case $REPLY in
            "C" | "c" ) 
                source ./createTable.sh
                createTable $selected_db
                ;;
            "L" | "l" ) 
                source ./listTables.sh
                listTables 
                ;;
            "D" | "d" )
                source ./dropTable.sh
                dropTable 
                ;;
            "I" | "i" ) 
                source ./insertIntoTables.sh
                insertIntoTable 
                ;;
            "S" | "s" ) 
                source ./selectFromTables.sh
                selectFromTable 
                ;;
            "R" | "r" ) 
                source ./deleteFromTable.sh
                delete_from_table
                ;;
            "U" | "u" ) 
                source ./updateTable.sh
                update_table
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

# Call the function
tables_menu
