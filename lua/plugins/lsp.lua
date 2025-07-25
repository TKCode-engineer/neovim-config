return {
  -- Enhanced LSP UI
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        ui = {
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
        lightbulb = {
          enable = false,
        },
        outline = {
          win_position = "right",
          win_with = "",
          win_width = 30,
          auto_preview = true,
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
      { "<leader>cf", "<cmd>Lspsaga finder<cr>", desc = "LSP Finder" },
      { "<leader>cr", "<cmd>Lspsaga rename<cr>", desc = "LSP Rename" },
      { "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostics" },
      { "<leader>co", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Previous Diagnostic" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next Diagnostic" },
      { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Doc" },
      { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to Definition" },
      { "gt", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Go to Type Definition" },
    },
  },

  -- Enhanced diagnostic display
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()
      
      -- Disable virtual text since we're using lsp_lines
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = true,
      })
    end,
    keys = {
      { "<leader>cl", function()
        require("lsp_lines").toggle()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
        else
          vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
        end
      end, desc = "Toggle LSP Lines" },
    },
  },
}