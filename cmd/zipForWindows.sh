#!/bin/bash

## オプション解析
while (( $# > 0 ))
do
  case $1 in
    -p | --password)
      needPassword=1
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


## 本処理

zipcmd='7z a -tzip -scsWIN'
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

echo $execcmd
eval $execcmd

# 作成したZIPファイルに含まれるファイルを確認する．不要であればコメントアウトしてください．
7z l $zip_name

exit 0
