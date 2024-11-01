return {
    'David-Kunz/gen.nvim',
    config = function()
        require('gen').setup({})
        vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>')
    end
}
