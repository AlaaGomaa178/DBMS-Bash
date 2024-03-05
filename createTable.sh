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
column_names=""
column_data_types=""

for ((i = 1; i <= $column_number; i++)); do
        while true; do
            read -p "Enter column name for column $i: " column_name
            if [[ -z $column_name ]] || [[ ! $column_name =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then
                echo "Column names must start with a letter and contain only letters and numbers."
            else
                break
            fi
        done

        while true; do
            read -p "Select data type for column '$column_name': (1) Integer (2) String: " data_type_choice
            case $data_type_choice in
            1)
                data_type="Integer"
                break
                ;;
            2)
                data_type="String"
                break
                ;;
            *)
                echo "Invalid choice! Please enter either 1 for Integer or 2 for String."
                ;;
            esac
        done

        if [[ $i -eq 1 ]]; then
            column_names="$column_name"
            column_data_types="$data_type"
        else
            column_names="$column_names:$column_name"
            column_data_types="$column_data_types:$data_type"
        fi

    done

    echo "$column_names" >>$table_name.meta
    echo "$column_data_types" >>$table_name.meta

    echo "==============================="
    echo "Table created successfully!!!!!!"
    echo "==============================="

    cd ..
    echo "$(pwd)"
    source ./DBMS_Bash.sh
    main_menu
}
