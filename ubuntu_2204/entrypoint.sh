#!/bin/bash

# /home/dev ディレクトリが存在しない場合は作成
if [ ! -d "/home/dev" ]; then
    echo "Creating /home/dev directory..."
    mkdir -p /home/dev
    chown -R dev:dev /home/dev
fi

# コンテナのデフォルトコマンドを実行
exec "$@"
