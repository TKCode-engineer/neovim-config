return {
  -- Mason tool installer for automatic tool management
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {
        -- LSP Servers
        "lua-language-server",
        "typescript-language-server",
        "tailwindcss-language-server",
        "emmet-ls",
        "vue-language-server", -- volar
        "java-language-server", -- managed by nvim-jdtls
        "json-lsp",
        "html-lsp",
        "css-lsp",
        "yaml-language-server",
        "dockerfile-language-server",
        "bash-language-server",
        "python-lsp-server",
        "rust-analyzer",
        "gopls",

        -- Formatters
        "prettier",
        "prettierd",
        "stylua",
        "black",
        "isort",
        "rustfmt",
        "gofmt",
        "goimports",
        "shfmt",

        -- Linters
        "eslint_d",
        "flake8",
        "pylint",
        "shellcheck",
        "yamllint",
        "jsonlint",
        "markdownlint",

        -- DAP Servers
        "node-debug2-adapter",
        "chrome-debug-adapter",
        "firefox-debug-adapter",
        "debugpy",
        "delve",
        "codelldb",

        -- Additional Tools
        "tree-sitter-cli",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay
      debounce_hours = 5, -- at least 5 hours between attempts
      integrations = {
        ["mason-lspconfig"] = true,
        ["mason-null-ls"] = true,
        ["mason-nvim-dap"] = true,
      },
    },
    config = function(_, opts)
      require("mason-tool-installer").setup(opts)

      -- Auto-install missing tools on VimEnter
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        callback = function()
          vim.schedule(function()
            print("mason-tool-installer is starting")
          end)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        callback = function(e)
          vim.schedule(function()
            print(vim.inspect(e.data)) -- print the table that lists the programs that were installed
          end)
        end,
      })
    end,
  },

  -- Override mason-lspconfig to work with tool-installer
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      handlers = {
        function(server_name)
          local server_config = {}

          -- Custom server configurations
          if server_name == "tsserver" then
            server_config = {
              init_options = {
                preferences = {
                  disableSuggestions = true,
                },
              },
            }
          elseif server_name == "tailwindcss" then
            server_config = {
              filetypes = {
                "html",
                "css",
                "scss",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
                "svelte",
              },
            }  
          elseif server_name == "emmet_ls" then
            server_config = {
              filetypes = {
                "html",
                "css",
                "scss",
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
                "vue",
              },
            }
          elseif server_name == "volar" then
            server_config = {
              filetypes = { "vue" },
              init_options = {
                vue = {
                  hybridMode = false,
                },
              },
            }
          end

          require("lspconfig")[server_name].setup(server_config)
        end,
      },
    },
  },

  -- Enhanced snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },

  -- Enhanced linting with nvim-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        python = { "flake8", "pylint" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        yaml = { "yamllint" },
        json = { "jsonlint" },
        markdown = { "markdownlint" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      -- Auto-lint on save and text change
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}