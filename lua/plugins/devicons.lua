return {
  -- 使用windows msys2 ucrt64环境时候，需要安装pacman -S --noconfirm mingw-w64-ucrt-x86_64-ttf-jetbrains-mono-nerd，
  -- 然后编辑~/.minttyrc，设置Font=JetBrainsMono NF Regular，字体才会生效
  {
    "nvim-tree/nvim-web-devicons",
    opts = {}
  },
}
