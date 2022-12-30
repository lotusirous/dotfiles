
func arrayEqual(t *testing.T, a, b []string) {
	if len(a) != len(b) {
		t.Fatalf("Len are not equal: left %d - right: %d", len(a), len(b))
	}
	for i := range a {
		if a[i] != b[i] {
			t.Fatalf("pos: %d - got: %s - want: %s", i, a[i], b[i])
		}
	}
}


