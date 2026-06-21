# ========================================
# パス設定
# ========================================
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $ScriptDir ".config\.env.ps1")

$python = $OCR_PYTHON_PATH

& $python $MY_OCR_SRC_PATH
