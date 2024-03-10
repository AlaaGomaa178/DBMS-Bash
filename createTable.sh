#!/bin/bash

# Function to create a table
createTable(){
    cd $1
    
    #Regular expression pattern for allowed table names
    allowed_pattern='^[A-Za-z][A-Za-z0-9]*$'
    
    # loop until a valid table name is provided
    while true;
    do
        # let the user to enter the table name
        read -p " >  Enter table name: " table_name
        
        # Check if the table name matches the allowed pattern
        if [[ ! $table_name =~ $allowed_pattern ]]; 
        then
            echo
            echo "!!! Invalid input! Name of table must start with a letter and contain only letters and numbers!"
            echo
            
        # Check if the table name is empty
        elif [[ -z "$table_name" ]]; 
        then
            echo
            echo "Invalid input! Name of table cannot be empty!"
            echo
        else 
        
            # Create the table file and its metadata file
            touch $table_name
            touch $table_name.meta
            
            create_column 
        fi
    done
}


create_column(){

    #loop until a valid number of columns is provided
    while true; do
        read -p " >  Enter number of columns: " column_number
        if [[ $column_number =~ ^[1-9]+$ ]]; 
        then
            break
        else
            echo
            echo " !!! Invalid input! Please enter a number starting from 1. !!!"
            echo
        fi
    done

    echo
    echo "  You entered $column_number columns."
    echo

    column_names=""
    column_data_types=""
    column_PK=""

    # Check if there is only one column, automatically make it the primary key
    if [[ $column_number -eq 1 ]]; 
    then
        PK_selected=true
        echo "You created only 1 column, so it must be a PK column."
        
    else
        PK_selected=false
    fi

    # Loop to iterate through each column and gather column details
    for ((i = 1; i <= $column_number; i++)); do
        while true; do
            read -p " >  Enter column name for column $i: " column_name
            if [[ -z $column_name ]] || [[ ! $column_name =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then
                echo
                echo "!!! Column names must start with a letter and contain only letters and numbers !!!"
                echo
            else
                break
            fi
        done

        while true; do
            echo
            read -p "Select data type for column '$column_name': (1) Integer (2) String: " data_type_choice
            echo
            case $data_type_choice in
            1)
                data_type="Integer"
                break
                ;;
            2)
                data_type="String"
                break
                ;;
            *)
                echo
                echo "!!! Invalid choice! Please enter either 1 for Integer or 2 for String !!!"
                echo
                ;;
            esac
        done

        # If the primary key is not selected yet, ask the user if this column should be the primary key
        if ! $PK_selected; then
            while true; do
                echo
                read -p "Do you want '$column_name' to be the Primary key? (1) Yes (2) No, if you chose 'yes' this will be the only PK as only one PK is allowed: " primary_key
                echo
                case $primary_key in
                1)
                    PK="yes"
                    PK_selected=true
                    break
                    ;;
                2)
                    PK="no"
                    break
                    ;;
                *)
                    echo
                    echo " !!! Invalid choice! Please enter either 1 for Yes or 2 for No !!!"
                    echo
                    ;;
                esac
            done
        else
            PK="no"
        fi

        # Append column details to the corresponding variables
        if [[ $i -eq 1 ]]; then
            column_names="$column_name"
            column_data_types="$data_type"
            column_PK="$PK"
        else
            column_names="$column_names:$column_name"
            column_data_types="$column_data_types:$data_type"
            column_PK="$column_PK:$PK"
        fi

    done

    # Write column details to the metadata file
    echo "COL_NAMES=\"$column_names\"" >> $table_name.meta
    echo "COL_DATATYPES=\"$column_data_types\"" >> $table_name.meta
    echo "COL_PK=\"$column_PK\"" >> $table_name.meta


    echo
    echo
    echo "                          ===================================="
    echo "                          ~~~ Table created successfully! ~~~"
    echo "                          ===================================="
    echo
    echo


    cd ..
    source ./tablesMenu.sh
    tables_menu
}


