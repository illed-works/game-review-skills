#!/usr/bin/env sh
# 既存リポジトリの直下に散らばった .md を docs/ 配下へ移す（一度だけ実行）。
# git 管理下なら git mv、そうでなければ mv。移動先は名前から推定し、迷ったら docs/notes/。
set -e
mkdir -p docs/worklog docs/specs docs/notes
ALLOW="AGENTS.md CLAUDE.md WORKLOG.md README.md LICENSE.md"
mv_cmd="mv"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 && mv_cmd="git mv"
for f in *.md *.txt; do
  [ -f "$f" ] || continue
  case " $ALLOW " in *" $f "*) continue ;; esac
  lower=$(printf '%s' "$f" | tr 'A-Z' 'a-z')
  case "$lower" in
    worklog*) dest="docs/worklog/" ;;
    spec*|*仕様*) dest="docs/specs/" ;;
    *) dest="docs/notes/" ;;
  esac
  echo "$f → $dest"
  $mv_cmd "$f" "$dest"
done
echo "移動した文書を参照している箇所（AGENTS.md、README 等のリンク）は手で直してください。"
