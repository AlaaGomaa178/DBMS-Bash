#! /bin/bash

main_menu(){

echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
echo "                                      Main Menu                                             "
echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"

PS3="Main Menu : " # ==> change it based on menu 
select DB in "Enter [1] to Create DB" "Enter [2] to List DBs" "Enter [3] to Drop DB" "Enter [4] to Connect to DB" "Enter [5] to Exit"
do
    case $REPLY in
        1) 
            source ./createDB.sh
            createDB
        ;;
        2) 
            source ./listDB.sh
            listDB 
        ;;
        3) 
            source ./dropDB.sh
            dropDB
        ;;
        4) 
	    source ./connecttoDB.sh
            connecttoDB
        ;;
        5) #Exit
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

}

main_menu



