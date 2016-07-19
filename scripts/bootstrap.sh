#!/bin/bash

SHARED_DIR=$1

if [ -f "$SHARED_DIR/configs/variables" ]; then
  . "$SHARED_DIR"/configs/variables
fi

if [ ! -d "$DOWNLOAD_DIR" ]; then
  mkdir -p "$DOWNLOAD_DIR"
fi

yum -y install git vim-enhanced wget gcc kernel-devel make ncurses-devel man man-pages

cd /etc/yum.repos.d/
wget http://download.opensuse.org/repositories/utilities/CentOS_6/utilities.repo
yum -y install rcm

# Tmux 1.8

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






	




