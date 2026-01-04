-- AstroUI configuration
-- https://github.com/AstroNvim/astroui

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- Colorscheme
    colorscheme = "catppuccin-mocha",

    -- Highlights
    highlights = {
      init = {},
      astrodark = {},
    },

    -- Icons (using Nerd Fonts)
    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
