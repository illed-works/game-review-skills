# game-review-skills

Claude Code / claude.ai / Codex で使うゲーム企画レビュー用スキル集。

## 収録スキル

- **game-biz-review** — 企画書を「事業として成立するか」の観点でレビュー(数値目標・コスト構造・運営継続性など)
- **game-legal-review** — 企画書・シナリオを「規約・商標・特許・法規制・表現タブーに抵触しないか」の観点でレビュー

各スキルの詳細なチェック項目・発火ワードの一覧は **[SKILLS-OVERVIEW.md](./SKILLS-OVERVIEW.md)** を参照。

両スキルは姉妹スキルとして設計されており、事業性の穴はgame-biz-review、権利・規約・表現リスクはgame-legal-reviewが担当する。

## 導入方法(Claude Code)

```bash
git clone https://github.com/<Organization or Owner>/game-review-skills.git ~/game-review-skills

mkdir -p ~/.claude/skills
ln -s ~/game-review-skills/game-biz-review ~/.claude/skills/game-biz-review
ln -s ~/game-review-skills/game-legal-review ~/.claude/skills/game-legal-review
```

シンボリックリンクにしておくと、`git pull` するだけで全員が最新版を使える。

Windowsの場合は管理者権限で `mklink /D` を使う:

```powershell
mklink /D "%USERPROFILE%\.claude\skills\game-legal-review" "%USERPROFILE%\game-review-skills\game-legal-review"
mklink /D "%USERPROFILE%\.claude\skills\game-biz-review" "%USERPROFILE%\game-review-skills\game-biz-review"
```

## 導入方法(Codex)

Codexは `~/.agents/skills/`(または `<リポジトリ>/.agents/skills/`)からスキルを読み込む。Claude Codeと同様にシンボリックリンクで共有できる:

```bash
mkdir -p ~/.agents/skills
ln -s ~/game-review-skills/game-biz-review ~/.agents/skills/game-biz-review
ln -s ~/game-review-skills/game-legal-review ~/.agents/skills/game-legal-review
```

game-legal-reviewはweb検索を前提にした設計のため、Codex側でネットワークアクセス(検索)が有効になっているか確認すること。

## 導入方法(claude.ai)

各スキルフォルダをZIP化し、claude.aiの Customize > Skills からアップロードして「Save skill」を押す。

## 更新について

スキルの内容(SKILL.md・references/)を変更したら、通常のコードと同じようにcommit・pushする。他のメンバーは `git pull` するだけで最新版が反映される(シンボリックリンク運用の場合)。
