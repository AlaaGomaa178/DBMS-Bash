#! /bin/bash

dropDB () {
    allowed_pattern='^[A-Za-z0-9]+$'
    while true; do
        read -rp " >   Enter DB you want to drop: " DB_name
        if [[ ! $DB_name =~ $allowed_pattern || $DB_name =~ ^[0-9] ]]; then
            echo  
            echo  
            echo "  Invalid name! Please enter a valid DB name without starting with a number and containing only letters and numbers."
            echo  
            echo  
        else
            break
        fi
    done
    
    if [ -d "$DB_name" ]; then
        rm -r "$DB_name"
        echo  
        echo  
        echo "  ~~~ Database '$DB_name' dropped successfully. ~~~"
        echo  
        echo  
    else
        echo  
        echo  
        echo "    !!! Database '$DB_name' does not exist. !!!"
        echo  
        echo  
    fi
}
