#!/bin/bash

util.fail() {
  local message="$1"
  echo "ERROR: $message" && exit 1
}

util.message() {
  local message="$1"
  echo "- $message"
}

util.progress() {
  local message="$1"
  printf "\t%s\n" "$message"
}

util.wget() {
  local url="$1"
  local filename="$2"

  if [ -z "$filename" ]; then
    wget -q --no-check-certificate "$url"
  else
    wget -q --no-check-certificate "$url" -O "$filename"
  fi
}

util.append() {
  local path="$1"
  local text="$2"
  local root="$3"

  if [ -z "$root" ]; then
    printf "\n$text" >> "$path"
  else
    printf "\n$text" | sudo tee -a "$path" >& /dev/null
  fi
}

util.assertExecutable() {
  local filename="$1"
  hash "$filename" >& /dev/null || util.fail "$filename not installed"
}
