vim.g.mapleader = " "
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.nu = true
vim.o.relativenumber = false
vim.o.wrap = false

vim.api.nvim_create_autocmd("FileType", {
	pattern = "ts,tsx,js,jsx",
	command = "setlocal shiftwidth=2 tabstop=2",
})
