# railsチュートリアルと同一のものを使用
FROM ruby:2.7.6

    # 最新のパッケージ情報を取得
RUN apt-get update && apt-get install -y \
  build-essential \
  postgresql-client \
  net-tools

# nodejsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs

# yarnパッケージ管理ツールをインストール
# -sS => エラーを表示
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn && \
  yarn add jquery@3.4.1 bootstrap@3.4.1

RUN mkdir /myapp
# ruby:2.5のデフォの作業dirは"/"であるため、必ず作業dirを作成
WORKDIR /myapp 
# ローカルのGemfileとGemfile.lockをコンテナにコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# これにより、二度目移行のbuild実行時にbindされたソースコードをイメージに含めることが可能
COPY . /myapp

# Add a script to be executed every time the container starts.
 COPY entrypoint.sh /usr/bin/
 RUN chmod +x /usr/bin/entrypoint.sh
 ENTRYPOINT ["entrypoint.sh"]

# CMD ["rails", "server", "-b", "0.0.0.0"]