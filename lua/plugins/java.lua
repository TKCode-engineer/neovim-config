return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "folke/which-key.nvim",
    },
    config = function()
      local jdtls = require("jdtls")
      local home = os.getenv("HOME")
      local root_dir = jdtls.setup.find_root({ "gradlew", ".git", "mvnw" })
      local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

      local config = {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-jar", home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
          "-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
          "-data", workspace_dir,
        },
        root_dir = root_dir,
        settings = {
          java = {
            eclipse = {
              downloadSources = true,
            },
            configuration = {
              updateBuildConfiguration = "interactive",
            },
            maven = {
              downloadSources = true,
            },
            implementationsCodeLens = {
              enabled = true,
            },
            referencesCodeLens = {
              enabled = true,
            },
            references = {
              includeDecompiledSources = true,
            },
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
            format = {
              enabled = false,
            },
          },
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
          },
          contentProvider = { preferred = "fernflower" },
          extendedClientCapabilities = jdtls.extendedClientCapabilities,
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },
        flags = {
          allow_incremental_sync = true,
        },
        init_options = {
          bundles = {},
        },
        on_attach = function(client, bufnr)
          local _, _ = pcall(vim.lsp.codelens.refresh)
          
          -- Keymaps
          local opts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize Imports" }))
          vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract Variable" }))
          vim.keymap.set("n", "<leader>jc", jdtls.extract_constant, vim.tbl_extend("force", opts, { desc = "Extract Constant" }))
          vim.keymap.set("v", "<leader>jm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], vim.tbl_extend("force", opts, { desc = "Extract Method" }))
          vim.keymap.set("n", "<leader>jt", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Test Class" }))
          vim.keymap.set("n", "<leader>jT", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Test Nearest Method" }))

          -- Which Key
          require("which-key").add({
            { "<leader>j", group = "Java" },
            { "<leader>jo", desc = "Organize Imports" },
            { "<leader>jv", desc = "Extract Variable" },
            { "<leader>jc", desc = "Extract Constant" },
            { "<leader>jm", desc = "Extract Method", mode = "v" },
            { "<leader>jt", desc = "Test Class" },
            { "<leader>jT", desc = "Test Nearest Method" },
          })

          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Auto-command to codelens refresh for Java
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.java" },
            callback = function()
              local _, _ = pcall(vim.lsp.codelens.refresh)
            end,
          })
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      jdtls.start_or_attach(config)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}