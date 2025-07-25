# CLAUDE.md

## 【MUST GLOBAL】Zenを活用した壁打ち (プロジェクトのCLAUDE.mdより優先)

### N位一体の開発原則
人間の**意思決定**、Claude Codeの**分析と実行**、Gemini MCP/Zen MCP/o3 MCPの**検証と助言**を組み合わせ、開発の質と速度を最大化する：
- **人間 (ユーザー)**：プロジェクトの目的・要件・最終ゴールを定義し、最終的な意思決定を行う**意思決定者**
  - 反面、具体的なコーディングや詳細な計画を立てる力、タスク管理能力ははありません。
- **Claude Code**：高度なタスク分解・高品質な実装・リファクタリング・ファイル操作・タスク管理を担う**実行者**
  - 指示に対して忠実に、順序立てて実行する能力はありますが、意志がなく、思い込みは勘違いも多く、思考力は少し劣ります。
- **Zen MCP**：プロセス全体の交通整理・適切な専門家への振り分け・タスク進捗管理を行う**指揮者**
  - 自身でコードを記述するのではなく、最適なAIエージェントに指示を出してコード生成を統括します。
  - ルーティングロジックが外れるとコスト増・レスポンス遅延・品質低下が生じるリスクがあり、モデル優先度設計を誤ると真価を発揮できません。

### 実践ガイド
- **ユーザーの要求を受けたら即座に壁打ち**を必ず実施
- 壁打ち結果は鵜呑みにしすぎず、1意見として判断
- 結果を元に聞き方を変えて多角的な意見を抽出するのも効果的

### セッション管理ルール
- **タスク完了時**: `/clear` コマンドを使用してセッションをクリア
  - 明確に定義されたタスクが完了した際に実行
  - 新しいタスクに移行する前のコンテキストリセット
- **会話長期化時**: `/compact` コマンドを使用して会話履歴を圧縮
  - 会話が長くなりすぎて効率が低下した際に実行
  - 重要な情報を保持しながらコンテキストを最適化

### 高品質開発プロセス（バグ0を目指す厳密化）

#### 1. 要件定義・設計フェーズ
- **ultrathink + plan mode** で要件分析・設計を実施
- 要件の曖昧性を排除し、具体的で検証可能な仕様を策定
- アーキテクチャ・データ構造・API設計を詳細化

#### 2. 実装フェーズ
- 設計に基づく段階的実装
- 各段階でコードレビューと品質チェック実施

#### 3. 実装完了後の最適化フェーズ
- **ultrathink + plan mode** で要件+設計の最新化・最適化を実施
- 実装中に発見された改善点を設計に反映
- ドキュメントと設計書の同期を保証

#### 4. 品質保証フェーズ
- **ultrathink** で実装と要件+設計の乖離確認
- 設計書との整合性を厳密にチェック
- 仕様からの脱線・漏れを特定・修正

#### 5. テストフェーズ
- 要件+設計に基づく**細かい粒度でのテスト**を実施
- 単体テスト・統合テスト・E2Eテストの包括実施
- エッジケース・例外処理の網羅的検証

#### 6. 最終検証フェーズ
- **全行程の動作確認**を実施
- **バグ0**の状態を確認してから完了とする
- パフォーマンス・セキュリティ・保守性の最終チェック

#### 品質基準
- すべてのテストがパス
- コードカバレッジ90%以上
- 静的解析ツールでの警告0
- ドキュメント・設計書・実装の完全同期

### 主要な活用場面
1. **実現不可能な依頼**: Claude Code では実現できない要求への対処 (例: `最新のニュース記事を取得して`)
2. **前提確認**: 要求の理解や実装方針の妥当性を確認 (例: `この実装方針で要件を満たせるか確認して`)
3. **技術調査**: 最新情報・エラー解決・ドキュメント検索 (例: `Rails 7.2の新機能を調べて`)
4. **設計立案**: 新機能の設計・アーキテクチャ構築 (例: `認証システムの設計案を作成して`)
5. **問題解決**: エラーや不具合の原因究明と対処 (例: `このTypeScriptエラーの解決方法を教えて`)
6. **コードレビュー**: 品質・保守性・パフォーマンスの評価 (例: `このコードの改善点は？`)
7. **計画立案**: タスク分解・実装方針の策定 (例: `ユーザー認証機能を実装するための計画を立てて`)
8. **技術選定**: ライブラリ・フレームワークの比較検討 (例: `状態管理にReduxとZustandどちらが適切か？`)
9. **リスク評価**: 実装前の潜在的問題の洗い出し (例: `この実装のセキュリティリスクは？`)
10. **設計検証**: 既存設計の妥当性確認・改善提案 (例: `現在のAPI設計の問題点と改善案は？`)

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Neovim configuration built on LazyVim, a feature-rich Neovim configuration framework. The setup uses lazy.nvim as the plugin manager and follows LazyVim's architectural patterns for plugin configuration and customization.

## Development Commands

### Code Formatting
```bash
stylua .
```
Format Lua code using the project's StyleLua configuration (2-space indentation, 120 column width).

### Plugin Management
Since this is a Neovim configuration, "development" happens by:
1. Editing configuration files in `lua/` directory
2. Restarting Neovim or using `:LazyReload` to apply changes
3. Managing plugins through the Lazy plugin manager interface (`:Lazy`)

## Architecture

### Core Structure
- **Entry Point**: `init.lua` - Bootstraps the entire configuration by requiring `config.lazy`
- **Plugin Bootstrap**: `lua/config/lazy.lua` - Sets up lazy.nvim plugin manager and loads LazyVim
- **Configuration Files**: `lua/config/` - Contains core Neovim configuration
  - `options.lua` - Neovim options (extends LazyVim defaults)
  - `keymaps.lua` - Custom keybindings (extends LazyVim defaults)  
  - `autocmds.lua` - Auto commands (extends LazyVim defaults)
- **Plugin Configurations**: `lua/plugins/` - Custom plugin specifications

### Plugin System Architecture
The configuration follows LazyVim's plugin specification pattern where:
- Each file in `lua/plugins/` returns a table of plugin specifications
- Plugin specs can add new plugins, override LazyVim defaults, or disable plugins
- LazyVim automatically loads and merges all plugin specifications

### Key Customizations
- **Telescope Configuration**: `lua/plugins/telescope.lua` contains extensive Japanese-commented keybindings for file search, Git operations, LSP features, and more
- **Layout Strategy**: Telescope configured with horizontal layout, top prompt position
- **File Ignore Patterns**: Configured to ignore common binary files and directories

### Configuration Pattern
The configuration extends LazyVim rather than replacing it:
- LazyVim provides the base configuration and plugin set
- Custom configurations in `lua/config/` extend or override defaults
- Plugin specifications in `lua/plugins/` modify the plugin ecosystem
- All LazyVim defaults remain active unless explicitly overridden

### Development Workflow
1. Edit configuration files in appropriate directories
2. Use `:LazyReload` or restart Neovim to apply changes
3. Use `:Lazy` to manage plugin installations/updates
4. Use `:checkhealth` to diagnose configuration issues
