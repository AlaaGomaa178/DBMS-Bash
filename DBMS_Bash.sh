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

: << 'COMMENT'
    echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"
    echo "                                         '$DB_name' Menu                                    "
    echo "*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~*~~~~*~~~*~~~*~~~*~~~*~~~*~~~*"

    PS3="$DB_name Menu : " 
    select Table in "Enter [1] to Create Table" "Enter [2] to List Tables" "Enter [3] to Drop Table" "Enter [4] to Insert into Table" "Enter [5] to Select from Table" "Enter [6] to Delete from Table" "Enter [7] to Update Table" "Enter [8] to Exit"
    do
        case $REPLY in
            1) 
                createTable
            ;;
            2) 
                listTables
            ;;
            3)
                dropTable
            ;;
            4) 
                insert
            ;;
            5) 
                selectfromtable
            ;;
            6) 
                deletefromtable
            ;;
            7) 
                updatetable
            ;;
            8) # exit
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

COMMENT

