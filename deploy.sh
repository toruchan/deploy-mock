#!/bin/sh

# 関数
## ブランチの存在確認用の関数
branch_check() {
    git fetch && git checkout $branch
    if [ $? != 0 ]; then
        echo "リ｀・ヮ・) < チェックアウトに失敗 or 実行ディレクトリが違うんだよ！"
        exit 1
    fi
}

## デプロイ用の関数
deploy() {    branch_check
    for host in ${hosts[@]}; do
        echo "リ｀・ヮ・) < ${host}にsshしてcdして${branch}をpullするよ！"
    done
}

# メイン処理
##引数の数をチェック
if [ $# -ne 2 ]; then
     echo "リ｀・ヮ・) < 引数はにこちゃんだよ！" 1>&2
     echo "リ｀・ヮ・) < deploy.sh 環境名 ブランチ名 で実行だよ！" 1>&2
     exit 1
fi

##hostの設定
if [ "$1" = "dev" ]; then
    hosts=("dev1" "dev2")
elif [ "$1" = "staging" ]; then
    hosts=("stg1" "stg2")
elif [ "$1" = "production" ]; then
    hosts=("prod1" "prod2")
else
    echo "リ｀・ヮ・) < 環境名が間違ってるよ！"
    exit 1
fi

branch="$2"

deploy

echo "リ｀・ヮ・) < やり遂げたよ...最後まで！"
