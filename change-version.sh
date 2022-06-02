#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=/dev/null
source "$DIR/includes/util.sh"
# shellcheck source=/dev/null
source "$DIR/includes/node.sh"

node.install "$1"
exit 0
