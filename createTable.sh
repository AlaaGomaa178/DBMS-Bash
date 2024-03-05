#! /bin/bash

createTable(){
    #echo $1
    cd $1
    echo "$(pwd)"
    var='!@#$%^&*()/?\|'
    while true;
do
  read -p "Enter table name: " table_name
if  [[  $table_name =~ [0-9]+$ ]]; 
  
        then
        echo "Invalid input! name of table can not be numbers!"
          
elif
      [[ $table_name =~ [$var] ]];  

        then
        echo " Invalid input! name of table can't be regex! "
          
elif
      [[ -z "$table_name" ]];  
        
        then
        echo " Invalid input! name of taple can't be empty "
          
elif 
      [[  $table_name = *" "* ]];  
      
        then
        echo " Invalid input! name of taple can't contain spaces "
  
else 
      touch $table_name
      #mkdir DataBases/$db_namee/.metadata 2>>/dev/null
      touch $table_name.meta
      create_column 
      
     
fi
done

}

create_column(){

declare -i coloum_number

while true; do
    read -p "Enter number of columns: " column_number
    if [[ $column_number =~ ^[0-9]+$ ]]; then
        break
    else
        echo "Invalid input! Please enter numbers only."
    fi
done

echo "You entered column number: $column_number"

for (( i = 1 ; i <= $column_number ; i++ ))
    do
        while true;
        do
            read -p "Enter column name: " column_name
            if [[ -z $column_name ]]  || [[ ! $column_name =~ ^[a-zA-Z]+[a-zA-Z0-9]*$  ]]; 
            
            then
                echo "Column field must be charachters only"
            else
                break
            fi
        done
      
        if (( $i == $column_number )); then
            
            echo "$column_name;" >> $table_name.meta
            echo "==============================="
            echo "Table created succefully!!!!!!"
            echo "==============================="
            cd ..
            echo "$(pwd)"
            source ./DBMS_Bash.sh 
            main_menu
            break
        elif (( $i < $column_number )); then
           echo -e "$column_name:\c" >> $table_name.meta
        fi 
    done

}
