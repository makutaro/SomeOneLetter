#!/bin/bash

# エラーが発生した場合スクリプトを強制終了
set -e

# rails のプロセスが存在していれば削除
# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid


# エイリアスを追加
echo "alias c='code'" >> ~/.bashrc
echo "alias r='rails'" >> ~/.bashrc
# echo "alias g='git -c'" >> ~/.bashrc
# echo "alias c='code'" >> ~/.bashrc
# echo "alias c='code'" >> ~/.bashrc
# echo "alias c='code'" >> ~/.bashrc
source ~/.bashrc

# 初回のみ
rails db:create
echo "-- create 完了 --"
rails db:migrate:reset
echo "-- migrate 完了 --"
rails db:reset
echo "-- reset 完了 --"

# DockerfileのCMDで渡されたコマンド（→Railsのサーバー起動）を続けて実行
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"