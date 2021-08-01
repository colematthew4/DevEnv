#!/bin/zsh

# First order of business: configure repo directory if not already set
if [ -z "$REPOS_DIR" ]; then
  export REPOS_DIR=$HOME/Repos/DevEnv
fi

# Install and configure oh-my-zsh
. $REPOS_DIR/apps/oh-my-zsh

# Install brew and apps
. $REPOS_DIR/apps/brew

# Use version managers from brew to install actual platform binaries
. $REPOS_DIR/apps/node

# Invoke scripts to set system preferences and other actions that can't be done by zsh
# osascript $REPOS_DIR/scripts/system.scpt
