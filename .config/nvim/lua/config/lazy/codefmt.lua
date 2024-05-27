return {
  'google/vim-codefmt',
  dependencies = {
    'google/vim-maktaba'
  },
  config = function()
    vim.cmd([[
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType html,css,sass,scss,less,json,javascript,typescript,markdown AutoFormatBuffer prettier
  autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType rust AutoFormatBuffer rustfmt
augroup END
    ]])
  end
}
