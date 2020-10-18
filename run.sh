docker-compose down
export $(cat .env | xargs)
sed 's/${APP}/'"$APP"'/g' src/nginx.conf > src/nginx.generated.conf
sed -i 's/${FRONTEND_PORT}/'"$FRONTEND_PORT"'/g' src/nginx.generated.conf
sed -i 's/${BACKEND_PORT}/'"$BACKEND_PORT"'/g' src/nginx.generated.conf
JWT=$(base64 -w 0 src/person.json)
sed -i 's/${JWT}/'"${JWT}"'/g' src/nginx.generated.conf
docker-compose up