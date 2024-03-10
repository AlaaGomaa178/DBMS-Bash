#! /bin/bash

createTable(){
    cd $1
    allowed_pattern='^[A-Za-z][A-Za-z0-9]*$'
    while true;
    do
        read -p "Enter table name: " table_name
        if [[ ! $table_name =~ $allowed_pattern ]]; 
        then
            echo "Invalid input! Name of table must start with a letter and contain only letters and numbers!"
        elif [[ -z "$table_name" ]]; 
        then
            echo "Invalid input! Name of table cannot be empty!"
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
        read -p "Enter number of columns: " column_number
        if [[ $column_number =~ ^[1-9]+$ ]]; then
            break
        else
            echo "Invalid input! Please enter a number starting from 1."
        fi
    done

    echo "You entered $column_number columns."

    column_names=""
    column_data_types=""
    column_PK=""

    for ((i = 1; i <= $column_number; i++)); do
        while true; do
            read -p "Enter column name for column $i: " column_name
            if [[ -z $column_name ]] || [[ ! $column_name =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then
                echo "Column names must start with a letter and contain only letters and numbers."
            else
                break
            fi
        done

        while true; do
            read -p "Select data type for column '$column_name': (1) Integer (2) String: " data_type_choice
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
                echo "Invalid choice! Please enter either 1 for Integer or 2 for String."
                ;;
            esac
        done

        if ! $PK_selected; then
            while true; do
                read -p "Do you want '$column_name' to be the Primary key? (1) Yes (2) No, if you chose 'yes' this will be the only PK as only one PK is allowed: " primary_key
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
                    echo "Invalid choice! Please enter either 1 for Yes or 2 for No."
                    ;;
                esac
            done
        else
            PK="no"
        fi

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

    echo "COL_NAMES=\"$column_names\"" >> $table_name.meta
    echo "COL_DATATYPES=\"$column_data_types\"" >> $table_name.meta
    echo "COL_PK=\"$column_PK\"" >> $table_name.meta

    echo "==============================="
    echo "Table created successfully!"
    echo "==============================="

    cd ..
    source ./tablesMenu.sh
    tables_menu
}

