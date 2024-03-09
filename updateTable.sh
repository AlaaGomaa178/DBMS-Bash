#!/bin/bash

update_table(){
    local db_name=$selected_db
    
    read -rp "Enter the name of the table to update: " table_name
    
    # Check if the table file exists in the selected database
    if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
    then
        source "$db_name/$table_name.meta"
        IFS=":" read -r -a column_names_array <<< "$COL_NAMES"
        for ((i = 1; i <= ${#column_names_array[@]}; i++)); 
                do
                    echo "$i) ${column_names_array[i-1]}"
                done

        while true; do
            read -rp "enter the column no. to edit: " edit_column_num
            if [[ $edit_column_num -lt 1 ]] || [[ $edit_column_num -gt ${#column_names_array[@]} ]];
            then 
                echo "please enter a valid number"
            else 
                echo "correct answer"
                break
            fi
        done
        
        # Prompt the user to enter the new value for the selected column
        read -rp "Enter the new value for ${column_names_array[edit_column_num - 1]}: " new_value

        # Prompt the user to choose the column for the condition
        read -rp "Enter the number of the column for the condition: " condition_column_num

        # Prompt the user to enter the condition value for the selected column
        read -rp "Enter the condition value for ${column_names_array[condition_column_num - 1]}: " condition_value
        
        #this works on when user select address column and enter new_value so it will update all addresses= condition_value
        # sed -i "s/$condition_value/$new_value/g" $db_name/$table_name

        # Check if the value exists in the selected column and print matching rows
        # awk -F':' -v col="$condition_column_num" -v val="$condition_value" '$col == val { print $0 }' "$db_name/$table_name" | 
        # while IFS= read -r line; 
        #     do
        #         if [[ ! -z $line ]]; then
        #             echo "$line"
        #             sed -i "s/$condition_value/$new_value/g" $db_name/$table_name 
        #         else
        #             echo "Your condition didn't match any rows."
        #         fi
        #     done

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

        source ./tablesMenu.sh
                tables_menu
    else
        echo "Table '$table_name' does not exist."
    fi
}