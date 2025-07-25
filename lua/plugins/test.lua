return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Language specific adapters
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-go",
    },
    keys = {
      { "<leader>tr", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
      { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Open test output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle watch mode" },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { 
              justMyCode = false,
              console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG" },
            runner = "pytest",
            python = ".venv/bin/python",
          }),
          require("neotest-plenary"),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-vitest")({
            filter_dir = function(name, rel_path, root)
              return name ~= "node_modules"
            end,
          }),
          require("neotest-rust")({
            args = { "--no-capture" },
            dap_adapter = "lldb",
          }),
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" }
          }),
        },
        discovery = {
          concurrent = 0,
          enabled = true,
        },
        diagnostic = {
          enabled = true,
          severity = 1,
        },
        floating = {
          border = "rounded",
          max_height = 0.6,
          max_width = 0.6,
          options = {},
        },
        highlights = {
          adapter_name = "NeotestAdapterName",
          border = "NeotestBorder",
          dir = "NeotestDir",
          expand_marker = "NeotestExpandMarker",
          failed = "NeotestFailed",
          file = "NeotestFile",
          focused = "NeotestFocused",
          indent = "NeotestIndent",
          marked = "NeotestMarked",
          namespace = "NeotestNamespace",
          passed = "NeotestPassed",
          running = "NeotestRunning",
          select_win = "NeotestWinSelect",
          skipped = "NeotestSkipped",
          target = "NeotestTarget",
          test = "NeotestTest",
          unknown = "NeotestUnknown",
        },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "✖",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "✓",
          running = "🗘",
          running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
          skipped = "○",
          unknown = "?",
        },
        jump = {
          enabled = true,
        },
        log_level = vim.log.levels.WARN,
        output = {
          enabled = true,
          open_on_run = "short",
        },
        output_panel = {
          enabled = true,
          open = "botright split | resize 15",
        },
        projects = {},
        quickfix = {
          enabled = true,
          open = false,
        },
        run = {
          enabled = true,
        },
        running = {
          concurrent = true,
        },
        state = {
          enabled = true,
        },
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
        strategies = {
          integrated = {
            height = 40,
            width = 120,
          },
        },
        summary = {
          animated = true,
          enabled = true,
          expand_errors = true,
          follow = true,
          mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            debug = "d",
            debug_marked = "D",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            help = "?",
            jumpto = "i",
            mark = "m",
            next_failed = "J",
            output = "o",
            prev_failed = "K",
            run = "r",
            run_marked = "R",
            short = "O",
            stop = "u",
            target = "t",
            watch = "w",
          },
          open = "botright vsplit | vertical resize 50",
        },
        watch = {
          enabled = true,
          symbol_queries = {
            go = "        ;query\n        ;Captures imported types\n        (qualified_type name: (type_identifier) @symbol)\n        ;Captures package-local and built-in types\n        (type_identifier)@symbol\n        ;Captures imported function calls and variables/constants\n        (selector_expression field: (field_identifier) @symbol)\n        ;Captures package-local functions calls\n        (identifier) @symbol\n      ",
            javascript = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default imports\n  (import_default_specifier name: (identifier) @symbol)\n  ;Captures namespace imports\n  (namespace_import name: (identifier) @symbol)\n  ;Captures aliased imports\n  (import_specifier name: (identifier) alias: (identifier) @symbol)\n  ;Captures variables\n  (variable_declarator name: (identifier) @symbol)\n  ;Captures function names\n  (function_declaration name: (identifier) @symbol)\n  ;Captures assigned function names\n  (assignment_expression left: (identifier) @symbol)\n  ;Captures shorthand object properties\n  (pair key: (property_identifier) @symbol)\n  ;Captures destructured variables\n  (object_pattern (shorthand_property_identifier_pattern) @symbol)\n  ;Captures destructured variables with aliasing\n  (object_pattern (pair key: (property_identifier) value: (identifier) @symbol))\n',
            lua = '        ;query\n        ;Captures module names in require calls\n        (function_call name: ((identifier) @function (#eq? @function "require")) arguments: (arguments (string) @symbol))\n      ',
            python = "        ;query\n        ;Captures imports and modules they come from\n        (import_from_statement module_name: (dotted_name) @symbol)\n        (import_statement name: (dotted_name) @symbol)\n        (aliased_import name: (dotted_name) @symbol)\n        ;Captures function definitions\n        (function_definition name: (identifier) @symbol)\n        ;Captures class definitions\n        (class_definition name: (identifier) @symbol)\n        ;Captures method definitions\n        (function_definition name: (identifier) @symbol (#set! role method))\n        ;Captures variable assignments\n        (assignment left: (identifier) @symbol)\n      ",
            ruby = "        ;query\n        ;rspec - class name\n        (pair\n          key: (symbol (identifier) @symbol)\n          (#match? @symbol \"(describe|context)\")\n        )\n        ;rspec - namespace\n        (argument_list (identifier) @symbol)\n        ;rspec - describe subject\n        (call\n          method: (identifier) @method\n          (#match? @method \"(describe|context)\")\n          arguments: (argument_list (constant) @symbol )\n        )\n        ;rspec - class methods\n        (call\n          method: (identifier)\n          (#match? @method \"(describe|context)\")\n          arguments: (argument_list (string (string_content) @symbol) )\n        )\n      ",
            rust = "        ;query\n        ;submodule import\n        (mod_item\n          name: (identifier) @symbol)\n        ;single import\n        (use_declaration\n          argument: (scoped_identifier\n            name: (identifier) @symbol))\n        ;import list\n        (use_declaration\n          argument: (scoped_use_list\n            list: (use_list\n              (identifier) @symbol)))\n        ;wildcard import\n        (use_declaration\n          argument: (scoped_use_list\n            path: (identifier)\n            list: (use_list\n              (use_wildcard\n                (identifier) @symbol))))\n      ",
            typescript = '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default imports\n  (import_default_specifier name: (identifier) @symbol)\n  ;Captures namespace imports\n  (namespace_import name: (identifier) @symbol)\n  ;Captures aliased imports\n  (import_specifier name: (identifier) alias: (identifier) @symbol)\n  ;Captures variables\n  (variable_declarator name: (identifier) @symbol)\n  ;Captures function names\n  (function_declaration name: (identifier) @symbol)\n  ;Captures assigned function names\n  (assignment_expression left: (identifier) @symbol)\n  ;Captures shorthand object properties\n  (pair key: (property_identifier) @symbol)\n  ;Captures destructured variables\n  (object_pattern (shorthand_property_identifier_pattern) @symbol)\n  ;Captures destructured variables with aliasing\n  (object_pattern (pair key: (property_identifier) value: (identifier) @symbol))\n',
          },
        },
      })
    end,
  },
}