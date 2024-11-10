# script to run postgres for phoenix app

PASSWORD=postgres
USERNAME=postgres

docker run --name postgres -p 5432:5432 -e POSTGRES_USERNAME=$USERNAME -e POSTGRES_PASSWORD=$PASSWORD -d postgres
