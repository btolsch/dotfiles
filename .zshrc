if [[ "$(tty)" = "/dev/tty1" ]]; then
  startx && exit
fi
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gitliorononomicon"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(archlinux common-aliases git lol nyan pip python rand-quote sudo systemd tmux vi-mode)
#remove lwd from shell spawned by ranger to preserve ranger-given working-dir
#'two levels' because ranger->zsh->tmux->zsh
if ps -o  pid,comm x | grep $PPID | grep -q 'ranger'; then
  touch ~/.ranger_parent
else
  if [[ -a ~/.ranger_parent ]]; then
    rm -f ~/.ranger_parent
  else
    plugins+=(last-working-dir)
  fi
fi
ZSH_TMUX_AUTOSTART=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"
source $HOME/.zshenv

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias glggo="git log --graph --pretty=oneline --abbrev-commit"
alias grep="grep --color=auto --exclude-dir=.git --exclude-dir=.hg"
alias rem="rm -rI"
alias fuck='sudo $(fc -ln -1)'
alias dus="du -xh --max-depth=2 | sort -rh | less"
alias -s cpp=vim
alias -s h=vim
unalias fd

bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" sudo-command-line
bindkey -a "^S" sudo-command-line
bindkey "^?" backward-delete-char
setopt extended_glob

stty -ixon

[[ -f ~/bin/zbell.sh ]] && source ~/bin/zbell.sh

[[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh

fzf-cd-cur-widget() {
  local old="$FZF_ALT_C_COMMAND"
  FZF_ALT_C_COMMAND="fd -I --type d --hidden --follow"
  fzf-cd-widget
  FZF_ALT_C_COMMAND="$old"
}

zle -N fzf-cd-cur-widget
bindkey "\ex" fzf-cd-cur-widget

fzf-cd-git-widget() {
  local old="$FZF_ALT_C_COMMAND"
  FZF_ALT_C_COMMAND="git ls-tree -r -d --name-only HEAD"
  fzf-cd-widget
  FZF_ALT_C_COMMAND="$old"
}

zle -N fzf-cd-git-widget
bindkey "\es" fzf-cd-git-widget

is_in_git_repo() {
  git rev-parse &>/dev/null
}

fco() {
  is_in_git_repo || return
  local tags branches target
  tags=$(git tag | awk '{print "\x1b[32;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD | sed 's/^ *//' | sed 's#remotes/##' |
    sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

fgst() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf -m --ansi -n 2..,.. \
    --preview 'NAME="$(cut -c4- <<< {})" &&
               (git diff --color=always "$NAME" | sed 1,4d; cat "$NAME") | head -200' |
  cut -c4-
}

fgb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort | fzf --ansi \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(cut -c3- <<< {} | cut -d" " -f1) -200' |
  cut -c3- | cut -d" " -f1 | sed '#^remotes/##'
}

fgrep() {
  is_in_git_repo || return
  git grep $@ | fzf | cut -f1 -d:
}

fvigrep() {
  files=$(fgrep $@)
  if [ -n "$files" ]; then
    echo "$files" | xargs vi -c "/$@"
  fi
}

stopwatch() {
  date1=$(date +%s)
  while true; do
    echo -ne "$(date -u --date @$(($(date +%s) - $date1)) +%H:%M:%S)\r"
    sleep 0.1
  done
}
