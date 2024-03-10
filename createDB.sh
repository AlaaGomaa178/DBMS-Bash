#! /bin/bash


shopt -s extglob
export LC_COLLATE=C


createDB () {
    read -p " >   Enter DB Name : " DB_name

    allowed_pattern='^[A-Za-z0-9]+$'
    while [[ ! $DB_name =~ $allowed_pattern || $DB_name =~ ^[0-9] ]]
    do
        echo
        echo  "      Invalid name! DB name must start with a letter and contain only letters and numbers!      "
        echo

        read -p "$ >   Enter DB Name : " DB_name
    done

    

    if [ -d $DB_name  ];then
        echo  
        echo  
        echo  "         DB already exists"
        echo  
        echo  
    else
        mkdir $DB_name
        echo  
        echo  
        echo  "  ~~~  Database "$DB_name" is created ~~~"
        echo  
        echo  
    fi
}
