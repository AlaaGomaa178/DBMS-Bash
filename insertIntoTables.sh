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

                # Determine if PK should be automatically incremented
                auto_increment_PK=false

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

                if [[ $PK_index == -1 ]]; 
                then
                    echo "No primary key column found in the table metadata."
                    break
                fi

                read -rp "Do you want to automatically increment the primary key column? (yes/no): " auto_increment_choice
                case $auto_increment_choice in
                    "yes" | "Yes" | "YES" )
                        auto_increment_PK=true
                        ;;
                    * )
                        auto_increment_PK=false
                        ;;
                esac

                # Find the last ID and increment it automatically 
                last_id=$(cut -d':' -f$((PK_index+1)) "$db_name/$table_name" | sort -n | tail -n 1)
                
                if [[ -z $last_id ]]; 
                then
                    next_id=1
                else
                    next_id=$((last_id + 1))
                fi

                # Let the user enter data for all of the columns
                for ((i = 0; i < ${#column_names_array[@]}; i++)); 
                do
                    if [[ $i == $PK_index && $auto_increment_PK == true ]]; 
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
                                        # Check if the PK value already exists in the PK column
                                        if [[ $i == $PK_index && ${column_PK_array[i]} == "yes" ]]; 
                                        then
                                            if grep -q "^$user_entry:" "$db_name/$table_name"; 
                                            then
                                                echo "Primary key value '$user_entry' already exists in the table. Please enter a unique value."
                                                continue
                                            else
                                                break
                                            fi
                                        else
                                            break
                                        fi
                                    else
                                        echo "Invalid input! Please enter an integer for ${column_names_array[i]}."
                                    fi
                                    ;;
                                "String" )
                                    if [[ ! -z $user_entry ]]; 
                                    then
                                        # Check if the PK value already exists in the PK column
                                        if [[ $i == $PK_index && ${column_PK_array[i]} == "yes" ]]; 
                                        then
                                            if grep -q "^$user_entry:" "$db_name/$table_name"; 
                                            then
                                                echo "Primary key value '$user_entry' already exists in the table. Please enter a unique value."
                                                continue
                                            else
                                                break
                                            fi
                                        else
                                            break
                                        fi
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
                echo "Table '$table_name' does not exist in this DB"
            fi

        else
            echo "Invalid table name! Table names must start with a letter or underscore, followed by letters, digits, or underscores."
        fi

    done
}

insertIntoTable
