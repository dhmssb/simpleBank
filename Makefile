postgres:
	docker run --rm --name dockPost -e POSTGRES_PASSWORD=123456 -e POSTGRES_USER=postgres -p 5432:5432 -d postgres:latest  

createdb:
	docker exec -it postgres createdb --username=postgres cimet

dropdb:
	docker exec -it postgres dropdb cimet

migrateup:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5432/postgres?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5432/cimet?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test