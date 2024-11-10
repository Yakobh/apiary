# script to run postgres for phoenix app

if [ $# -eq 0 ]; then
  echo "Usage: $0 POSTGRES_PASSWORD"
  exit 1
fi

PASSWORD=$1
docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=$PASSWORD -d postgres
