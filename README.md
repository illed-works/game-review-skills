# game-review-skills

## English

**game-review-skills** is a set of Claude/Codex agent skills that take a game idea all the way from a rough flash of inspiration to implementation-ready docs:

- 💡 **game-pitch-kit** — Give it a rough idea. It researches competitors and prior art on the web, then gives an honest go/no-go verdict — **if the idea looks doomed, it says so before writing anything.** If it's promising, it asks the minimum necessary questions and drafts a proposal where every item is labeled *decided by you / assumed by AI / undecided*.
- 📊 **game-biz-review** — Reviews a proposal for business viability: fuzzy goals that need real numbers, live-ops sustainability, content burn-out, exit criteria, lessons from failed games in the same genre. It is designed **not** to flatter and **not** to dress up a doomed plan.
- ⚖️ **game-legal-review** — Reviews proposals, specs, and scenarios for platform-policy risks (Steam / App Store / Google Play), trademark collisions, game-mechanic patents, regulations (Japan + GDPR / loot-box laws / minor protection), cultural taboos, and age-rating (CERO / IARC) issues. First-pass screening only — not a substitute for a lawyer.
- 🛠️ **game-dev-kit** — Once a plan is set, generates CLAUDE.md + spec.md so non-engineers can direct AI coding tools reliably. Includes tech-stack and server/infrastructure selection guidance when nothing is decided yet.
- 🔒 **game-security-review** — Reviews a game before release for cheat resistance and fraud: secrets leaking into the client, missing server authority, receipt-verification gaps, replay attacks and double-granting, IDOR, rate limiting, and save-data tampering. Outputs a severity-ranked risk report plus a list of questions you can hand straight to an engineer.
- 🧹 **sanitize-artifacts** — Strips conversation residue from generated deliverables so proposals and specs read as documents designed for their audience, not as transcripts of the prompting that produced them. Runs automatically before any deliverable is written out.

The skill bodies are currently written in Japanese, but **they work in any language** — each skill is instructed to always respond in the user's language. Install them the same way as described below (clone + symlink into `~/.claude/skills/` or `~/.agents/skills/`). Japan-specific legal content is modular and only applied when your target market makes it relevant.

Everything here is MIT-licensed and provided as-is; see the Disclaimer section. Contributions and translations welcome.

---


Claude Code / claude.ai / Codex で使うゲーム企画レビュー用スキル集。

思いつき段階のアイデアは、調査と判定を経て企画書に立ち上げられる(game-pitch-kit)。できた企画書は「事業として成立するか」(game-biz-review)と「規約・権利的に出して大丈夫か」(game-legal-review)の2つの観点で自動レビュー。企画が固まったら、実装に入るための開発キット一式も生成できる(game-dev-kit)。アイデア→企画書→レビュー→実装準備まで一気通貫。

会社の企画書でも、個人制作・同人・インディーの企画でも使える。企画の規模に合わせて、該当しない観点(権利元との交渉など)はスキップされる。

---

## 💡 game-pitch-kit — アイデアから企画書への立ち上げ

思いつき段階のアイデアを投げると、競合・既出・市場性をweb調査した上で「進める価値があるか」を先に判定する。**ダメそうなら企画書を書く前にハッキリそう言う。** 有望なら、必要な質問だけを経て企画書ドラフトまで仕上げ、**そのまま事業性レビューと権利レビューに自動接続する**。

**わかること・作れるもの:**
- 同じコンセプトの先行作品があるか、競合はどれくらい強いか
- 近いジャンルの成功例・失敗例と、失敗の死因
- 進める価値があるかの3段階判定(🟢進める/🟡条件付き/🔴止めるべき)と、その根拠
- 判定を通ったアイデアの企画書ドラフト(自分が決めたこと/AIの仮置き/未決、が区別されたラベル付き)

**呼び出し方の例:** 「このアイデアどう思う」「思いつきなんだけど」「企画にできそうか調べて」「壁打ちして」

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
- 仕様書の各システムに「約束の3点」(入力の条件・結果の約束・いつでも守ること)の表を付け、そこからテストを先に作らせる。お金や報酬など、丸めると事故になる値を守るため
- 変更の影響範囲の確認、別解を並べて選ぶ進め方(アリーナ)、文書の置き場のルールと検査スクリプト

**呼び出し方の例:** 「CLAUDE.md作って」「spec作って」「開発準備して」「プロトタイプ作りたい」「実装の準備をしたい」

---

## 🔒 game-security-review — チート耐性・不正対策レビュー

リリース前に「チートされないか」「課金アイテムを複製・水増しされないか」「クライアント側に秘密情報が漏れていないか」を点検する。ブラウザゲーム(JS/Unity WebGL)を主軸に、モバイル・Steam・Robloxも対象。

**わかること:**

- クライアントに出てはいけない情報(APIキー・管理URL・内部エンドポイント・.env/.git/ソースマップの公開)が露出していないか
- サーバー権威性の欠如(クライアントの申告でアイテム付与、スコア送信、価格をクライアントから受領)
- 課金レシートの検証漏れ、リプレイ攻撃による二重付与
- 他人のデータを読めてしまう認可漏れ(IDOR)、レート制限、セーブデータ改ざん
- 不正が起きたときの検知・緊急停止・回収手順が用意されているか
- 上記を重大度付きで整理したリスクレポートと、エンジニアにそのまま投げられる質問リスト

コードが読めなくても使える。ソースコード・ビルド成果物・仕様書のいずれからでも点検できる。

**呼び出し方の例:** 「リリース前にチェックして」「チート対策見て」「ソースに鍵入ってない?」「課金アイテム複製できちゃう」「公開して大丈夫?」

---

## 🧹 sanitize-artifacts — 成果物から会話の痕跡を消す

企画書やspec.mdは壁打ちを重ねて作るため、「ご指示のとおり」「前回と違い」「〜は使わない方針のため」といった制作過程の記述が本文に残りやすい。このスキルはそれを落とし、読み手に向けて初めから設計された文書として仕上げる。

制約は説明文としてではなく、設計として反映する。「Gitは使わない前提です」と書くのではなく、最初からGoogleドライブを使う手順を書く。

game-pitch-kit と game-dev-kit は、成果物を書き出す前にこのスキルを自動で呼ぶ。単体で「納品用に整えて」「会話の痕跡を消して」「清書して」と頼むこともできる。

**呼び出し方の例:** 「納品用に整えて」「これそのまま渡せる形にして」「このまま共有して大丈夫?」

---

より詳しいチェック項目の一覧は **[SKILLS-OVERVIEW.md](./SKILLS-OVERVIEW.md)** を参照。

レビュー系の3スキルは担当を分けてある。事業性はgame-biz-review、権利・規約・表現リスクはgame-legal-review、実装のチート耐性・不正対策はgame-security-reviewが見る。面白さの批評はいずれも扱わない。

## 導入方法(Claude Code)

```bash
git clone https://github.com/illed-works/game-review-skills.git ~/game-review-skills

mkdir -p ~/.claude/skills
ln -s ~/game-review-skills/game-biz-review ~/.claude/skills/game-biz-review
ln -s ~/game-review-skills/game-legal-review ~/.claude/skills/game-legal-review
ln -s ~/game-review-skills/game-dev-kit ~/.claude/skills/game-dev-kit
ln -s ~/game-review-skills/game-pitch-kit ~/.claude/skills/game-pitch-kit
ln -s ~/game-review-skills/game-security-review ~/.claude/skills/game-security-review
ln -s ~/game-review-skills/sanitize-artifacts ~/.claude/skills/sanitize-artifacts
```

シンボリックリンクにしておくと、`git pull` するだけで全員が最新版を使える。

Windowsの場合は管理者権限で `mklink /D` を使う:

```powershell
mklink /D "%USERPROFILE%\.claude\skills\game-legal-review" "%USERPROFILE%\game-review-skills\game-legal-review"
mklink /D "%USERPROFILE%\.claude\skills\game-biz-review" "%USERPROFILE%\game-review-skills\game-biz-review"
mklink /D "%USERPROFILE%\.claude\skills\game-dev-kit" "%USERPROFILE%\game-review-skills\game-dev-kit"
mklink /D "%USERPROFILE%\.claude\skills\game-pitch-kit" "%USERPROFILE%\game-review-skills\game-pitch-kit"
mklink /D "%USERPROFILE%\.claude\skills\game-security-review" "%USERPROFILE%\game-review-skills\game-security-review"
mklink /D "%USERPROFILE%\.claude\skills\sanitize-artifacts" "%USERPROFILE%\game-review-skills\sanitize-artifacts"
```

## 導入方法(Codex)

Codexは `~/.agents/skills/`(または `<リポジトリ>/.agents/skills/`)からスキルを読み込む。Claude Codeと同様にシンボリックリンクで共有できる:

```bash
mkdir -p ~/.agents/skills
ln -s ~/game-review-skills/game-biz-review ~/.agents/skills/game-biz-review
ln -s ~/game-review-skills/game-legal-review ~/.agents/skills/game-legal-review
ln -s ~/game-review-skills/game-dev-kit ~/.agents/skills/game-dev-kit
ln -s ~/game-review-skills/game-pitch-kit ~/.agents/skills/game-pitch-kit
ln -s ~/game-review-skills/game-security-review ~/.agents/skills/game-security-review
ln -s ~/game-review-skills/sanitize-artifacts ~/.agents/skills/sanitize-artifacts
```

game-legal-reviewはweb検索を前提にした設計のため、Codex側でネットワークアクセス(検索)が有効になっているか確認すること。

## 導入方法(claude.ai)

各スキルフォルダをZIP化し、claude.aiの Customize > Skills からアップロードして「Save skill」を押す。

## 更新について

スキルの内容(SKILL.md・references/)を変更したら、通常のコードと同じようにcommit・pushする。他のメンバーは `git pull` するだけで最新版が反映される(シンボリックリンク運用の場合)。

## 免責事項

- 本スキル群は**無保証**で提供される。利用によって生じたいかなる損害についても、作者は責任を負わない。
- 本スキル群の出力は、**法的助言・法律判断ではない**。特に `game-legal-review` は、企画段階でリスクの当たりをつけるための一次スクリーニングであり、弁護士・弁理士による判断を代替しない。商標・特許・法規制に関わる最終的な判断は、必ず専門家に確認すること。
- 同様に、`game-biz-review` の出力は投資助言ではない。事業判断は利用者自身の責任で行うこと。
- 本スキル群はLLM(大規模言語モデル)に読ませて使うものであり、出力内容は使用するモデル・時期・入力によって変動する。**指摘の見落としや誤りが起こりうる前提**で利用すること。特に法規制・プラットフォーム規約は頻繁に改定されるため、重要な判断の根拠にする場合は必ず一次情報を自分で確認すること。
- 本リポジトリの内容は、特定の企業・団体の見解を代表するものではない。

## ライセンス

MIT License. 詳細は [LICENSE](./LICENSE) を参照。

改変・再配布は自由。自分の環境や制作スタイルに合わせて書き換えて使ってもらって構わない。

`sanitize-artifacts` は [kotek-7/dotfiles](https://github.com/kotek-7/dotfiles) の同名スキルを元に、日本語の発火フレーズと検出対象を追記したもの。
