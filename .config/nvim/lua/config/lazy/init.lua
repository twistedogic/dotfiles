return {
  {
    'nvim-lua/plenary.nvim',
    name = "plenary",
  },
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup()
    end
  },
  {
    'aserowy/tmux.nvim',
    config = function() 
      require("tmux").setup() 
    end
  }
}
