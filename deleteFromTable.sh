#!/bin/bash

delete_from_table(){
    local db_name=$selected_db
    
    read -rp "Enter the name of the table to update: " table_name
    if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
    then
        

        # Prompt the user to choose the deletion option using a select menu
        PS3="Select deletion option: "
        options=("Delete all rows" "Delete rows based on a condition" "Quit")
        select opt in "${options[@]}"; do
            case $REPLY in
                1)
                    # Delete all rows from the data file
                    > "$db_name/$table_name"
                    echo "All rows deleted successfully."
                    ;;
                2)
                    source "$db_name/$table_name.meta"
                    IFS=":" read -r -a column_names_array <<< "$COL_NAMES"
                    
                    # Display the column names for the user to choose from
                    echo "Available columns:"
                    for ((i = 0; i < ${#column_names_array[@]}; i++)); do
                        echo "$(($i + 1)): ${column_names_array[i]}"
                    done
                    # Prompt the user to choose the column for the condition
                    read -rp "Enter the number of the column for the condition: " condition_column_num

                    # Prompt the user to enter the condition value for the selected column
                    read -rp "Enter the condition value for ${column_names_array[condition_column_num - 1]}: " condition_value

                    # Delete the lines that match the condition from the data file
                    awk -F':' -v cond_col="$condition_column_num" -v cond_val="$condition_value" '
                        $cond_col != cond_val
                    ' "$db_name/$table_name" > "$db_name/$table_name.tmp" && mv "$db_name/$table_name.tmp" "$db_name/$table_name"
                    
                    #echo "Data rows deleted successfully based on the condition."
                    ;;
                3)
                    echo "Exiting..."
                    break
                    ;;
                *)
                    echo "Invalid option. Please select a valid option."
                    ;;
            esac
        done
        source ./tablesMenu.sh
                tables_menu
    else
        echo "Table '$table_name' does not exist."
    fi
}