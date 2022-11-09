FROM ruby:2.7.6

# apt-get関連
RUN apt-get update && apt-get install -y \
  build-essential \
  postgresql-client \
  net-tools \
  redis-server

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs

# yarn関連
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn 

# circleci
RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash

# timezone
ENV TZ Asia/Tokyo

# yarn install & bundle install ※キャッシュを生かす為、先に実行
RUN mkdir /myapp
WORKDIR /myapp 
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY package.json /myapp/package.json
COPY yarn.lock /yarn.lock
RUN yarn install

# PJディレクトリをコピー
COPY . /myapp
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# railsコマンド各種
RUN EDITOR=vim rails credentials:edit
RUN rails assets:precompile RAILS_ENV=production
RUN bin/webpack


# 起動コマンド各種
ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]