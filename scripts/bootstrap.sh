#!/bin/bash

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

if [ ! -d "$DOWNLOAD_DIR" ]; then
  mkdir -p "$DOWNLOAD_DIR"
fi

curl http://download.opensuse.org/repositories/utilities/CentOS_6/utilities.repo -o "/etc/yum.repos.d/utilities.repo"

yum -y install vim-enhanced wget gcc kernel-devel make ncurses-devel man man-pages epel-release yum-utils unzip libcurl-devel perl-ExtUtils-MakeMaker.x86_64 gettext zlib-devel \
java-1.8.0-openjdk java-1.8.0-openjdk-devel rcm

# Libevent2
if [ ! -f "$DOWNLOAD_DIR/libevent-2.0.22-stable.tar.gz" ]; then
	wget -q -O "/tmp/libevent-2.0.22-stable.tar.gz" "https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz"
else
	cp "$DOWNLOAD_DIR/libevent-2.0.22-stable.tar.gz" "/tmp/libevent-2.0.22-stable.tar.gz"
fi

cd /tmp
tar -xzvf "libevent-2.0.22-stable.tar.gz"
cd "libevent-2.0.22-stable" 
./configure --prefix=/usr/local 
make && make install

# Tmux 
if [ ! -f "$DOWNLOAD_DIR/tmux-2.2.tar.gz" ]; then
	wget -q -O "/tmp/tmux-2.2.tar.gz" "https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz"
else
	cp "$DOWNLOAD_DIR/tmux-2.2.tar.gz" "/tmp/tmux-2.2.tar.gz"
fi

cd /tmp
tar -xvzf "tmux-2.2.tar.gz"
cd "tmux-2.2"
LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
make && make install

# Git
GIT_VERSION="2.9.2"
if [ ! -f "$DOWNLOAD_DIR/git-$GIT_VERSION.tar.gz" ]; then
	wget -q -O "/tmp/git-$GIT_VERSION.tar.gz" "https://github.com/git/git/archive/v$GIT_VERSION.tar.gz"
else
	cp "$DOWNLOAD_DIR/git-$GIT_VERSION.tar.gz" "/tmp/git-$GIT_VERSION.tar.gz"
fi

cd /tmp
tar -xvzf "git-$GIT_VERSION.tar.gz"
cd "git-$GIT_VERSION"
make configure
./configure --prefix=/usr/local
make all NO_TCLTK=YesPlease
make install 







	




