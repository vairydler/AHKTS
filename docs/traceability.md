# トレーサビリティ表

- 文書ID：TRACE-DOC-001
- 状態：初版
- 方針：要求 → 仕様 → 設計 → 実装 → テストを追跡する。実装・テスト未作成は未対応と明記する。

## トレース表

| 要求ID | 仕様ID | 設計ID／モジュールID | 実装 | テスト | 状態 |
|---|---|---|---|---|---|
| REQ-INPUT-001 | SPEC-INPUT-001（複数HID入力） | DES-INPUT-001 / MOD-DRIVER-001 | 未実装 | TEST-INPUT-001 | 要設計 |
| REQ-BIND-001 | SPEC-BIND-001（入力バインド） | DES-BIND-001 / MOD-BINDING-001 | 未実装 | TEST-BIND-001 | 要設計 |
| REQ-MOD-001 | SPEC-MOD-001（共有修飾キー） | DES-MOD-001 / MOD-MODIFIER-001 | 未実装 | TEST-MOD-001 | 要設計 |
| REQ-PASS-001 | SPEC-PASS-001（通常入力通過） | DES-HOOK-001 / MOD-DRIVER-001 | 未実装 | TEST-PASS-001 | 技術検証優先 |
| REQ-ARCH-001 | SPEC-ARCH-001（責務分離） | DES-ARCH-001 | 未実装 | TEST-ARCH-001 | 設計中 |
| REQ-QUEUE-001 | SPEC-QUEUE-001（イベント受け渡し） | DES-QUEUE-001 / MOD-QUEUE-001 | 未実装 | TEST-QUEUE-001 | 方式未確定 |
| REQ-DOC-001 | 文書自体 | Git管理 | 適用済み | レビュー | 初版作成 |
| REQ-TRACE-001 | 文書自体 | この表 | 適用済み | 表のレビュー | 初版作成 |
| REQ-PLAN-001 | docs/plan.md | GitHub Issues運用 | 運用準備中 | Issue状態の確認 | 初版作成 |

## IDルール

- `REQ-*`：要求
- `SPEC-*`：システム／機能仕様
- `DES-*`：設計項目
- `MOD-*`：実装モジュール
- `TEST-*`：テストケース
- `ADR-####`：設計判断記録
- `PLAN-###`：工程項目

IDは一度発行したら別の意味に再利用しない。削除・統合した場合は備考を残す。

## 更新ルール

- 要求や仕様の変更時にこの表を同じPRで更新する。
- 実装が存在しないIDに対して、実装済みと記載しない。
- テスト未実施、失敗、合格を区別する。
- コードコメントには、追跡上有用な要求・仕様・設計IDだけを記載する。
- 具体的な仕様ID・設計IDの本文は、各文書の詳細化に合わせて追加する。この初版では未定義のIDをプレースホルダーとして明示している。
