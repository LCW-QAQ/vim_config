return {
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
  }
}
