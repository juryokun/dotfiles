#!/bin/bash

source "$(dirname "$0")/.cache/notion_report.cache"

echo "前回実行コマンド:"
echo "  ${command}"
echo ""
echo ""

## コマンド実行
exec_options=("Yes" "No")
echo "1) Yes  (Default)"
echo "2) No"

read -p "実行しますか？(Default:Yes)" choice
choice=${choice:-1}
case $choice in
    1)
        eval ${command};;
    2)
        echo "実行を中止しました"
        exit 0 ;;
    *)
        echo "実行を中止しました"
        exit 0 ;;
esac
