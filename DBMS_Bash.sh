#! /bin/bash

main_menu(){

echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
echo "                                      Main Menu                                             "
echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"

PS3="Enter your choice : " # ==> change it based on menu 
select DB in "Enter [1] to Create DB" "Enter [2] to List DBs" "Enter [3] to Drop DB" "Enter [4] to Connect to DB" "Enter [5] to Exit"
do
    case $REPLY in
        1) 
            source ./createDB.sh
            createDB
            main_menu
        ;;
        2) 
            source ./listDB.sh
            listDB 
            main_menu
        ;;
        3) 
            source ./dropDB.sh
            dropDB
            main_menu
        ;;
        4) 
	        source ./connecttoDB.sh
            connecttoDB
            main_menu
        ;;
        5) #Exit
            cd ..
            echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
            echo "                                           BYE                                              "
            echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
            break
            break
            break

        ;;
        * )
            echo "       Error, Invalid Choice    "
            echo " Please Enter a correct choice
                            1 ==> Create DB
                            2 ==> List DBs
                            3 ==> Drop DB
                            4 ==> Connect to DB
                            5 ==> Exit ' "
        ;;
    esac
done

}

main_menu



