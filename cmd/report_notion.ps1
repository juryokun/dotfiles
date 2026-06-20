# ========================================
# パス設定
# ========================================
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$CacheDir = Join-Path $ScriptDir ".cache"
$CacheFile = Join-Path $CacheDir "notion_report.cache"

# ========================================
# .env.ps1 読み込み
# ========================================
. (Join-Path $ScriptDir ".config\.env.ps1")

# ========================================
# 実行モード
# ========================================
Write-Host "1) Register  (Default)"
Write-Host "2) Display"
Write-Host "3) Exit"

$choice = Read-Host "登録モードを選択してください(Default:Register)"

if ([string]::IsNullOrWhiteSpace($choice)) {
    $choice = "1"
}

switch ($choice) {
    "1" {
        $modeLabel = "登録モード"
        $mode = ""
    }
    "2" {
        $modeLabel = "表示モード"
        $mode = "--display"
    }
    "3" {
        exit
    }
    default {
        Write-Host "不正な入力"
        exit
    }
}

Write-Host "$modeLabel で実行"
Write-Host ""
Write-Host ""

# ========================================
# 対象期間
# ========================================
$customFlag = $false

Write-Host "1) 今日  (Default)"
Write-Host "2) 昨日"
Write-Host "3) 今週"
Write-Host "4) 先週"
Write-Host "5) 今月"
Write-Host "6) 先月"
Write-Host "7) カスタム"
Write-Host "8) Exit"

$choice = Read-Host "対象期間を選択してください(Default:今日)"

if ([string]::IsNullOrWhiteSpace($choice)) {
    $choice = "1"
}

switch ($choice) {
    "1" {
        $termLabel = "今日"
        $term = "--today"
    }
    "2" {
        $termLabel = "昨日"
        $term = "--yesterday"
    }
    "3" {
        $termLabel = "今週"
        $term = "--week"
    }
    "4" {
        $termLabel = "先週"
        $term = "--last-week"
    }
    "5" {
        $termLabel = "今月"
        $term = "--month"
    }
    "6" {
        $termLabel = "先月"
        $term = "--last-month"
    }
    "7" {
        $termLabel = "カスタム"
        $term = ""
        $customFlag = $true
    }
    "8" {
        exit
    }
    default {
        Write-Host "不正な入力"
        exit
    }
}

Write-Host "対象期間: $termLabel"
Write-Host ""
Write-Host ""

# ========================================
# カスタム期間
# ========================================
if ($customFlag) {

    $today = Get-Date -Format "yyyy-MM-dd"

    $fromDate = Read-Host "開始日を入力してください(YYYY-MM-DD)"
    if ([string]::IsNullOrWhiteSpace($fromDate)) {
        $fromDate = $today
    }

    $toDate = Read-Host "終了日を入力してください(YYYY-MM-DD)"
    if ([string]::IsNullOrWhiteSpace($toDate)) {
        $toDate = $today
    }

    Write-Host ""
    Write-Host "1) daily"
    Write-Host "2) weekly"
    Write-Host "3) monthly"
    Write-Host "4) quarterly  (Default)"

    $choice = Read-Host "登録テンプレートを入力してください(Default:quarterly)"

    if ([string]::IsNullOrWhiteSpace($choice)) {
        $choice = "4"
    }

    switch ($choice) {
        "1" {
            $reportType = "daily"
            $reportTypeLabel = "daily"
        }
        "2" {
            $reportType = "weekly"
            $reportTypeLabel = "weekly"
        }
        "3" {
            $reportType = "monthly"
            $reportTypeLabel = "monthly"
        }
        "4" {
            $reportType = "quarterly"
            $reportTypeLabel = "quarterly"
        }
        default {
            Write-Host "不正な入力"
            exit
        }
    }

    Write-Host ""
    Write-Host ""
}

# ========================================
# コマンド作成
# ========================================
if ($customFlag) {

    $command =
        "python `"$REPORT_NOTION_PATH\main.py`" " +
        "$mode " +
        "--report-type $reportType " +
        "--from-date $fromDate " +
        "--to-date $toDate"

}
else {

    $command =
        "python `"$REPORT_NOTION_PATH\main.py`" " +
        "$mode $term"
}

# ========================================
# 確認表示
# ========================================
Write-Host "下記オプションが選択されました"
Write-Host "======================================="
Write-Host "実行モード: $modeLabel"

if ($customFlag) {
    Write-Host "対象期間: $fromDate ～ $toDate"
    Write-Host "登録フォーマット: $reportTypeLabel"
}
else {
    Write-Host "対象期間: $termLabel"
}

Write-Host "======================================="
Write-Host ""

Write-Host "実行コマンド:"
Write-Host "  $command"
Write-Host ""
Write-Host ""

# ========================================
# 実行確認
# ========================================
Write-Host "1) Yes  (Default)"
Write-Host "2) No"

$choice = Read-Host "実行しますか？(Default:Yes)"

if ([string]::IsNullOrWhiteSpace($choice)) {
    $choice = "1"
}

switch ($choice) {
    "1" {
        Invoke-Expression $command
    }
    default {
        Write-Host "実行を中止しました"
        exit
    }
}

# ========================================
# キャッシュ保存
# ========================================
if (-not (Test-Path $CacheDir)) {
    New-Item -ItemType Directory -Path $CacheDir | Out-Null
}

"command=`"$command`"" | Set-Content $CacheFile
