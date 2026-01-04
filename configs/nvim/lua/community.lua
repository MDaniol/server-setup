-- AstroNvim Community Plugins
-- https://github.com/AstroNvim/astrocommunity

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- Colorschemes
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },

  -- Editor enhancements
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },

  -- Motion
  { import = "astrocommunity.motion.leap-nvim" },
  { import = "astrocommunity.motion.mini-surround" },

  -- Git
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.git-blame-nvim" },

  -- Diagnostics
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- File explorer
  { import = "astrocommunity.file-explorer.oil-nvim" },

  -- Bars and lines
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },

  -- Language packs (add as needed)
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.rust" },
}
