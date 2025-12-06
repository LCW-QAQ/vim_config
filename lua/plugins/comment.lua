return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        toggler = {
          line = '<c-_>',
          block = '<c-m>',
        },
        opleader = {
          line = '<c-_>',
          block = '<c-m>',
        },
      })
    end
  }
}
