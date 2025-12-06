return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
      vim.cmd[[colorscheme tokyonight]]
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function ()
      require("lualine").setup()
    end
  },
  {
    "akinsho/bufferline.nvim",
    config = function ()
      require("bufferline").setup()
    end
  },
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  }
}
