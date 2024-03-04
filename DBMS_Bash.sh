#! /bin/bash


    shopt -s extglob
    export LC_COLLATE=C


	createDB () {
    read -p " >   Enter DB Name : " DB_name

    allowed_pattern='^[A-Za-z0-9]*$'
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


echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
echo "                                      Main Menu                                             "
echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"

PS3="Main Menu : " # ==> change it based on menu 
select DB in "Enter [C] to Create DB" "Enter [L] to List DBs" "Enter [D] to Drop DB" "Enter [S] to Connect to DB" "Enter [Q] to Exit"
do
    case $REPLY in
        "C" | "c" ) 
            createDB
        ;;
        "L" | "l" ) 
            listDB 
        ;;
        "D" | "d" ) 
            dropDB
        ;;
        "S" | "s" ) 
            connecttoDB
        ;;
        "Q" | "q" ) #Exit
            cd ..
            echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
            echo "                                           BYE                                              "
            echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
            break

        ;;
        * )
            echo "       Error, Invalid Choice    "
            echo " Please Enter a correct choice
                            C ==> Create DB
                            L ==> List DBs
                            D ==> Drop DB
                            S ==> Connect to DB
                            Q ==> Exit ' "
        ;;
    esac
done




    echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
    echo "                                         '$DB_name' Menu                                    "
    echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"

    PS3="$DB_name Menu : " 
    select Table in "Enter [C] to Create Table" "Enter [L] to List Tables" "Enter [D] to Drop Table" "Enter [I] to Insert into Table" "Enter [S] to Select from Table" "Enter [R] to Delete from Table" "Enter [U] to Update Table" "Enter [Q] to Exit"
    do
        case $REPLY in
            "C" | "c" ) 
                createTable
            ;;
            "L" | "l" ) 
                listTables
            ;;
            "D" | "d" )
                dropTable
            ;;
            "I" | "i" ) 
                insert
            ;;
            "S" | "s" ) 
                selectfromtable
            ;;
            "R" | "r" ) 
                deletefromtable
            ;;
            "U" | "u" ) 
                updatetable
            ;;
            "Q" | "q" ) # exit
                cd ..
                echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
                echo "                                        Main Menu                                           "
                echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"

                PS3="Main Menu : " # ==> change it based on menu
                break

            ;;
            * )
                echo "       Error, Invalid Choice    "
                echo "       Please Enter a correct choose from menu
                                C ==> Create Table
                                L ==> List Tables
                                D ==> Drop Table
                                I ==> Insert into Table
                                S ==> Select from Table
                                D ==> Delete from Table
                                U ==> Update Table
                                Q ==> Exit ' "
            ;;
        esac
    done



