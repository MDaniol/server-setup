-- AstroCore configuration
-- https://github.com/AstroNvim/astrocore

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },

    -- Diagnostics configuration
    diagnostics = {
      virtual_text = true,
      underline = true,
    },

    -- Vim options
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        tabstop = 2,
        shiftwidth = 2,
        expandtab = true,
        scrolloff = 8,
        sidescrolloff = 8,
        clipboard = "unnamedplus",
        termguicolors = true,
        updatetime = 250,
        timeoutlen = 300,
        undofile = true,
        smartcase = true,
        ignorecase = true,
      },
      g = {
        mapleader = " ",
        maplocalleader = ",",
        autoformat_enabled = true,
        autopairs_enabled = true,
        icons_enabled = true,
      },
    },

    -- Custom key mappings
    mappings = {
      n = {
        -- Buffer navigation
        ["<S-l>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-h>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- Buffer management
        ["<leader>bd"] = { function() require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end) end, desc = "Pick buffer to close" },
        ["<leader>bD"] = { function() require("astrocore.buffer").close_all(true) end, desc = "Close all buffers except current" },

        -- Quick save
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" },

        -- Better window navigation
        ["<C-h>"] = { "<C-w>h", desc = "Move to left window" },
        ["<C-j>"] = { "<C-w>j", desc = "Move to below window" },
        ["<C-k>"] = { "<C-w>k", desc = "Move to above window" },
        ["<C-l>"] = { "<C-w>l", desc = "Move to right window" },

        -- Resize with arrows
        ["<C-Up>"] = { ":resize -2<CR>", desc = "Resize window up" },
        ["<C-Down>"] = { ":resize +2<CR>", desc = "Resize window down" },
        ["<C-Left>"] = { ":vertical resize -2<CR>", desc = "Resize window left" },
        ["<C-Right>"] = { ":vertical resize +2<CR>", desc = "Resize window right" },

        -- Trouble
        ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
        ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace diagnostics" },
        ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document diagnostics" },

        -- Git
        ["<leader>gg"] = { "<cmd>LazyGit<cr>", desc = "LazyGit" },

        -- Clear search highlight
        ["<Esc>"] = { ":noh<CR>", desc = "Clear search highlight" },
      },

      -- Insert mode
      i = {
        ["jk"] = { "<Esc>", desc = "Exit insert mode" },
        ["<C-s>"] = { "<Esc>:w!<cr>", desc = "Save file" },
      },

      -- Visual mode
      v = {
        -- Move lines
        ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move line down" },
        ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move line up" },

        -- Stay in indent mode
        ["<"] = { "<gv", desc = "Indent left" },
        [">"] = { ">gv", desc = "Indent right" },

        -- Better paste
        ["p"] = { '"_dP', desc = "Paste without yanking" },
      },

      -- Terminal mode
      t = {
        ["<Esc><Esc>"] = { "<C-\\><C-n>", desc = "Exit terminal mode" },
      },
    },
  },
}
