# 外部依存関係の管理

## 方針

- 外部依存物の取得元、バージョン、ライセンス、ハッシュを文書で記録する。
- 再取得が難しくなる可能性がある配布物は、再配布条件を確認したうえで元のアーカイブを `third_party/archives/` に保存する。
- アーカイブから展開したファイルは `vendor/` に配置するが、Gitでは追跡しない。展開物はスクリプトで再生成する。
- アーカイブと展開物を手作業で両方編集しない。依存物を変更する必要がある場合は、変更内容とライセンス上の扱いを別途記録する。

## AutoHotInterception (AHI)

| 項目 | 値 |
|---|---|
| 配布元 | https://github.com/evilC/AutoHotInterception |
| Releases | https://github.com/evilC/AutoHotInterception/releases |
| 採用バージョン | 未確定（実機検証前） |
| アーカイブ | `third_party/archives/AutoHotInterception-<version>.zip` |
| 展開先 | `vendor/AutoHotInterception/` |
| 展開スクリプト | `scripts/setup-dependencies.ps1` |
| 取得日 | 未記録 |
| SHA-256 | アーカイブ追加時に記録 |
| ライセンス・再配布条件 | アーカイブ追加前に確認 |

**注意:** 上記は取得先の記録であり、特定バージョンの採用や互換性を確定したものではない。実際にアーカイブを追加する前に、リリース内容、ライセンス、再配布条件を確認する。

## セットアップ

1. AHIのリリースZIPを `third_party/archives/` に配置する。
2. ZIPのバージョン、取得日、SHA-256、ライセンス確認結果をこの文書に記録する。
3. リポジトリのルートで次を実行する。

```powershell
.\scripts\setup-dependencies.ps1
```

スクリプトは `AutoHotInterception-*.zip` が1つだけあることを前提とする。複数ある場合は、使用するアーカイブを明示する。

```powershell
.\scripts\setup-dependencies.ps1 -ArchivePath third_party/archives/AutoHotInterception-v0.9.2.zip
```

展開先の `vendor/AutoHotInterception/` はGit管理対象外。セットアップをやり直すと、同ディレクトリの既存内容は削除されて再展開される。
