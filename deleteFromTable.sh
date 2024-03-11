#!/bin/bash

delete_from_table(){
    local db_name=$selected_db
    
    echo
    read -rp "  > Enter the name of the table to update: " table_name
    echo
    
    if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
    then
        

        # Prompt the user to choose the deletion option using a select menu
        PS3="  > Select deletion option: "
        
        options=("Delete all rows" "Delete rows based on a condition" "Quit")
        
        select opt in "${options[@]}"; do
            case $REPLY in
                1)
                    # Delete all rows from the data file
                    > "$db_name/$table_name"
                    echo
                    echo "                          ======================================"
                    echo "                          ~~~ All rows deleted successfully! ~~~"
                    echo "                          ======================================"
                    echo
                    ;;
                2)
                    source "$db_name/$table_name.meta"
                    IFS=":" read -r -a column_names_array <<< "$COL_NAMES"
                    
                    # Display the column names for the user to choose from
                    echo
                    echo "Available columns:"
                    echo
                    for ((i = 0; i < ${#column_names_array[@]}; i++)); do
                        echo "$(($i + 1)): ${column_names_array[i]}"
                    done

                    
                    while true; do
                        # Prompt the user to choose the column for the condition
                        echo
                        read -rp "Enter the number of the column for the condition: " condition_column_num
                        echo

                        if ! [[ $condition_column_num =~ ^[0-9]+$ ]] || [[ $condition_column_num -lt 1 ]] || [[ $condition_column_num -gt ${#column_names_array[@]} ]];
                        then 
                            echo "Invalid column number. Please enter a valid number."
                        else 
                            break
                        fi
                    done

                    # Prompt the user to enter the condition value for the selected column
                    echo
                    read -rp "Enter the condition value for ${column_names_array[condition_column_num - 1]}: " condition_value
                    echo

                    # Delete the lines that match the condition from the data file
                    awk -F':' -v cond_col="$condition_column_num" -v cond_val="$condition_value" '
                        $cond_col != cond_val
                    ' "$db_name/$table_name" > "$db_name/$table_name.tmp" && mv "$db_name/$table_name.tmp" "$db_name/$table_name"
                    
                    #echo "Data rows deleted successfully based on the condition."
                    ;;
                3)
                    echo
                    echo "Exiting..."
                    echo
                    break
                    ;;
                *)
                    echo
                    echo " !!! Invalid option. Please select a valid option !!!"
                    echo
                    ;;
            esac
        done
        source ./tablesMenu.sh
                tables_menu
    else
        echo
        echo " !!! Table '$table_name' does not exist !!!"
        echo
    fi
}