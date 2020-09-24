docker-compose down
export $(cat .env | xargs)
sed 's/${APP}/'"$APP"'/g' src/nginx.conf > src/nginx.generated.conf 
docker-compose up