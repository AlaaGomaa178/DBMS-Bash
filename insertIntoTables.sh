#!/bin/bash

insertIntoTable() {
    local db_name=$selected_db  
    while true; do
        echo "Please enter the name of the table where you want to insert data:"
        read table_name

        # Validate the table name
        if [[ $table_name =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; 
        then
            if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
            then
                
                source "$db_name/$table_name.meta"
                
                # Convert colon-separated strings to arrays
                IFS=":" read -r -a column_names_array <<< "$COL_NAMES"
                IFS=":" read -r -a column_data_types_array <<< "$COL_DATATYPES"
                IFS=":" read -r -a column_PK_array <<< "$COL_PK"

                # Find the last ID and increment it automatically 
                last_id=$(cut -d':' -f1 "$db_name/$table_name" | sort -n | tail -n 1)
                
                if [[ -z $last_id ]]; 
                then
                    next_id=1
                else
                    next_id=$((last_id + 1))
                fi

                # Let the user enter data for all of the columns except the obe who is a PK
                for ((i = 0; i < ${#column_names_array[@]}; i++)); 
                do
                    if [[ ${column_PK_array[i]} == "yes" ]]; 
                    then
                        # Automatically increment PK
                        user_entry=$next_id
                        next_id=$((next_id + 1))
                    else
                        while true; 
                        do
                            echo "Enter value for ${column_names_array[i]} (type: ${column_data_types_array[i]}):"
                            read user_entry
                            
                            # Validate input based on data type
                            case ${column_data_types_array[i]} in
                                "Integer" )
                                    if [[ $user_entry =~ ^[0-9]+$ ]]; 
                                    then
                                        break
                                    else
                                        echo "Invalid input! Please enter an integer for ${column_names_array[i]}."
                                    fi
                                    ;;
                                "String" )
                                    if [[ ! -z $user_entry ]]; 
                                    then
                                        break
                                    else
                                        echo "Invalid input! Please enter a non-empty string for ${column_names_array[i]}."
                                    fi
                                    ;;
                                *)
                                    echo "Unsupported data type: ${column_data_types_array[i]}"
                                    break
                                    ;;
                            esac
                        done
                    fi

                    # Append user entry to the table file
                    echo -n "$user_entry:" >> "$db_name/$table_name"
                done

                # Add a newline at the end 
                echo >> "$db_name/$table_name"

                echo "========================="
                echo "Data stored successfully."
                echo "========================="
                
                # return to the tables menu
                source ./tablesMenu.sh
                tables_menu
                
                break

            else
                echo "Table '$table_name' does not exist or metadata file is missing."
            fi

        else
            echo "Invalid table name! Table names must start with a letter or underscore, followed by letters, digits, or underscores."
        fi
        
    done
}

insertIntoTable
