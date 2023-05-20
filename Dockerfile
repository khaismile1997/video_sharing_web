FROM ruby:3.0.6
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs\
  && rm -rf /var/lib/apt/lists/* \
  && curl -o- -L https://yarnpkg.com/install.sh | bash
RUN mkdir /video_sharing_web
WORKDIR /video_sharing_web

# https://bundler.io/v2.1/man/bundle-config.1.html#CONFIGURATION-KEYS
ENV BUNDLER_VERSION 2.1.4

ADD Gemfile /video_sharing_web/Gemfile
ADD Gemfile.lock /video_sharing_web/Gemfile.lock

# Clean unnecessary files at runtime to reduce DockerImage size.
RUN echo 'gem: --no-document' > ~/.gemrc && \
    gem install bundler --version $BUNDLER_VERSION

RUN bundle config set no-cache 'true' && \
    BUNDLE_FORCE_RUBY_PLATFORM=1 bundle install --jobs=4

RUN npm install -g yarn
RUN yarn install --check-files

RUN rm -rf ~/.bundle/cache && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    rm -rf /usr/local/bundle/cache/bundler && \
    rm -rf /usr/local/bundle/bundler/gems/**/.git && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . /video_sharing_web

# Copy the entrypoint script into the image.
COPY entrypoint.sh /usr/bin/

# Set the entrypoint.
ENTRYPOINT ["entrypoint.sh"]