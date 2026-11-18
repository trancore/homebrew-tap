# trancore Homebrew tap

trancoreのツールを配布するHomebrew tapです。公開先は `trancore/homebrew-tap` です。

figfigは次のコマンドで導入できます。

```sh
brew install trancore/tap/figfig
figfig setup
figfig permissions
```

macOS 13以降、zsh 5.9以降、Terminal.app／iTerm2が対象です。ソースからビルドするため、Xcode Command Line Toolsが必要です。Node.js・pnpm・RustはHomebrewがビルド用依存として導入します。インストールには時間がかかります。

アクセシビリティ権限を許可し、新しいzshセッションを開くと有効になります。ヘルパーはローカルでad-hoc署名され、Developer IDによる署名・公証はしていません。

## 更新と削除

```sh
figfig stop
brew update
brew upgrade trancore/tap/figfig
```

更新後は新しいzshセッションを開いてください。macOSから権限の再設定を求められる場合があります。

削除する場合は `figfig stop` を実行し、`.zshrc` の `# >>> figfig >>>` から `# <<< figfig <<<` までの管理用ブロック（手動設定の場合は初期化行）を削除してから、次を実行します。保存済みのユーザー設定は削除しません。

```sh
brew uninstall trancore/tap/figfig
```

## メンテナー向け

本体は [trancore/figfig](https://github.com/trancore/figfig) で開発します。タグから生成されたDraft Releaseを確認・公開し、公開ソースのSHA-256を検証してから、そのReleaseに添付された `figfig.rb` をこのリポジトリの `Formula/figfig.rb` にコピーしてください。仮のURL・チェックサムやローカル検証用Formulaは公開しません。

CIはApple Silicon・Intelの両方で構文・スタイル・メタデータ・ソースインストール・署名・CLIテスト・削除を検証します。

手順と検証コマンドは本体の [リリース手順](https://github.com/trancore/figfig/blob/main/docs/releasing.md) を参照してください。

## English

This is trancore's Homebrew tap. Install figfig with `brew install trancore/tap/figfig`, run `figfig setup` and `figfig permissions`, then open a new zsh session. Installation builds from source and requires the Xcode Command Line Tools; Homebrew installs Node.js, pnpm, and Rust as build dependencies. The helper uses an ad-hoc signature and is not notarized.

To upgrade, stop the helper, then run `brew update` and `brew upgrade trancore/tap/figfig`. To uninstall, run `figfig stop`, remove the figfig block from `.zshrc`, then run `brew uninstall trancore/tap/figfig`. Saved preferences are retained.

Maintainers manually copy `figfig.rb` from a verified, published [figfig release](https://github.com/trancore/figfig/releases) to `Formula/figfig.rb`. See the [release guide](https://github.com/trancore/figfig/blob/main/website/i18n/en/docusaurus-plugin-content-docs/current/releasing.md).

MIT License.
