#! /bin/bash

shopt -s extglob
    export LC_COLLATE=C


	createDB () {
    read -p " >   Enter DB Name : " DB_name

    allowed_pattern='^[A-Za-z0-9]+$'
    while [[ ! $DB_name =~ $allowed_pattern || $DB_name =~ ^[0-9] ]]
    do
        echo  "      invalid name      "
        read -p "$ >   Enter DB Name : " DB_name
    done

    

    if [ -d $DB_name  ];then
        echo  "DB already exist"
    else
        mkdir $DB_name
        echo  "    database "$DB_name" is created"
    fi
}
