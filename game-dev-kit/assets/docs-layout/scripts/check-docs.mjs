#!/usr/bin/env node
// リポジトリ直下に置いてよい文書を制限する検査。
// 直下に許可外の .md / .txt があれば一覧を出して終了コード1で落ちる。
// 使い方: node scripts/check-docs.mjs  （npm run check と pre-commit から呼ぶ）
import { readdirSync, existsSync, statSync } from "node:fs";
import { join } from "node:path";

const ROOT = process.cwd();
const ALLOW = new Set(["AGENTS.md", "CLAUDE.md", "WORKLOG.md", "README.md", "LICENSE.md"]);
const REQUIRED_DIRS = ["docs", "docs/worklog", "docs/specs", "docs/notes"];

const stray = readdirSync(ROOT)
  .filter((f) => /\.(md|txt)$/i.test(f))
  .filter((f) => !ALLOW.has(f))
  .filter((f) => statSync(join(ROOT, f)).isFile());

const missing = REQUIRED_DIRS.filter((d) => !existsSync(join(ROOT, d)));

if (stray.length === 0 && missing.length === 0) {
  console.log("docs layout: OK");
  process.exit(0);
}

if (stray.length > 0) {
  console.error("リポジトリ直下に置けない文書があります。docs/ 配下に移してください。");
  for (const f of stray) console.error(`  ${f}  →  ${suggest(f)}`);
}
if (missing.length > 0) {
  console.error("必要なフォルダがありません: " + missing.join(", "));
}
process.exit(1);

function suggest(name) {
  const n = name.toLowerCase();
  if (n.startsWith("worklog")) return "docs/worklog/";
  if (n.startsWith("spec") || n.includes("仕様")) return "docs/specs/";
  if (n.includes("issue") || n.includes("known")) return "docs/KNOWN_ISSUES.md に統合";
  return "docs/notes/";
}
