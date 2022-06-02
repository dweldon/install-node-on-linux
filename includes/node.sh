#!/bin/bash

node.latest() {
  local url='https://nodejs.org/dist/latest/'
  local pattern1='>node-v.+-linux-x64.tar.gz'
  local pattern2='[0-9]+\.[0-9]+\.[0-9]+'
  echo "$(curl --silent "$url" | grep -Eo "$pattern1" | grep -Eo "$pattern2")"
}

node.installPackage() {
  local package="$1"

  util.progress "installing $package"
  npm install -g "$package" >& /dev/null
}

node.install() {
  local version="$1"

  # Default to the latest version
  if [ -z "$version" ]; then
    version=$(node.latest)
  fi

  local filename="node-v${version}-linux-x64.tar.gz"
  local url="https://nodejs.org/dist/v${version}/${filename}"
  local nodeDir="$HOME/local"

  # Remove previous installation
  util.progress 'removing'
  rm -rf "$HOME/.npm"
  rm -rf "$HOME/.node-gyp"
  rm -rf "$nodeDir"

  # Download binaries
  util.progress 'downloading'
  util.wget "$url"
  mkdir -p "$nodeDir"
  tar -C "$nodeDir" --strip-components 1 -xzf "$filename"
  rm "$filename"

  # Install everything in the packages file
  local packages="$DIR/packages";
  if [ -f "$packages" ]; then
    while read -r package; do
      if [ -n "$package" ]; then
        node.installPackage "$package"
      fi
    done < "$packages"
  fi
}

node.setup() {
  local bashrc="$HOME/.bashrc"
  local nodeDir="$HOME/local/bin"

  util.message 'installing node'

  # Add the node path to .bashrc
  util.progress 'updating .bashrc'
  util.append "$bashrc" '# node.js'
  util.append "$bashrc" "export PATH=\"$nodeDir:\$PATH\""
  util.append "$bashrc"

  # Modify the current environment variables
  PATH="$nodeDir:$PATH"

  node.install "$(node.latest)"
  util.assertExecutable 'node'
  util.assertExecutable 'npm'
}
