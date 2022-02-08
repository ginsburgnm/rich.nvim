-- create install cmd
vim.cmd("command! -nargs=* -complete=file Rich :lua require('rich').rich('<f-args>')")
