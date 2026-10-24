#!/usr/bin/env sh
# npm のないプロジェクト（Godot 等）向け。check-docs.mjs と同じ判定。
set -e
ALLOW="AGENTS.md CLAUDE.md WORKLOG.md README.md LICENSE.md"
status=0
for f in *.md *.txt; do
  [ -f "$f" ] || continue
  case " $ALLOW " in
    *" $f "*) ;;
    *) echo "直下に置けない文書: $f → docs/ 配下へ"; status=1 ;;
  esac
done
for d in docs docs/worklog docs/specs docs/notes; do
  [ -d "$d" ] || { echo "必要なフォルダがありません: $d"; status=1; }
done
[ $status -eq 0 ] && echo "docs layout: OK"
exit $status
