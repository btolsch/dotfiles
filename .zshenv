SELF_DIR=$(dirname $(realpath $0))
source $SELF_DIR/zshenv_functions.zsh

export CUDA_HOME=/opt/cuda

export LD_LIBRARY_PATH=$(add_paths_before ${LD_LIBRARY_PATH:-:} $CUDA_HOME/lib64)
export PATH=$(add_paths_before ${PATH:-:} $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $CUDA_HOME/bin $HOME/.local/bin $HOME/bin $HOME/code/esp-projects/tools/xtensa-esp32-elf/bin)
export PYTHONPATH=$(add_paths_before ${PYTHONPATH:-:} $HOME/caffe-orig/python)

export LESS='-x 4 -R'
export EDITOR=vim
export TERMINAL=st
export GTEST_COLOR=yes

export FZF_DEFAULT_COMMAND='
  (git ls-tree --name-only -r HEAD ||
   fd --type f --hidden --follow) 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'cat {} 2>/dev/null | head -200'"
export FZF_ALT_C_COMMAND="fd . $HOME -I --type d --hidden --follow"
export FZF_DEFAULT_OPTS="-m --bind ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-f:page-down,ctrl-b:page-up,ctrl-l:toggle-preview,ctrl-h:toggle-preview,up:preview-page-up,down:preview-page-down,ctrl-space:jump"

export IDF_PATH=$HOME/code/esp-idf
