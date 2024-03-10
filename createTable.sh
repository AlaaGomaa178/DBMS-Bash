#!/bin/bash

createTable(){
    cd $1
    allowed_pattern='^[A-Za-z][A-Za-z0-9]*$'
    while true;
    do
        read -p " >  Enter table name: " table_name
        if [[ ! $table_name =~ $allowed_pattern ]]; 
        then
            echo
            echo "!!! Invalid input! Name of table must start with a letter and contain only letters and numbers!"
            echo
        elif [[ -z "$table_name" ]]; 
        then
            echo
            echo "Invalid input! Name of table cannot be empty!"
            echo
        else 
            touch $table_name
            touch $table_name.meta
            create_column 
        fi
    done
}


create_column(){

    PK_selected=false

    while true; do
        read -p " >  Enter number of columns: " column_number
        if [[ $column_number =~ ^[1-9]+$ ]]; then
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

        if [[ $i -eq 1 && $column_number -eq 1 ]]; 
        then
        
            echo "You created only 1 column, so it must be a PK column."
            PK="yes"
            PK_selected=true
            
        else
            PK="no"
        fi

        if [[ $i -eq 1 ]]; 
        then
            column_names="$column_name"
            column_data_types="$data_type"
            column_PK="$PK"
        else
            column_names="$column_names:$column_name"
            column_data_types="$column_data_types:$data_type"
            column_PK="$column_PK:$PK"
        fi

    done

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


