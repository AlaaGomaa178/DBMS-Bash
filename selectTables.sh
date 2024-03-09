    #!/bin/bash

selectFromTable() {

    local db_name="$selected_db"
    
    # Prompt user to enter the table name
    echo "Please enter the name of the table you want to select data from:"
    read table_name
    echo "db_name: $db_name"
    echo "table_name: $table_name"

    # Check (validation) on table name 
    if [[ $table_name =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; 
    then
        
        # Check if both data file and metadata file exist for the table
        if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
        then
            # Loop to display the menu again after each choice
            while true; 
            do
                # Selecting data menu
                select choice in "SelectAll" "SelectSpecificRow" "SelectColumns" "Back to Table Menu"; 
                do
                    case $choice in
                        
                        
                        "SelectAll")
                            # Display all rows in the table
                            cat "$db_name/$table_name"
                            ;;
                        
}
    

selectFromTable "$selected_db"