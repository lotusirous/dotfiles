import (
	"database/sql"
	"time"
)

// Open inits the connection to database
func Open(datasource string) (*sql.DB, error) {
	db, err := sql.Open("mysql", datasource)
	if err != nil {
		return nil, err
	}
	db.SetMaxIdleConns(0) // for mysql driver

	if err := pingDatabase(db); err != nil {
		return nil, err
	}

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

