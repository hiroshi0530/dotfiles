#!/bin/bash

. ~/.bashrc
. "$HOME/.cargo/env"
. "$HOME/.deno/env"

eval "$(/opt/homebrew/bin/brew shellenv)"
. "$HOME/.local/bin/env"
. "$HOME/.deno/env"
