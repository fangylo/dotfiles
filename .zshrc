#!/usr/bin/env bash
if [[ ! -d $HOME/.oh-my-zsh ]]; then
  echo "oh-my-zsh is not installed"
  echo "Downloading and installing..."
  echo "Cloning oh-my-zsh..."
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=/home/$(whoami)/.oh-my-zsh

plugins=(
  colored-man-pages
  git
  ssh-agent
  zsh-autosuggestions
  zsh-syntax-highlighting
)

fpath=( "${HOME}/.zfunctions" $fpath )

source "${ZSH}/oh-my-zsh.sh"
source /etc/profile

# Solving MAC OS problem b/c of brew installed coreutils after installing oh-my-zsh
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH" 

# source <( cat ~/.dotfiles/bash-functions/* )
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ ( -f /usr/bin/direnv ) ]] && eval "$(direnv hook zsh)"

mkdir -p ~/.zfunctions

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search


if [[ ! -d $HOME/.antigen ]]; then
  echo "antigen is not installed!"
  echo "Downloading and installing..."
  curl -L git.io/antigen > $HOME/.zfunctions/antigen.zsh
fi

source $HOME/.zfunctions/antigen.zsh
# [[ ! -d $HOME/.antigen/bundles/mafredri/zsh-async ]] && antigen bundle mafredri/zsh-async
# [[ ! -d $HOME/.antigen/bundles/sindresorhus/pure ]] && antigen bundle sindresorhus/pure
# antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply


# https://github.com/getantibody/antibody
# antibody bundle mafredri/zsh-async
# antibody bundle sindresorhus/pure

# https://github.com/zplug/zplug
# zplug mafredri/zsh-async, from:github
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# zplugin ice pick"async.zsh" src"pure.zsh"
# zplugin light sindresorhus/pure

# USER CONFIGURATION ##########################################################

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
  export VISUAL='subl3'
fi

# If fzf is installed use those key-bindings and completions
if [[ -d /usr/share/fzf/ ]]; then
  # source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities aur github fangyinlo.pem

# ALIASES #####################################################################

alias zshconfig="${EDITOR} ~/.zshrc"
alias ohmyzsh="${EDITOR} ~/.oh-my-zsh"

alias cd..='cd ..'
alias cp='cp -i'
alias d='ls'
alias df='df -h -x supermount'
alias du='du -h'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias grep='grep --color'

alias ls='ls -lhF --color=auto'
alias l='ls -lhF --color=auto '
alias la='ls -lhFa --color=auto'
alias lt='ls -lhFt --color=auto'
alias ld='ls -lhFd */ --color=auto'
alias lta='ls -lhFta --color=auto'
alias ltd='ls -lhFtd --color=auto'

alias md='mkdir'
alias mv='mv -i'
alias p='cd -'
alias rd='rmdir'
alias rm='rm -i'

alias less='less -SF -# 15'

alias .=source

alias igv='igv > /dev/null 2>&1 &'
alias xclip='xclip -selection c'

alias cls='printf "\033c"'

# BINDKEYS ####################################################################

# case "${TERM}" in
#   cons25*|linux) # plain BSD/Linux console
#     bindkey '\e[H'    beginning-of-line   # home 
#     bindkey '\e[F'    end-of-line         # end  
#     bindkey '\e[5~'   delete-char         # delete
#     bindkey '[D'      emacs-backward-word # esc left
#     bindkey '[C'      emacs-forward-word  # esc right
#     ;;
#   *rxvt*) # rxvt derivatives
#     bindkey '\e[3~'   delete-char         # delete
#     bindkey '\eOc'    forward-word        # ctrl right
#     bindkey '\eOd'    backward-word       # ctrl left
#     # workaround for screen + urxvt
#     bindkey '\e[7~'   beginning-of-line   # home
#     bindkey '\e[8~'   end-of-line         # end
#     bindkey '^[[1~'   beginning-of-line   # home
#     bindkey '^[[4~'   end-of-line         # end
#     ;;
#   *xterm*) # xterm derivatives
#     bindkey '\e[H'    beginning-of-line   # home
#     bindkey '\e[F'    end-of-line         # end
#     bindkey '\e[3~'   delete-char         # delete
#     bindkey '\e[1;5C' forward-word        # ctrl right
#     bindkey '\e[1;5D' backward-word       # ctrl left
#     # workaround for screen + xterm
#     bindkey '\e[1~'   beginning-of-line   # home
#     bindkey '\e[4~'   end-of-line         # end
#     ;;
#   screen)
#     bindkey '^[[1~'   beginning-of-line   # home
#     bindkey '^[[4~'   end-of-line         # end
#     bindkey '\e[3~'   delete-char         # delete
#     bindkey '\eOc'    forward-word        # ctrl right
#     bindkey '\eOd'    backward-word       # ctrl left
#     bindkey '^[[1;5C' forward-word        # ctrl right
#     bindkey '^[[1;5D' backward-word       # ctrl left
#     ;;
# esac

# Use [Tab] and [Shift]+[Tab] to cycle through all the possible completions:
bindkey '\t'  menu-complete
bindkey '\e[Z' menu-complete-backward

# HISTORY #####################################################################

HISTCONTROL=ignoredups
export HISTFILESIZE=20000
export HISTSIZE=100000
export HISTIGNORE="&:ls:[bf]g:exit"

# PROMPT ######################################################################
# ZSH_THEME=""
# autoload -U promptinit; promptinit
# prompt pure

# Set git hub personal access token:

ZSH_THEME="robbyrussell"

# added by Anaconda3 installer
export PATH="$HOME/bin:/home/fyl/anaconda3/bin:$PATH"

# Install Pure prompt
# fpath+=('/usr/local/lib/node_modules/pure-prompt/functions')


# [[ ( -f ${HOME}/bin/mutagen ) ]] && mutagen daemon start # Mutagen (https://mutagen.io/)

