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
                        
                        "SelectSpecificRow")
                            # Loop to allow user to select rows based on specific column values
                            continueFlag=true
                            
                            while [[ $continueFlag == true ]]; 
                            do
                                # Read metadata to get column names and positions
                                source "$db_name/$table_name.meta"
                                
                                # Associative array to store column positions
                                declare -A col_positions  
                                
                                IFS=':' read -r -a col_names <<< "$COL_NAMES"
                                
                                for (( i=0; i<${#col_names[@]}; i++ )); 
                                do
                                    col_positions[${col_names[i]}]=$((i+1))
                                done
                                
                                # Prompt user to select a column
                                echo "Please select the column:"
                                
                                select cname in "${col_names[@]}"; 
                                do
                                    if [[ -n $cname ]]; 
                                    then
                                        # Check if the selected column exists
                                        if [[ -n ${col_positions[$cname]} ]]; 
                                        then
                                            ColumnPosition=${col_positions[$cname]}
                                            
                                            while true; 
                                            do
                                                
                                                # Prompt user to enter the value to select rows by
                                                echo "Enter the value of '$cname' to select rows by it:"
                                                read value
                                                
                                                # Check if the value exists in the selected column and print matching rows
                                                awk -F':' -v col="$ColumnPosition" -v val="$value" '$col == val { print $0 }' "$db_name/$table_name" | 
                                                
                                                while IFS= read -r line; 
                                                do
                                                    if [[ ! -z $line ]]; then
                                                        echo "$line"
                                                    else
                                                        echo "Your condition didn't match any rows."
                                                    fi
                                                done
                                                break
                                            done
                                        else
                                            echo "Invalid input! This column does not exist."
                                        fi
                                        break
                                    else
                                        echo "Invalid choice!"
                                    fi
                                done
                                
                                # Ask user if they want to select another row
                                echo "Do you want to select another row? Enter 'y' to continue or any other key to cancel: "
                                read answer

                                if [[ $answer == "y" || $answer == "Y" ]]; 
                                then
                                    continueFlag=true
                                else
                                    continueFlag=false  # Update flag to exit the loop
                                    break
                                fi
                            done
                            ;;
                            
                        "SelectColumns")
                            # Read metadata to get column names
                            source "$db_name/$table_name.meta"
                            IFS=':' read -r -a col_names <<< "$COL_NAMES"
                            
                            # Display column names for user to select
                            echo "Available columns:"
                            for ((i=0; i<${#col_names[@]}; i++)); 
                            do
                                echo "$((i+1)). ${col_names[i]}"
                            done
                            
                            # Prompt user to select a column
                            read -rp "Please enter the number corresponding to the column you want to select: " column_number
                            
                            if [[ $column_number =~ ^[0-9]+$ && $column_number -ge 1 && $column_number -le ${#col_names[@]} ]]; 
                            then
                                # Display the selected column for all rows
                                awk -F':' -v column="$column_number" '{print $column}' "$db_name/$table_name"
                            else
                                echo "Invalid input! Please enter a valid column number."
                            fi
                            ;;
                            
                        "Back to Table Menu")
                            source ./tablesMenu.sh
                            tables_menu
                            ;;
                            
                    esac
                    break  # Break from the select loop after processing each choice
                done
                
            done
            
        else
            echo "Table does not exist!"
        fi
        
    else
        echo "Invalid input! Table name must start with a letter or underscore, followed by letters, digits, or underscores."
    fi

}

selectFromTable
