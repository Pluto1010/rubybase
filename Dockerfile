FROM debian:jessie

MAINTAINER Dennis Schulz (https://github.com/Pluto1010)

# Install ruby stuff
RUN apt-get update -q -y
RUN apt-get install -q -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
RUN git clone git://github.com/sstephenson/rbenv.git .rbenv
RUN git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

ENV PATH /.rbenv/bin:/.rbenv/plugins/ruby-build/bin:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc

ENV CONFIGURE_OPTS --disable-install-doc

RUN rbenv install 2.2.4
RUN rbenv global 2.2.4

RUN . /etc/profile.d/rbenv.sh && gem install bundler
