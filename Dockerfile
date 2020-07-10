FROM ruby:2.6.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# google-chromeインストール
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# ChromeDriverインストール
RUN curl -O https://chromedriver.storage.googleapis.com/2.9/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp

# コンテナ開始時に実行するスクリプト
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000   

# railsサーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]