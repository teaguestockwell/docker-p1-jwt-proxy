#!/bin/bash
export $(cat .env | xargs)

if [ "$1" == "backend" ]; then
    cd src
    docker-compose -f database.compose.yml down
    docker-compose -f database.compose.yml up -d
    cd ..
    sleep 5
    cd $BACKEND_FOLDER
    export CONNECTION_STRING=localhost
    npm run test:unit
    cd -
    unset CONNECTION_STRING
    cd src
    docker-compose -f database.compose.yml down
    cd ..
fi