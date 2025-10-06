#!/usr/bin/env bash

HISTSIZE=10000
SAVEHIST=10000

export PATH="$HOME/.local/bin":$PATH
export PATH=~/.npm-global/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/usr/bin/python:$PATH
export TERM="xterm-256color"
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
