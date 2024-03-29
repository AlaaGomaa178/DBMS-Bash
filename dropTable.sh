#!/bin/bash

dropTable() {
    local db_name=$selected_db
    
    echo
    read -rp "  > Enter the name of the table to drop: " table_name
    echo

    # Check if the table file exists in the selected database
    if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
    then
        # Remove the table file and its metadata file
        rm "$db_name/$table_name" "$db_name/$table_name.meta"
        
        echo
        echo
        echo "                          =================================================="
        echo "                          ~~~ Table '$table_name' dropped successfully. ~~~"
        echo "                          =================================================="
        echo
        echo 
        source ./tablesMenu.sh
                tables_menu
    else
        echo "Table '$table_name' does not exist."
    fi
}
