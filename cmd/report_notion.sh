#!/bin/bash

source "$(dirname "$0")/.config/.env"
CACHE_PATH="$(dirname "$0")/.cache/notion_report.cache"

## 実行モード
mode_options=("Register" "Display" "Exit")
echo "1) Register  (Default)"
echo "2) Display"
echo "3) Exit"

read -p "登録モードを選択してください(Default:Register): " choice
choice=${choice:-1}
case $choice in
    1)
        mode_label="登録モード"
        mode=""
        echo "${mode_label}で実行";;
    2)
        mode_label="表示モード"
        mode="--display"
        echo "${mode_label}で実行";;
    3)
        exit 0 ;;
    *)
        echo "不正な入力"
        exit 0 ;;
esac
echo ""
echo ""


## 対象期間
custom_flag=0
term_options=("今日" "昨日" "今週" "先週" "今月" "先月" "カスタム" "Exit")
echo "1) 今日  (Default)"
echo "2) 昨日"
echo "3) 今週"
echo "4) 先週"
echo "5) 今月"
echo "6) 先月"
echo "7) カスタム"
echo "8) Exit"

read -p "対象期間を選択してください(Default:今日): " choice
choice=${choice:-1}
case $choice in
    1)
        term_label="今日"
        term="--today"
        echo "対象期間:${term_label}" ;;
    2)
        term_label="昨日"
        term="--yesterday"
        echo "対象期間:${term_label}" ;;
    3)
        term_label="今週"
        term="--week"
        echo "対象期間:${term_label}" ;;
    4)
        term_label="先週"
        term="--last-week"
        echo "対象期間:${term_label}" ;;
    5)
        term_label="今月"
        term="--month"
        echo "対象期間:${term_label}" ;;
    6)
        term_label="先月"
        term="--last-month"
        echo "対象期間:${term_label}" ;;
    7)
        term_label="カスタム"
        custom_flag=1
        term=""
        echo "対象期間:${term_label}" ;;
    8)
        exit 0 ;;
    *)
        echo "不正な入力"
        exit 0 ;;
esac
echo ""
echo ""

## 期間指定（カスタム選択時のみ実行）
if [ ${custom_flag} -eq 1 ];then
    today=$(date +%Y-%m-%d)

    read -p "開始日を入力してください(YYYY-MM-DD) " from_date
    from_date=${from_date:-$today}

    read -p "終了日を入力してください(YYYY-MM-DD) " to_date
    to_date=${to_date:-$today}

    echo ""
    echo "1) daily"
    echo "2) weekly"
    echo "3) monthly"
    echo "4) quarterly  (Default)"

    read -p "登録テンプレートを入力してください(Default: quarterly) " choice
    choice=${choice:-4}
    case $choice in
        1)
            report_type="daily"
            report_type_label="daily"
            ;;
        2)
            report_type="weekly"
            report_type_label="weekly"
            ;;
        3)
            report_type="monthly"
            report_type_label="monthly"
            ;;
        4)
            report_type="quarterly"
            report_type_label="quarterly"
            ;;
        *)
            echo "不正な入力"
            exit 0 ;;
    esac

    echo ""
    echo ""
fi


## コマンド組み立て＆確認
if [ ${custom_flag} -eq 1 ];then
    command="python ${REPORT_NOTION_PATH}/main.py ${mode} --report-type ${report_type} --from-date ${from_date} --to-date ${to_date}"
else
    command="python ${REPORT_NOTION_PATH}/main.py ${mode} ${term}"
fi

echo "下記オプションが選択されました"
echo "======================================="
echo "実行モード:${mode_label}"
if [ ${custom_flag} -eq 1 ];then
    echo "対象期間:${from_date} ~ ${to_date}"
    echo "登録フォーマット:${report_type_label}"
else
    echo "対象期間:${term_label}"
fi
echo "======================================="
echo ""

echo "実行コマンド:"
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

## キャッシュ書き込み
echo "command=\"${command}\"" > ${CACHE_PATH}
