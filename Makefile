postgres:
	docker run --rm --name dockPost --network bank-network -e POSTGRES_PASSWORD=123456 -e POSTGRES_USER=postgres -p 5432:5432 -d postgres:latest  

createdb:
	docker exec -it postgres createdb --username=postgres cimet

dropdb:
	docker exec -it postgres dropdb cimet

migrateup:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5432/postgres?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5432/cimet?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5432/cimet?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5432/cimet?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

start: 
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/dhmssb/simpleBank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test start mock migrateup1 migratedown1