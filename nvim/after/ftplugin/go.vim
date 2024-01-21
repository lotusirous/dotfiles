" let g:tagbar_type_go = {
" 	\ 'ctagstype' : 'go',
" 	\ 'kinds'     : [
" 		\ 'p:package',
" 		\ 'i:imports:1',
" 		\ 'c:constants',
" 		\ 'v:variables',
" 		\ 't:types',
" 		\ 'n:interfaces',
" 		\ 'w:fields',
" 		\ 'e:embedded',
" 		\ 'm:methods',
" 		\ 'r:constructor',
" 		\ 'f:functions'
" 	\ ],
" 	\ 'sro' : '.',
" 	\ 'kind2scope' : {
" 		\ 't' : 'ctype',
" 		\ 'n' : 'ntype'
" 	\ },
" 	\ 'scope2kind' : {
" 		\ 'ctype' : 't',
" 		\ 'ntype' : 'n'
" 	\ },
" 	\ 'ctagsbin'  : 'gotags',
" 	\ 'ctagsargs' : '-sort -silent'
" \ }
"
"
let g:gotests_template = ""



command! -bang -nargs=? GoDoc
        \ call fzf#run(fzf#wrap({ 'source': 'stdsym '.shellescape(<q-args>) }, <bang>0))


