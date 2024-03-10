#!/bin/bash

insertIntoTable() {

    # The name of the currently selected database
    local db_name="$selected_db"

    while true; 
    do
        echo "Please enter the name of the table where you want to insert data:"
        read table_name

        # Validate the table name 
        if [[ $table_name =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; 
        then
        
            # Check if the table data file and the metadata file exist
            if [[ -f "$db_name/$table_name" && -f "$db_name/$table_name.meta" ]]; 
            then
                source "$db_name/$table_name.meta"
                
                # Convert colon-separated metadata strings to arrays
                IFS=":" read -r -a column_names_array <<< "$COL_NAMES"
                IFS=":" read -r -a column_data_types_array <<< "$COL_DATATYPES"
                IFS=":" read -r -a column_PK_array <<< "$COL_PK"


                # get the index of the PK column
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
                    break
                fi

                # ask the user to choose how to enter the primary key
                if [[ ${column_data_types_array[PK_index]} == "String" ]]; 
                then
                    echo "Primary key '${column_names_array[PK_index]}' is of type 'String'. You must enter the primary key value manually."
                    pk_choice=1  # Force manual entry
                else
                    echo "Choose how to enter primary key:"
                    echo "1) Manually"
                    echo "2) Automatically"
                    read -rp "Enter your choice: " pk_choice
                fi

                # Find the last ID and increment it automatically 
                last_id=$(cut -d':' -f1 "$db_name/$table_name" | sort -n | tail -n 1)
                
                if [[ -z $last_id ]]; 
                then
                    next_id=1
                else
                    next_id=$((last_id + 1))
                fi

                # Loop to let the user enter data for all columns
                for ((i = 0; i < ${#column_names_array[@]}; i++)); 
                do
                    if [[ $i == $PK_index ]]; 
                    then
                        
                        # Handle the PK data entry
                        if [[ $pk_choice == "1" ]]; 
                        then
                            
                            
                            # Manually enter the PK
                            while true; 
                            do
                                read -rp "Enter value for ${column_names_array[i]} (type: ${column_data_types_array[i]}): " user_entry
                                
                                # Check the if string data type validations
                                if [[ ${column_data_types_array[i]} == "String" && ( -z "$user_entry" || "$user_entry" == *:* ) ]]; 
                                then
                                    echo "Invalid input! Please enter a non-empty string without ':' for ${column_names_array[i]}."
                                
                                # Check the if integer data type validations
                                elif [[ ${column_data_types_array[i]} == "Integer" && ! $user_entry =~ ^[0-9]+$ ]]; 
                                then
                                    echo "Invalid input! Please enter an integer for ${column_names_array[i]}."
                                
                                # Check if user-entered PK already exists
                                elif cut -d: -f$((PK_index+1)) "$db_name/$table_name" | grep -q "^$user_entry"; 
                                then
                                    echo "Primary key '$user_entry' already exists. Please enter a different value."
                                
                                else
                                    break
                                fi
                            done
                            
                        else
                            
                            
                            # Automatically increment PK
                            user_entry=$next_id
                            next_id=$((next_id + 1))
                        fi
                    else
                    
                    
                    
                        # Handle other column entries
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
                                    # Validate string input
                                    if [[ -z "$user_entry" || "$user_entry" == *:* ]]; 
                                    then
                                        echo "Invalid input! Please enter a non-empty string without ':' for ${column_names_array[i]}."
                                    else
                                        break
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
                

                # Return to the tables menu
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
