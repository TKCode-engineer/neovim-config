return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- プラグイン・設定確認（最重要）
    { "<leader>P", "<cmd>Telescope<cr>", desc = "📋 Telescope機能一覧 (All Telescope Features)" },
    { "<leader>pk", "<cmd>Telescope keymaps<cr>", desc = "⌨️  キーマップ一覧 (All Keymaps)" },
    { "<leader>pc", "<cmd>Telescope commands<cr>", desc = "🔧 コマンド一覧 (All Commands)" },
    { "<leader>pp", "<cmd>Lazy<cr>", desc = "🔌 プラグイン管理 (Plugin Manager)" },
    { "<leader>ph", "<cmd>Telescope help_tags<cr>", desc = "📖 ヘルプ検索 (Help Documentation)" },
    { "<leader>po", "<cmd>Telescope vim_options<cr>", desc = "⚙️  Vim設定確認 (Vim Options)" },
    { "<leader>pa", "<cmd>Telescope autocommands<cr>", desc = "🔄 オートコマンド (Auto Commands)" },
    
    -- ファイル検索
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "📁 ファイル検索 (Find Files)" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "🔍 文字列検索 (Live Grep)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "📄 バッファ一覧 (Open Buffers)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "📅 最近のファイル (Recent Files)" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "🎯 カーソル下の単語検索 (Grep Current Word)" },
    { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "🔎 現在バッファ内検索 (Search in Current Buffer)" },
    
    -- Git関連
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "📜 Gitコミット履歴 (Git Commits)" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "🌿 Gitブランチ一覧 (Git Branches)" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "📊 Gitステータス (Git Status)" },
    { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "📋 Git管理ファイル (Git Tracked Files)" },
    
    -- LSP関連
    { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "🔗 参照箇所検索 (Find References)" },
    { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "📍 定義へ移動 (Go to Definition)" },
    { "<leader>li", "<cmd>Telescope lsp_implementations<cr>", desc = "🔧 実装箇所検索 (Find Implementations)" },
    { "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "📝 型定義検索 (Type Definitions)" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "📋 ドキュメントシンボル (Document Symbols)" },
    { "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "🏢 ワークスペースシンボル (Workspace Symbols)" },
    { "<leader>le", "<cmd>Telescope diagnostics<cr>", desc = "⚠️  診断情報 (Error/Warning Diagnostics)" },
    
    -- その他便利機能
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "🔖 マーク一覧 (Bookmarks)" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "🦘 ジャンプリスト (Jump History)" },
    { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "🔧 クイックフィックス (Quickfix List)" },
    { "<leader>fl", "<cmd>Telescope loclist<cr>", desc = "📍 ロケーションリスト (Location List)" },
    { "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "🌳 Treesitterシンボル (Code Structure)" },
    { "<leader>fv", "<cmd>Telescope registers<cr>", desc = "📋 レジスタ一覧 (Vim Registers)" },
    
    -- プラグインファイル探索
    { "<leader>fp", function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end, desc = "🔌 プラグインファイル検索 (Search Plugin Files)" },
  },
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { 
        prompt_position = "top",
        width = 0.9,
        height = 0.8,
        preview_cutoff = 120,
      },
      sorting_strategy = "ascending",
      winblend = 0,
      prompt_prefix = "🔍 ",
      selection_caret = "➤ ",
      multi_icon = "📋 ",
      file_ignore_patterns = {
        "node_modules",
        ".git/",
        "%.jpg",
        "%.jpeg",
        "%.png",
        "%.gif",
        "%.pdf",
      },
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
      live_grep = {
        additional_args = function(opts)
          return {"--hidden"}
        end
      },
    },
  },
}