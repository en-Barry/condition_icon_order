FROM ruby:3.1.2
RUN apt-get update -qq
RUN apt-get install -y build-essential curl default-libmysqlclient-dev
RUN wget -P /bin https://raw.githubusercontent.com/tj/n/master/bin/n
RUN chmod +x /bin/n
RUN n 16.13.1
RUN npm install npm@latest -g
RUN npm install yarn -g
RUN apt-get update && apt-get install -y \
    libnss3 \
    libx11-xcb1 \
    locales \
    task-japanese \
    unzip \
    default-libmysqlclient-dev \
    make build-essential \
    vim \
    cron
RUN gem update --system
ENV APP_ROOT /myapp
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
ENV BUNDLER_VERSION 2.1.4
CMD ["cron", "-f"] 
RUN bundle config set path 'vendor/bundle' \
        && gem install bundler -v $BUNDLER_VERSION \
    && bundle install --jobs 4
# ADD ./package.json package.json
# RUN yarn install
# Japanese Settings
RUN locale-gen ja_JP.UTF-8 && localedef -f UTF-8 -i ja_JP ja_JP
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:jp
ENV LC_ALL ja_JP.UTF-8