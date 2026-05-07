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
    config = function()
      require("lualine").setup({
        sections = {
          lualine_c = {
            { "filename", path = 1 },
          },
          lualine_x = {
            { "filename", path = 2, icon = "folder" },
          },
        },
      })
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
