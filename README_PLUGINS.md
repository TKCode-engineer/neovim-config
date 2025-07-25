# LazyVim Plugin Configuration

このディレクトリには、LazyVimに追加されたプラグインの設定が機能別に整理されています。

## 設定済みプラグイン一覧

### 🔧 Git関連 (`git.lua`)
- **vim-fugitive**: 強力なGit統合プラグイン
  - `<leader>gg`: Git status
  - `<leader>gd`: Git diff split
  - `<leader>gb`: Git blame
  - `<leader>gc`: Git commit
  - `<leader>gp`: Git push
  - `<leader>gl`: Git pull

### 🎨 UI拡張 (`ui.lua`)
- **nvim-ufo**: LSPベースの高度なフォールディング機能
  - `zR`: すべてのフォールドを開く
  - `zM`: すべてのフォールドを閉じる
  - `K`: フォールドのプレビューまたはLSPホバー

### 🔍 LSP拡張 (`lsp.lua`)
- **lspsaga.nvim**: LSP UIの強化
  - `<leader>ca`: コードアクション
  - `<leader>cf`: LSP検索
  - `<leader>cr`: リネーム
  - `<leader>cd`: 行診断表示
  - `<leader>co`: アウトライン表示
- **lsp_lines.nvim**: 診断メッセージの詳細表示
  - `<leader>cl`: LSP Lines切り替え

### 🐛 デバッグ (`dap.lua`)
- **nvim-dap**: Debug Adapter Protocol
- **nvim-dap-ui**: デバッグUI
- **nvim-dap-virtual-text**: 仮想テキスト表示
  - `<leader>db`: ブレークポイント切り替え
  - `<leader>dc`: デバッグ続行
  - `<leader>di`: ステップイン
  - `<leader>do`: ステップアウト
  - `<leader>du`: DAP UI切り替え

### 🧪 テスト (`test.lua`)
- **neotest**: 総合テストフレームワーク
- 対応言語: Python, JavaScript/Jest, Vitest, Rust, Go
  - `<leader>tr`: 最近のテスト実行
  - `<leader>tf`: 現在ファイルのテスト実行
  - `<leader>ta`: すべてのテスト実行
  - `<leader>ts`: テストサマリー切り替え
  - `<leader>td`: デバッグモードでテスト実行

### 🤖 AI統合 (`ai.lua`)
- **ChatGPT.nvim**: ChatGPT統合
  - `<leader>cc`: ChatGPT開始
  - `<leader>ce`: 指示でコード編集
  - `<leader>cg`: 文法修正
  - `<leader>ct`: 翻訳
  - `<leader>cx`: コード説明
  - `<leader>co`: コード最適化

### 📝 Markdown (`markdown.lua`)
- **markdown-preview.nvim**: Markdownプレビュー
  - `<leader>mp`: プレビュー切り替え
  - `<leader>ms`: プレビュー開始
  - `<leader>mS`: プレビュー停止

### ☕ Java開発 (`java.lua`)
- **nvim-jdtls**: Java Language Server
  - `<leader>jo`: インポート整理
  - `<leader>jv`: 変数抽出
  - `<leader>jc`: 定数抽出
  - `<leader>jm`: メソッド抽出
  - `<leader>jt`: テストクラス実行

### 🔨 開発ツール (`mason.lua`)
- **mason-tool-installer.nvim**: 自動ツールインストール
- **nvim-lint**: リンター統合
- **friendly-snippets**: スニペット集
- 自動インストールされるツール:
  - LSPサーバー: TypeScript, Vue, Tailwind CSS, Emmet, Python, Rust, Go等
  - フォーマッター: Prettier, Stylua, Black, Rustfmt等
  - リンター: ESLint, Flake8, Shellcheck等
  - DAPアダプター: Node.js, Python, Go, Rust等

## LazyVim Extrasの活用

以下のプラグインはLazyVim Extrasとして提供されているため、手動設定の代わりにExtrasの使用を推奨:

```lua
-- lua/config/lazy.lua のspec に追加
{
  "lazyvim.plugins.extras.dap.core",
  "lazyvim.plugins.extras.linting.eslint",
  "lazyvim.plugins.extras.test.core",
  "lazyvim.plugins.extras.ui.telescope-fzf-native",
}
```
## 使用方法

1. Neovimを再起動
2. `:Lazy` でプラグインマネージャーを開く
3. `I` でプラグインをインストール
4. 各プラグインのキーマップを使用開始

## トラブルシューティング

- プラグインが読み込まれない: `:Lazy reload [plugin-name]`
- LSPサーバーが見つからない: `:Mason` でツールをインストール
- キーマップが動作しない: `:WhichKey` で利用可能なキーマップを確認
