FROM kottur/ruby-opencv
RUN apt-get update -qq && apt-get install -y build-essential nodejs
RUN mkdir /spacehack-app
WORKDIR /spacehack-app
ADD Gemfile /spacehack-app/Gemfile
ADD Gemfile.lock /spacehack-app/Gemfile.lock
RUN gem install bundler && bundle install
ADD . /spacehack-app