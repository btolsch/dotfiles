export PATH=$HOME/.local/bin:$HOME/bin:$PATH:$HOME/code/depot_tools
export LESS='-x 4 -R'
export EDITOR=vim
export CHROME_DEVEL_SANDBOX=/usr/local/sbin/chrome-devel-sandbox
export GYP_DEFINES="buildtype=Official branding=Chrome"
export TERMINAL=st
export GTEST_COLOR=yes
export GYP_CHROMIUM_NO_ACTION=1

export FZF_DEFAULT_COMMAND='
  (git ls-tree --name-only -r HEAD ||
   fd --type f --hidden --follow) 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'cat {} 2>/dev/null | head -200'"
export FZF_ALT_C_COMMAND="
  git rev-parse &>/dev/null && git ls-tree -d -r --name-only HEAD ||
  fd . $HOME --type d --hidden --follow"
export FZF_DEFAULT_OPTS="-m --bind ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up,ctrl-l:toggle-preview,ctrl-h:toggle-preview,up:preview-page-up,down:preview-page-down,ctrl-space:jump"
