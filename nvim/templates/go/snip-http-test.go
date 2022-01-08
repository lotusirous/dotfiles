w := httptest.NewRecorder()
r := httptest.NewRequest("GET", "/", nil)
r = r.WithContext(
	context.WithValue(context.Background(), chi.RouteCtxKey, c),
)

// HandleFunc
{{_cursor_}}(users)(w, r)
if got, want := w.Code, 200; want != got {
	t.Errorf("Want response code %d - got %d", want, got)
}