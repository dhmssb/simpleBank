package main

import (
	"database/sql"
	"fmt"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// Inisialisasi koneksi ke basis data
	db, err := sql.Open("mysql", "username:password@tcp(localhost:3306)/dbname")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Mulai transaksi
	tx, err := db.Begin()
	if err != nil {
		log.Fatal(err)
	}

	// Contoh query
	query1 := "INSERT INTO table1 (column1) VALUES ('value1')"
	query2 := "UPDATE table2 SET column2 = 'value2' WHERE id = 1"

	// Eksekusi query dalam transaksi
	_, err = tx.Exec(query1)
	if err != nil {
		tx.Rollback() // Rollback jika ada error
		log.Fatal(err)
	}

	_, err = tx.Exec(query2)
	if err != nil {
		tx.Rollback() // Rollback jika ada error
		log.Fatal(err)
	}

	// Commit transaksi
	if err := tx.Commit(); err != nil {
		tx.Rollback() // Rollback jika ada error
		log.Fatal(err)
	}

	fmt.Println("Transaksi berhasil.")
}
