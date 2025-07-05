#!/bin/bash

## オプション解析
while (( $# > 0 ))
do
  case $1 in
    -p | --password)
      needPassword=1
      ;;
    -l | --list)
      list=1
      ;;
    -*)
      echo "invalid option"
      exit 1
      ;;
    *)
      ARGS=("${ARGS[@]}" "$1")
      ;;
  esac
  shift
done

## 引数解析
get_nth () {
  local n=$1
  shift
  eval echo \$${n}
}
arg1=$(get_nth 1 "${ARGS[@]}")

# 圧縮
function zip() {
  zipcmd='7z a -scsWIN'
  if [ -n "$needPassword" ]; then
    zipcmd+=" -p"
  fi
  if [ -z $arg1 ] || [ $arg1 = . ]; then
    # 現在の作業ディレクトリをZIPファイルに圧縮する．
    zip_name="$(basename $(pwd)).zip"
    execcmd="fd --type file --strip-cwd-prefix . -X $zipcmd $zip_name {}"
  else
    # 指定したディレクトリをZIPファイルに圧縮する．
    loc_dir=$(dirname $arg1)
    target=$(basename $arg1)
    zip_name="$(pwd)/${target}.zip"
    if [ -d $arg1 ]; then
      execcmd="fd --type file --base-directory=$loc_dir . $target -X $zipcmd $zip_name {}"
    elif [ -f $arg1 ]; then
      target=${target%.*}
      zip_name="$(pwd)/${target}.zip"
      execcmd="$zipcmd $zip_name $arg1"
    else
      echo "対象がディレクトリでもファイルでもありません。"
      exit 1
    fi
fi
}

# 解凍
function unzip() {
  zipcmd='7z x'
  execcmd="$zipcmd $arg1"
}

# 中身表示
function disp() {
  zipcmd='7z l'
  execcmd="$zipcmd $arg1"
}

## 本処理
if [ -n "$list" ]; then
  # 中身を表示
  disp
elif [ -f "$arg1" ]; then
  # 引数がファイルだった場合
  case "$arg1" in
    *\.gz | *\.zip | *\.7z)
      # 圧縮ファイルなら解凍する
      zipflag=0
      unzip
      ;;
    *)
      # 圧縮ファイル以外
      zipflag=1
      zip
      ;;
  esac
else
  # ディレクトリが指定されている場合
  zip
fi

echo $execcmd
eval $execcmd

# 作成したZIPファイルに含まれるファイルを確認する．不要であればコメントアウトしてください．
if [ -n "$zipflag" ] && [ $zipflag = 1 ]; then
  7z l $zip_name
fi

exit 0
