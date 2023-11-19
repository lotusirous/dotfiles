" Define a custom function to run semgrep and load results
function! RunSemgrepAndLoadQuickfix()
    echo 'Running semgrep... Please wait.'
    cexpr system('semgrep --vim --quiet -f ~/.semgrep/config.yml')
endfunction

" Define a custom function to execute on BufEnter
function! CheckAndRunSemgrep()
    if expand('%:p') == expand('~/.semgrep/config.yml')
        " Automatically run semgrep when the config.yml buffer is closed
        au BufLeave <buffer> call RunSemgrepAndLoadQuickfix()
    endif
endfunction

" Map F12 to open ~/.semgrep/config.yml
nnoremap <F12> :e ~/.semgrep/config.yml<CR>

" Attach the CheckAndRunSemgrep function to BufEnter event
augroup semgrep_autocommands
    autocmd!
    autocmd BufEnter ~/.semgrep/config.yml call CheckAndRunSemgrep()
augroup END
