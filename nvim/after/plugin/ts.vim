autocmd BufWrite *.ts :lua require("typescript").actions.removeUnused({ sync = true })
