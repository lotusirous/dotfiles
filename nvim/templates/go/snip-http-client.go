req, err := http.NewRequest("POST", endpoint, buf)
if err != nil {
	return err
}

req = req.WithContext(ctx)
req.Header.Add("Content-Type", "application/json")
res, err := s.client().Do(req)
if res != nil {
	res.Body.Close()
}
return err