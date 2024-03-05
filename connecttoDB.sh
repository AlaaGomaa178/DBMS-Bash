#! /bin/bash

connecttoDB(){
    read -p " >   Enter DB Name : " DB_name
    if [ -d $DB_name  ];then
	#cd $DB_name
	echo "$(pwd)"
PS3="$DB_name: "

	select Table in "Enter [C] to Create Table" "Enter [L] to List Tables" "Enter [D] to Drop Table" "Enter [I] to Insert into Table" "Enter [S] to Select from Table" "Enter [R] to Delete from Table" "Enter [U] to Update Table" "Enter [Q] to Exit"
    do
        case $REPLY in
            "C" | "c" ) 
            source ./createTable.sh
                createTable $DB_name
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
		echo "$(pwd)"
		source ./DBMS_Bash.sh
                main_menu
	    ;;
	    * )
            echo "       Error, Invalid Choice    "
		
		;;
   	 esac
done

           
    else
        echo  "DB doesn't exist"
	source ./DBMS_Bash.sh
	main_menu
    fi

}
