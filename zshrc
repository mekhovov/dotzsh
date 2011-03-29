autoload colors; colors;
for config_file (~/.zsh/lib/*.zsh) source $config_file

# Global Aliases
alias -g L='|less'
alias -g G='|grep'
alias -g W='|wc'
alias -g N='&>/dev/null&'

# helpful Aliases 
alias .='pwd'
alias ...='cd ../..'
alias ....='cd ../../..'

alias x=extract
alias ds='dirs -v'
alias :e=vim

# Aptitude
alias ai='sudo aptitude install'
alias au='sudo aptitude update'
alias ad='sudo aptitude dist-upgrade'
alias arm='sudo aptitude remove'
alias as='aptitude search'

# BINDINGS
bindkey "^[[2~" overwrite-mode       ## Inser
bindkey "^[[3~" delete-char          ## Del
bindkey "^[[7~" beginning-of-line    ## Home
bindkey "^[[8~" end-of-line          ## End
bindkey "^[[5~" up-line-or-history   ## PageUp
bindkey "^[[6~" down-line-or-history ## PageDown
bindkey "^[[A" up-line-or-search     ## up arrow for back-history-search
bindkey "^[[B" down-line-or-search   ## down arrow for fwd-history-search
bindkey " " magic-space              ## do history expansion on space

# LS
alias ls='ls --color=auto -FG'
alias ll='ls --color=auto -FGhl'
alias la='ls --color=auto -FGhla'

# GREP
export GREP_COLOR='1;37;41'
export GREP_OPTIONS='--color=auto'

alias ack='ack-grep'

# GIT
alias g='git'
alias gs='git st'

# SVN
alias unsvn='find . -name .svn -print0 | xargs -0 rm -rf'
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add'

# RAILS
function rails_command {
  local cmd=$1
  shift
  if [ -e script/rails ]; then
    rails $cmd "$@"
  else
    script/$cmd "$@"
  fi
}
function ss { rails_command "server" "$@" }
function sc { rails_command "console" "$@" }
function sd { rails_command "dbconsole" "$@" }
function sg { rails_command "generate" "$@" }

alias sp="rspec spec"
alias notes="ack 'TODO|FIXME|XXX|HACK' --ignore-dir=tmp --ignore-dir=log"

# RUBY
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm && hash -d gem="$(rvm gemdir)/gems"
export RUBYLIB="./lib"

# HISTORY
HISTFILE=~/.zsh_hist
HISTSIZE=5000
SAVEHIST=1000

# ZSH
setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_PUSHD
setopt AUTO_PARAM_SLASH
setopt EXTENDED_HISTORY
#setopt HASH_CMDS
#setopt HASH_DIRS
setopt HIST_IGNORE_ALL_DUPS
setopt PUSHD_IGNORE_DUPS
setopt PROMPT_SUBST
setopt RM_STAR_SILENT
unsetopt BEEP
unsetopt BG_NICE
unsetopt NOMATCH

source /etc/zsh_command_not_found

# OPTIONS
cdpath=(~ ~/projects)
fpath=(~/.zsh/functions $fpath)

autoload -U promptinit; promptinit
prompt bolkabolka

export PATH="$HOME/bin:$PATH"
export DIRSTACKSIZE=16
export EDITOR=vim
export PAGER=less
umask 022

# COMPLETION
fpath=(~/.zsh/Completion $fpath)
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion::complete:cd::' tag-order local-directories path-directories
zstyle ':completion:*:(all-|)files' ignored-patterns '*.rbc'
zstyle ':completion:*' hosts $( sed 's/[, ].*$//' $HOME/.ssh/known_hosts )
zstyle ':completion:*:*:(ssh|scp):*:*' hosts `sed 's/^\([^ ,]*\).*$/\1/' ~/.ssh/known_hosts`

autoload -U ~/.zsh/Completion/*(:t)
autoload -U compinit
compinit -u
