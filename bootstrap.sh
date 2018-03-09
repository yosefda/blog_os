#!/usr/bin/env bash

# add backports source to get lld
sudo echo -e "deb http://ftp.debian.org/debian stretch-backports main" | sudo tee --append /etc/apt/sources.list > /dev/null

sudo apt-get update

# required by xargo
sudo apt-get install -y curl

# install and configure lld
sudo apt-get install -y lld-5.0
sudo ln -s /usr/lib/llvm-5.0/bin/lld /usr/bin/ld.lld

# required by bootimage
sudo apt-get install -y pkg-config libssl-dev
sudo apt-get install -y zlib1g-dev

# set working directory
# this is because xargo (llvm) doesnt work when compiling from vboxsf
# so we copy the files from /vagrant to a working directory
#ln -s /vagrant $HOME/rust_projects
mkdir -p $HOME/blog_os
cp -r /vagrant/* $HOME/blog_os
RUST_TARGET_PATH="$HOME/blog_os"

# install rust and its dependencies
curl https://sh.rustup.rs -sSf | sh -s -- -y
/home/vagrant/.cargo/bin/rustup default nightly
/home/vagrant/.cargo/bin/rustup component add rust-src
/home/vagrant/.cargo/bin/cargo install --force xargo
/home/vagrant/.cargo/bin/cargo install --force bootimage
