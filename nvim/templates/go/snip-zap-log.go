func setupLogger(debug bool) {
	if debug {
		log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stdout,
			TimeFormat: time.RFC3339, NoColor: false}).Level(zerolog.DebugLevel)
		return
	}
	log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stdout, TimeFormat: time.RFC3339, NoColor: true}).Level(zerolog.InfoLevel)
}
