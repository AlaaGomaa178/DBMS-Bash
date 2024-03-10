#!/bin/bash

listDB () {
    if [ -z "$(find . -maxdepth 1 -type d -not -name '.*' -exec basename {} \;)" ]; then
        echo  
        echo  
        echo "There are no visible DBs"
        echo  
        echo  
    else
        echo  
        echo  
        echo "The Found DBs:"
        echo 
        find . -maxdepth 1 -type d -not -name '.*' -exec basename {} \;
        echo
    fi
}

