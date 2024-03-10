#!/bin/bash

update_table(){
    local db_name=$selected_db
    
    while true; do
        read -rp "Enter the name of the table to update: " table_name
        
        # Check if the table file exists in the selected database
        if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
        then
            source "$db_name/$table_name.meta"
            IFS=":" read -r -a column_names_array <<< "$COL_NAMES"
            IFS=":" read -r -a column_data_types_array <<< "$COL_DATATYPES"  # Add this line to read column data types
            IFS=":" read -r -a column_PK_array <<< "$COL_PK"  # Add this line to read column PK metadata
            
            # Print column numbers and names for user selection
            for ((i = 1; i <= ${#column_names_array[@]}; i++)); 
            do
                echo "$i) ${column_names_array[i-1]}"
            done

            while true; do
                read -rp "Enter the column number to edit: " edit_column_num
                if [[ $edit_column_num -lt 1 ]] || [[ $edit_column_num -gt ${#column_names_array[@]} ]];
                then 
                    echo "Invalid column number. Please enter a valid number."
                else 
                    break
                fi
            done

            # Prompt the user to enter the new value for the selected column
            while true; do
                read -rp "Enter the new value for ${column_names_array[edit_column_num - 1]}: " new_value
                
                # Validate new value based on column data type
                case ${column_data_types_array[edit_column_num - 1]} in
                    "Integer")
                        if ! [[ $new_value =~ ^[0-9]+$ ]]; then
                            echo "Invalid input! Please enter an integer for ${column_names_array[edit_column_num - 1]}."
                        else
                            break
                        fi
                        ;;
                    "String")
                        if [[ -z $new_value || $new_value == *:* ]]; then
                            echo "Invalid input! Please enter a non-empty string without ':' for ${column_names_array[edit_column_num - 1]}."
                        else
                            break
                        fi
                        ;;
                    *)
                        echo "Unsupported data type: ${column_data_types_array[edit_column_num - 1]}"
                        ;;
                esac
            done

            # Find the index of the PK column
            PK_index=-1
            for ((i = 0; i < ${#column_names_array[@]}; i++)); 
            do
                if [[ ${column_PK_array[i]} == "yes" ]]; 
                then
                    PK_index=$i
                    break
                fi
            done

            # Check if a primary key column exists
            if [[ $PK_index == -1 ]]; 
            then
                echo "No primary key column found in the table metadata."
                return
            fi

            # Check if the edited column is the primary key
            if [[ $edit_column_num -eq $((PK_index + 1)) ]]; then
                # Validate condition value uniqueness for PK column
                if grep -q "^$new_value:" "$db_name/$table_name"; 
                then
                    echo "Primary key '$new_value' already exists. Please enter a different value for the primary key."
                    continue
                fi
            fi

            # Prompt the user to choose the column for the condition
            while true; do
                read -rp "Enter the number of the column for the condition: " condition_column_num
                if [[ $condition_column_num -lt 1 ]] || [[ $condition_column_num -gt ${#column_names_array[@]} ]];
                then 
                    echo "Invalid column number for the condition. Please enter a valid number."
                else
                    break
                fi
            done

            # Prompt the user to enter the condition value for the selected column
            while true; do
                read -rp "Enter the condition value for ${column_names_array[condition_column_num - 1]}: " condition_value
                
                # Validate condition value based on column data type
                case ${column_data_types_array[condition_column_num - 1]} in
                    "Integer")
                        if ! [[ $condition_value =~ ^[0-9]+$ ]]; then
                            echo "Invalid input! Please enter an integer for the condition value."
                        else
                            break
                        fi
                        ;;
                    "String")
                        if [[ -z $condition_value || $condition_value == *:* ]]; then
                            echo "Invalid input! Please enter a non-empty string without ':' for the condition value."
                        else
                            break
                        fi
                        ;;
                    *)
                        echo "Unsupported data type for condition column: ${column_data_types_array[condition_column_num - 1]}"
                        ;;
                esac
            done

            # Check if the condition value exists in the specified column
            if ! grep -q "^$condition_value:" "$db_name/$table_name"; 
            then
                echo "No value equal to the condition value ('$condition_value') was found in the specified column. Please enter a valid condition value."
                continue
            fi

            # Update the corresponding value in the data file based on the condition
            awk -F':' -v edit_col="$edit_column_num" -v new_val="$new_value" -v cond_col="$condition_column_num" -v cond_val="$condition_value" '
                BEGIN {OFS=":"}
                {
                    if ($cond_col == cond_val) {
                        $edit_col = new_val
                    }
                    print $0
                }
            ' "$db_name/$table_name" > "$db_name/$table_name.tmp" && mv "$db_name/$table_name.tmp" "$db_name/$table_name"

            echo "========================="
            echo "Data updated successfully."
            echo "========================="

            # Return to the tables menu
            source ./tablesMenu.sh
            tables_menu
            break
        else
            echo "Table '$table_name' does not exist."
        fi
    done
}

update_table
