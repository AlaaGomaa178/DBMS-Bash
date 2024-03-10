#! /bin/bash

dropDB () {
    while true; do
        read -rp "Enter DB you want to drop: " DB_name
        # Check if the input is empty or contains spaces
        if [[ -z "$DB_name" ]]; then
            echo "Input cannot be empty."
        elif [[ "$DB_name" =~ [[:space:]] || ! "$DB_name" =~ ^[a-zA-Z0-9_]+$ ]]; then
            echo "Input cannot contain spaces or special characters."
        else
            break  # Exit the loop if input is valid
        fi
    done
    if [ -d $DB_name ];
    then
        rm -r $DB_name
        echo "Dropped"
    else
        echo " There is no DB named '$DB_name'"
    fi
}
