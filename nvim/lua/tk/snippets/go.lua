local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
-- local f = ls.function_node
local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta -- similar to fmt with <> placeholder

ls.add_snippets("go", {
	s("pf", fmta([[
// <> <>
func <>(<>) <> {
	<>
}<>
	 ]], {
		rep(1),
		i(4, "..."),
		i(1, ""),
		i(2, ""),
		i(3),
		i(5),
		i(6),
	}, { repeat_duplicates = true }) ),

	s("mpf", fmta([[
// <> <>
func (<>) <>(<>) <> {
	<>
}<>
	 ]], {
		rep(2),
		i(5, "..."),
		i(1, ""),
		i(2, ""),
		i(3),
		i(4),
		i(6),
		i(7),
	}, { repeat_duplicates = true }) ),

	s("ref", fmta([[
[<>]: <>
	 ]], {
		i(1),
		i(2),
	}, { repeat_duplicates = true }) ),

	s("tys", fmta([[
// A <> <>
type <> struct {
	<>
}<>
	 ]], {
		rep(1),
		i(2),
		i(1),
		i(3),
		i(4),
	}, { repeat_duplicates = true }) ),

	s("tyi", fmta([[
// <> is <>
type <> interface {
	<>
}<>
	 ]], {
		rep(1),
		i(2),
		i(1),
		i(3),
		i(4),
	}, { repeat_duplicates = true }) ),

	s("ctx", { t("ctx context.Context") }),

	s(
		"webserver",
		fmta(
			[[
    package main

    // HandleSample writes a hello message to response.
    func HandleSample(w http.ResponseWriter, r *http.Request) {
        w.Write([]byte("Hello world"))
    }

    func main() {
        addr := <port>
        r := http.NewServeMux()
        r.HandleFunc("/", HandleSample)
        svr := &http.Server{
            Addr:    addr,
            Handler: r,
        }
        log.Println("server started: ", addr)
        log.Fatal(svr.ListenAndServe())
    }

    ]],
			{
				port = i(1, '":1234"'),
			}
		)
	),

	s(
		"newreq",
		fmta(
			[[
        req, err := http.NewRequest("<method>", endpoint, buf)
        if err != nil {
            <ret>
        }

        req = req.WithContext(ctx)
        req.Header.Add("Content-Type", "application/json")
        res, err := s.client().Do(req)
        if err != nil {
            <ret>
        }
        defer res.Body.Close()
        <ret>
    ]],
			{
				ret = c(1, {
					t({ "return err" }),
					t({ "return nil, err" }),
				}),
				method = i(2),
			},
			{ repeat_duplicates = true }
		)
	),

	s(
		"tff",
		fmta(
			[[
        func test<>(<>) func(*testing.T) {
            return func(t *testing.T) {
                <>
            }
        }

    ]],
			{
				i(1),
				i(2),
				i(3),
			}
		)
	),

	s(
		"tbl",
		fmta(
			[[
        tests := []struct {
            in   <intype>
            want <wanttype>
        }{
            {<data>},
        }

        for _, tt := range tests {
            got := <fn>(tt.in)
            if !cmp.Equal(got, tt.want) {
                t.Errorf("input : %v - got: %v - want: %v", tt.in, got, tt.want)
            }
        }
    ]],
			{
				intype = i(1, "input type"),
				wanttype = i(2, "want type"),
				data = i(3, "data"),
				fn = i(4, "function"),
			},
			{ repeat_duplicates = true }
		)
	),

	s(
		"iferr",
		fmta(
			[[
        if err != nil {
            <>
        }
    ]],
			{
				c(1, {
					t({ "return err" }),
					t({ "return nil, err" }),
				}),
			}
		)
	),

	s(
		"hands",
		fmta(
			[[
        // <> returns an http.HandlerFunc that processes http requests to
        // <>
        func <fn>(w http.ResponseWriter, r *http.Request) {
            <>
        }
    ]],
			{
				rep(1),
				i(2),
				i(3),
				fn = i(1, ""),
			}
		)
	),

	s(
		"fmax",
		fmta(
			[[
    func max(x, y int) int {
        if x > y {
            return x
        }
        return y
    }[]
    ]],
			i(1, ""),
			{ delimiters = "[]" }
		)
	),

	s(
		"fmin",
		fmta(
			[[
    func min(x, y int) int {
        if x < y {
            return x
        }
        return y
    }[]
    ]],
			i(1, ""),
			{ delimiters = "[]" }
		)
	),
}, {
	key = "go",
})
