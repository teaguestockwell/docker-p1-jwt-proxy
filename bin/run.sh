#!/bin/bash
docker-compose down
export $(cat .env | xargs)
sed 's/${APP}/'"$APP"'/g' ../src/nginx.conf > ../src/nginx.generated.conf
sed -i 's/${FRONTEND_PORT}/'"$FRONTEND_PORT"'/g' ../src/nginx.generated.conf
sed -i 's/${BACKEND_PORT}/'"$BACKEND_PORT"'/g' ../src/nginx.generated.conf
JWT=$(base64 -w 0 ../src/person.json)
sed -i 's/${JWT}/'"${JWT}"'/g' ../src/nginx.generated.conf
if [ -n "$BACKEND_FOLDER" ];
then
    cd $BACKEND_FOLDER
    docker build -t $APP-backend -f $BACKEND_DOCKERFILE .
    cd -
fi
if [ -n "$FRONTEND_FOLDER" ];
then
    cd $FRONTEND_FOLDER
    if [ $FRONTEND_FRAMEWORK == "react"]
    then
        npm run build
    fi
    docker build -t $APP-frontend -f $FRONTEND_DOCKERFILE .
    cd -
fi
docker-compose up