# game-review-skills

Claude Code / claude.ai / Codex で使うゲーム企画レビュー用スキル集。

企画書を読ませると、「事業として成立するか」と「規約・権利的に出して大丈夫か」の2つの観点で自動レビューしてくれる。企画が固まったら、実装に入るための開発キット一式もこのリポジトリで生成できる。

会社の企画書でも、個人制作・同人・インディーの企画でも使える。企画の規模に合わせて、該当しない観点(権利元との交渉など)はスキップされる。

---

## 📊 game-biz-review — 事業性レビュー

「面白いかどうか」ではなく「事業として成り立つか」を見る。数値・コスト・継続性など、その企画に金と時間を注ぐ判断に必要な要素の抜け漏れを洗い出す。

**わかること:**
- 他社IPを使う場合、権利元との契約前に確認すべきこと(表現範囲・広告可否・ガチャ条件など)と監修負荷の見積もり
- 「そこそこ売れる」のような曖昧な目標を、具体的な数値目標(DAU・継続率・課金率など)に落とし込めているか
- リリース後も更新し続ける企画なら、その制作量を実際に供給できる体制があるか
- コンテンツが尽きたときの対策(弾切れ対策)や、撤退するときの計画があるか
- プロトタイプで何を検証できて、何は検証できないままリリースすることになるか
- 同じジャンルの過去の失敗例と比べて、同じ轍を踏んでいないか
- 課金の仕組みとゲームの面白さが、お互いの邪魔をしていないか

**呼び出し方の例:** 「企画書レビューして」「経営に通る形にしたい」「事業性を見て」

---

## ⚖️ game-legal-review — 権利・規約・表現リスクレビュー

「規約・商標・特許・法律・炎上リスクに引っかからないか」を見る。専門家(弁理士・弁護士)の代わりではなく、専門家に相談する前の一次チェックと、相談資料づくりまで担当する。

**わかること:**
- Steam / App Store / Google Play それぞれの審査で引っかかりそうな箇所(賭博性、ガチャの確率表示義務、常駐アプリの挙動など)
- 日本のスマホ新法に関する外部決済(リンクアウト等)を使う場合の手数料・条件の見落とし
- タイトル名やキャラ名が、既存の商標や有名作品とかぶっていないか
- ゲームのシステム自体が、他社の特許と似ていないか
- 日本の法律(景品表示法・資金決済法・賭博罪・風営法など)に引っかかる設計になっていないか
- 海外展開する場合の規制(GDPR、国ごとのガチャ規制、未成年保護など)
- 差別的な表現や宗教的なタブー、国によって意味が変わってしまう名称がないか
- シナリオや台詞が、CEROなどの年齢レーティングにどう影響するか
- 上記で「専門家に相談したほうがいい」と判定された項目について、相談用の資料まで一次調査して用意する

**呼び出し方の例:** 「商標大丈夫?」「規約に引っかからない?」「このシナリオ問題ない?」「CERO的に大丈夫?」「法務レビューして」

---

## 🛠️ game-dev-kit — AIコーディング開発キット生成

企画が固まって実装に入る段階で、Claude Code等がそのまま読み込める開発キット(CLAUDE.md・spec.md)を生成する。非エンジニアのディレクター/プロデューサーが、実装の準備を一人で整えられるようにするためのもの。

**わかること・作れるもの:**
- 企画・仕様の相談内容を、Claude Codeがそのまま実装に使える形式のドキュメントに変換
- Sonnetのようなモデルでも安定して回せる粒度・書き方に整理した仕様書
- 開発を始める前に決めておくべきことの整理
- 何の言語・ツールで作るかが決まっていない場合の選定(AIに書かせる前提での相性、コードを読まずに動作確認できるか、配信先の要件から判断)

**呼び出し方の例:** 「CLAUDE.md作って」「spec作って」「開発準備して」「プロトタイプ作りたい」「実装の準備をしたい」

---

より詳しいチェック項目の一覧は **[SKILLS-OVERVIEW.md](./SKILLS-OVERVIEW.md)** を参照。

両スキルは姉妹スキルとして設計されており、事業性の穴はgame-biz-review、権利・規約・表現リスクはgame-legal-reviewが担当する。

## 導入方法(Claude Code)

```bash
git clone https://github.com/illed-works/game-review-skills.git ~/game-review-skills

mkdir -p ~/.claude/skills
ln -s ~/game-review-skills/game-biz-review ~/.claude/skills/game-biz-review
ln -s ~/game-review-skills/game-legal-review ~/.claude/skills/game-legal-review
ln -s ~/game-review-skills/game-dev-kit ~/.claude/skills/game-dev-kit
```

シンボリックリンクにしておくと、`git pull` するだけで全員が最新版を使える。

Windowsの場合は管理者権限で `mklink /D` を使う:

```powershell
mklink /D "%USERPROFILE%\.claude\skills\game-legal-review" "%USERPROFILE%\game-review-skills\game-legal-review"
mklink /D "%USERPROFILE%\.claude\skills\game-biz-review" "%USERPROFILE%\game-review-skills\game-biz-review"
mklink /D "%USERPROFILE%\.claude\skills\game-dev-kit" "%USERPROFILE%\game-review-skills\game-dev-kit"
```

## 導入方法(Codex)

Codexは `~/.agents/skills/`(または `<リポジトリ>/.agents/skills/`)からスキルを読み込む。Claude Codeと同様にシンボリックリンクで共有できる:

```bash
mkdir -p ~/.agents/skills
ln -s ~/game-review-skills/game-biz-review ~/.agents/skills/game-biz-review
ln -s ~/game-review-skills/game-legal-review ~/.agents/skills/game-legal-review
ln -s ~/game-review-skills/game-dev-kit ~/.agents/skills/game-dev-kit
```

game-legal-reviewはweb検索を前提にした設計のため、Codex側でネットワークアクセス(検索)が有効になっているか確認すること。

## 導入方法(claude.ai)

各スキルフォルダをZIP化し、claude.aiの Customize > Skills からアップロードして「Save skill」を押す。

## 更新について

スキルの内容(SKILL.md・references/)を変更したら、通常のコードと同じようにcommit・pushする。他のメンバーは `git pull` するだけで最新版が反映される(シンボリックリンク運用の場合)。
