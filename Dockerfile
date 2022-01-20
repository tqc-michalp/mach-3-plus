FROM ruby:3.1.0
ENV RUBYOPT='--yjit'
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -qq && apt-get install -y git libpq-dev \
    && apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log
ADD ./.gemrc /root/.gemrc
RUN gem update --system --no-doc
ENV APP_HOME /m3p_worker
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD ./Gemfile $APP_HOME/Gemfile
ADD ./Gemfile.lock $APP_HOME/Gemfile.lock
RUN gem install rake && gem install bundler -v "2.3.5"
RUN bundle _2.3.5_ install -j $(nproc)
COPY . $APP_HOME
