#!/bin/zsh

#####################################################################
#                              aliases
#####################################################################
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

#####################################################################
#                                nvm
#####################################################################
# If you want the nvm plugin to defer the load of nvm to speed-up the
# start of your zsh session, set this to 1. This will use the `--no-use`
# parameter when loading nvm, and will create a function for
# node, npm, yarn, and the command(s) specified by `NVM_LAZY_CMD`,
# so when you call either of them, nvm wil load with `nvm use default`.
export NVM_LAZY=1

# If autoload is set to 1, the plugin will automatically load a node
# version when it finds a `.nvmrc` file in the current working directory
# indicating which node version to load.
# export NVM_AUTOLOAD=1

#####################################################################
#                             turbogit
#####################################################################
tug completion zsh > /usr/local/etc/bash_completion.d/tug
