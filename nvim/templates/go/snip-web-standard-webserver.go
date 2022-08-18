// HandleSample writes a hello message to response.
func HandleSample(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello world"))
}

func main() {
	addr := ":1234"
	r := http.NewServeMux()
	r.HandleFunc("/", HandleSample)
	svr := &http.Server{
		Addr:    addr,
		Handler: r,
	}
	log.Println("server started", addr)
	log.Fatal(svr.ListenAndServe())
}
