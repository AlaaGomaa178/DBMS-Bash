#!/bin/bash

listDB () {
    if [ -z "$(find . -maxdepth 1 -type d -not -name '.*' -exec basename {} \;)" ]; then
        echo "There are no visible DBs"
    else
        echo "The Found DBs:"
        echo 
        find . -maxdepth 1 -type d -not -name '.*' -exec basename {} \;
        echo
    fi
}

