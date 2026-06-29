#!/bin/bash
# Windows互換ZIPの圧縮・解凍スクリプト。
# - ZIPファイルが渡されたら解凍（同名ディレクトリに展開）
# - それ以外は圧縮（Mac固有ファイルを除外）
# Usage: zipForWindows.sh [-p] <対象ファイル/ディレクトリ...>
#        zipForWindows.sh [-p] [出力先.zip] <対象ファイル/ディレクトリ...>

set -euo pipefail

EXCLUDE_OPTS=(
  "-xr!.DS_Store"
  "-xr!__MACOSX"
  "-xr!.AppleDouble"
  "-xr!.Spotlight-V100"
  "-xr!.fseventsd"
  "-xr!.TemporaryItems"
  "-xr!.Trashes"
  "-xr!desktop.ini"
  "-xr!Thumbs.db"
)

USE_PASSWORD=false
while getopts ":p" opt; do
  case $opt in
    p) USE_PASSWORD=true ;;
    \?) echo "不明なオプション: -$OPTARG" >&2; exit 1 ;;
  esac
done
shift $((OPTIND - 1))

if [ $# -eq 0 ]; then
  echo "Usage: $(basename "$0") [-p] [出力先.zip] <対象...>" >&2
  exit 1
fi

# 全引数がZIPファイルなら解凍モード
all_zip=true
for arg in "$@"; do
  [[ "$arg" == *.zip && -f "$arg" ]] || { all_zip=false; break; }
done

if $all_zip; then
  for zip_file in "$@"; do
    out_dir="${zip_file%.zip}"
    echo "解凍: $zip_file -> $out_dir/"
    7z x "$zip_file" -o"$out_dir"
    echo ""
  done
  exit 0
fi

# 圧縮モード
# 第1引数が .zip で終わる場合は出力先として使用、そうでなければ自動生成
if [[ "$1" == *.zip ]]; then
  output="$1"
  shift
else
  base=$(basename "$1")
  # ディレクトリはフルネーム、ファイルは拡張子を除いた名前をベースにする
  if [ -d "$1" ]; then
    output="${PWD}/${base}.zip"
  else
    output="${PWD}/${base%.*}.zip"
  fi
fi

if [ $# -eq 0 ]; then
  echo "対象ファイル/ディレクトリを指定してください。" >&2
  exit 1
fi

PASSWORD_OPTS=()
if $USE_PASSWORD; then
  PASSWORD_OPTS=("-p" "-mhe=on")
fi

7z a -tzip -scsWIN "${EXCLUDE_OPTS[@]}" "${PASSWORD_OPTS[@]}" "$output" "$@"

echo ""
echo "作成: $output"
7z l "$output"
