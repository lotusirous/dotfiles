package {{_cursor_}}

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
)

// Connect to a database and verify with a ping.
func Connect(datasource string) (*sql.DB, error) {
	db, err := sql.Open("mysql", "root:password1@tcp(127.0.0.1:3306)/test")
	if err != nil {
		return nil, err
	}
	if err := pingDatabase(db); err != nil {
		return nil, err
	}
	// if err := setupDatabase(db, driver); err != nil {
	// 	return nil, err
	// }
	db.SetMaxIdleConns(0)
	// generally set to 0, user configured for larger installs
	db.SetMaxOpenConns(0)

	return db, nil
}

// helper function to ping the database with backoff to ensure
// a connection can be established before we proceed with the
// database setup and migration.
func pingDatabase(db *sql.DB) (err error) {
	for i := 0; i < 30; i++ {
		err = db.Ping()
		if err == nil {
			return
		}
		time.Sleep(time.Second)
	}
	return
}
