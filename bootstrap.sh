#!/usr/bin/env bash

# add deb source for llvm packages that are required by xargo
# todo: make it reproducible when doing "vagrant reload --provision"
#sudo echo -e "deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-5.0 main" | sudo tee --append /etc/apt/sources.list > /dev/null
#sudo echo -e "deb-src http://apt.llvm.org/stretch/ llvm-toolchain-stretch-5.0 main" | sudo tee --append /etc/apt/sources.list > /dev/null

# gpg key for llvm sources
#wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -

# add backports source to get lld
sudo echo -e "deb http://ftp.debian.org/debian stretch-backports main" | sudo tee --append /etc/apt/sources.list > /dev/null

sudo apt-get update

# required by xargo
sudo apt-get install -y curl

# install and configure lld
sudo apt-get install lld-5.0
sudo ln -s /usr/lib/llvm-5.0/bin/lld /usr/bin/ld.lld

# install and configure llvm
#sudo apt-get install -y clang-5.0 clang-tools-5.0 clang-5.0-doc libclang-common-5.0-dev libclang-5.0-dev libclang1-5.0 libclang1-5.0-dbg libllvm5.0 libllvm5.0-dbg lldb-5.0 llvm-5.0 llvm-5.0-dev llvm-5.0-doc llvm-5.0-examples llvm-5.0-runtime clang-format-5.0 python-clang-5.0 libfuzzer-5.0-dev
#sudo rm /usr/bin/ld; sudo ln -s /usr/lib/llvm-5.0/bin/lld /usr/bin/ld

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
rustup default nightly
rustup component add rust-src
cargo install --force xargo
cargo install --force bootimage
