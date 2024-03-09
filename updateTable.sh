#!/bin/bash

update_table(){
    local db_name=$selected_db
    
    read -rp "Enter the name of the table to update: " table_name
    
    # Check if the table file exists in the selected database
    if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
    then
        #col_names=$(head -n 1 "$db_name/$table_name.meta" | tr ':' '\n')
        #col_names=$(head -n 1 "$db_name/$table_name.meta" | sed 's/COL_NAMES=//' | tr ':' '\n')
        #col_names=$(head -n 1 "$db_name/$table_name.meta" | sed 's/COL_NAMES=//' | tr ':' ' ')
        #col_names=$(head -n 1 "$db_name/$table_name.meta" | sed 's/COL_NAMES="//;s/"$//')
        # col_names=$(head -n 1 "$db_name/$table_name.meta" | sed 's/COL_NAMES="//;s/"$//' | tr ':' ' ')
        # echo $col_names

        # echo "Printing each element of the list:"
        # for ((i=1 ;i<= ${#col_names[@]}; i++)) ;do
        #     echo "$i) ${col_names[i]}"
        # done

        source "$db_name/$table_name.meta"
        IFS=":" read -r -a column_names_array <<< "$COL_NAMES"
        for ((i = 1; i <= ${#column_names_array[@]}; i++)); 
                do
                    echo "$i) ${column_names_array[i-1]}"
                done

        while true; do
            read -rp "enter the column no. : " num
            if [[ $num -lt 1 ]] || [[ $num -gt ${#column_names_array[@]} ]];
            then 
                echo "please enter a valid number"
            else 
                echo "correct answer"
                field=$((num - 1))
                echo $field
                break
            fi
        done

        # second_index=$(echo "$col_names" | awk '{print $2}')
        # echo "The second index of col_names is: $second_index"

        source ./tablesMenu.sh
                tables_menu
    else
        echo "Table '$table_name' does not exist."
    fi
}