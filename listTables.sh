#!/bin/bash

listTables() {
    local db_name=$selected_db
    
    echo "Tables in database '$db_name':"
    ls -F "$db_name" | grep -v ".meta"
    
        echo "=========================="
        source ./tablesMenu.sh
                tables_menu
}