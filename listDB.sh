#!/bin/bash

listDB () {
    if [ -z "$(ls -A)" ];
    then
        echo " There is no DBs"
    else
        echo "The Founded DBs"
        echo 
                find . -maxdepth 1 -type d -exec basename {} \;
        echo
    fi
}
