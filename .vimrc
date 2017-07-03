autocmd! bufwritepost .vimrc source %

filetype off " required by vundle

let g:powerline_pycmd = 'py3'

" badwolfarch airline theme, not in a git repo so can't use Plugin
set rtp+=~/dotfiles/custom-airline-themes

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-obsession'
" Plugin 'jceb/vim-hier'
Plugin 'b4winckler/vim-angry'
Plugin 'tpope/vim-commentary'
"Plugin 'Mizuchi/vim-ranger'
Plugin 'rbgrouleff/bclose.vim'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-repeat'
Plugin 'peterhoeg/vim-qml'

call vundle#end()

nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

set matchpairs+=<:>

set termguicolors
filetype plugin indent on
syntax on
colorscheme BusyBee_modified

let mapleader = ","
" Leader keybindings
"
" /     :nohl
" bd    delete current buffer but don't close window
" bs    bufdo vimgrepadd @pattern@g | cw
" cc    cclose
" cf    clang format
" co    copen
" cw    cw
" d     "_d
" D     "_D
" e     edit %:h
" gd    :Gdiff
" gdp   :Gdiff for some commit
" gs    :Gstatus
" h     tab previous
" j     tab first
" k     tab last
" l     tab next
" m     max height
" c-m   clear, redraw, make
" n     max width
" c-n   redraw
" o     only
" pc    close preview window
" r     edit .
" s     sort lines
" si    echo syntaxId
" so    source .vimrc
" tl    c-p and enter in runner
" v     select recently pasted text
" vc    vimux interrupt runner
" vl    vimux run last command
" vm    vimux run make
" vo    vimux open runner select
" vp    vimux prompt command
" vq    vimux close runner
" vz    vimux zoom runner
" w     open vertical split window
" wb    <c-w>b
" wp    <c-w>p
" ws    delete trailing whitespace

nnoremap <leader>w <c-w>v<c-w>l
nnoremap <leader>v V']
nnoremap <leader>wb <c-w>b
nnoremap <leader>wp <c-w>p
nnoremap <leader>pc :pc<cr>
nnoremap <leader>e :Ranger<cr>
" nnoremap <leader>r :edit .<cr>
nnoremap <leader>le :lopen<cr>
nnoremap <leader>lc :lclose<cr>

nmap <leader>; <Plug>(easymotion-repeat)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)

let g:ranger_map_keys = 0

let g:ycm_always_populate_location_list = 1
let g:ycm_global_ycm_extra_conf = '~/dotfiles/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']
let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'

let g:ctrlp_open_multiple_files = 'i'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_current_file = 1
let g:ctrlp_switch_buffer = 0

let g:airline_theme = 'dark_modified'
let g:airline#extensions#obsession#enabled = 1

set timeoutlen=150 ttimeoutlen=0

set omnifunc=syntaxcomplete#Complete

" TODO: Possibly use the same idea for vimux make (<leader>vm).
silent let git_dir = system("git rev-parse --show-toplevel")
if strlen(git_dir)
  let &makeprg = "make -C " . git_dir
else
  set makeprg=make
endif
nnoremap <leader><c-m> :silent !clear<cr>:redraw!<cr>:make<space>
nnoremap <leader><c-n> :redraw!<cr>

nnoremap <leader>bs :cex []<bar>execute 'bufdo vimgrepadd @@g %'<bar>cw<s-left><s-left><right>

hi YcmErrorLine ctermbg=52 cterm=NONE
hi YcmWarningLine ctermbg=94 cterm=NONE
hi YcmErrorSection ctermbg=52 cterm=NONE
hi YcmWarningSection ctermbg=94 cterm=NONE

hi link cDefine PreProc
hi link cInclude PreProc
hi link cPrecondit PreProc

hi link pythonInclude PreProc

hi! link FoldColumn LineNr

set cursorline
set relativenumber number

autocmd FocusLost,WinLeave,InsertEnter * set norelativenumber number
autocmd FocusGained,WinEnter,InsertLeave * set relativenumber number

set fillchars+=vert:\ " comment

nnoremap <leader>si :call SyntaxItem()<CR>
function! SyntaxItem()
  echo synIDattr(synID(line("."), col("."), 1), "name")
endfunction

nnoremap j gj
nnoremap k gk

set hidden
set confirm
set splitbelow
set splitright

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set cindent
set cino=N-s,g0,(0,W2s,j1,+2s

autocmd FileType text setlocal nocindent autoindent fo=t
autocmd FileType markdown setlocal nocindent autoindent fo=t
autocmd FileType gitcommit setlocal tw=72 nocindent autoindent fo=t
autocmd FileType make setlocal noexpandtab
autocmd FileType vim setlocal fdc=1
autocmd FileType vim setlocal foldlevel=0
autocmd FileType vim setlocal foldmethod=marker
autocmd BufNewFile,BufRead /tmp/mutt* setlocal autoindent nocindent filetype=mail tw=80 digraph
autocmd BufNewFile,BufRead ~/tmp/mutt* setlocal autoindent nocindent filetype=mail tw=80 digraph
autocmd BufNewFile,BufRead *.vs,*.gs,*.fs set filetype=glsl

map <silent> <leader>so :source $MYVIMRC<cr>

nnoremap <silent> <leader>cf :call FormatAll()<CR>
vnoremap <silent> <leader>cf :pyf /usr/share/clang/clang-format.py<CR>
" imap <silent> <C-i> <C-o>:pyf /usr/share/clang/clang-format.py<CR>

function! FormatAll()
  let l:lines="all"
  pyf /usr/share/clang/clang-format.py
endfunction

" Alt typically emulated as <Esc>
nnoremap <silent> <M-h> :bprevious<CR>
nnoremap <silent> <M-l> :bnext<CR>
nnoremap <silent> <M-;> :b#<cr>
nnoremap <silent> <Esc>h :bprevious<CR>
nnoremap <silent> <Esc>l :bnext<CR>
nnoremap <silent> <Esc>; :b#<cr>
nnoremap <silent> <leader>bd :bnext<cr>:bd #<cr>
nnoremap <silent> [q :cprev<cr>
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> <leader>co :copen<cr>
nnoremap <silent> <leader>cc :cclose<cr>
nnoremap <silent> <leader>cw :cw<cr>

nnoremap <silent> <leader>m <C-w>_
nnoremap <silent> <leader>n <C-w>\|

nnoremap <silent> <leader>h :tabprevious<CR>
nnoremap <silent> <leader>l :tabnext<CR>
nnoremap <silent> <M-<> :tabm -1<CR>
nnoremap <silent> <M->> :tabm +1<CR>
nnoremap <C-M-n> :tab split<cr>
nnoremap <silent> <Esc>< :tabm -1<CR>
nnoremap <silent> <Esc>> :tabm +1<CR>
nnoremap <Esc><C-n> <C-w>s<C-w>T

" Insert home key motion with Alt
inoremap <M-h> <C-o>h
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
inoremap <M-l> <C-o>l

noremap <leader>d "_d
noremap <leader>D "_D

" Faster scrolling with cursor in the middle
" nnoremap <C-x> LztM
" nnoremap <C-c> HzbM

nnoremap <M-j> 5j
nnoremap <M-k> 5k
noremap <C-M-e> 5<C-e>
noremap <C-M-y> 5<C-y>

inoremap <M-o> <C-o>o
inoremap <M-O> <C-o>O
inoremap <M-a> <C-o>a
inoremap <M-A> <C-o>A
inoremap <M-p> <C-o>p
inoremap <M-P> <C-o>P

nnoremap <silent> ]d :YcmCompleter GoTo<cr>
nnoremap <silent> ]p :YcmCompleter GetParent<cr>
nnoremap <silent> ]t :YcmCompleter GetType<cr>
nnoremap <silent> [d :YcmCompleter GoToImprecise<cr>
nnoremap <silent> [D :YcmCompleter GoToDeclaration<cr>

nmap <M-1> <Plug>AirlineSelectTab1
nmap <M-2> <Plug>AirlineSelectTab2
nmap <M-3> <Plug>AirlineSelectTab3
nmap <M-4> <Plug>AirlineSelectTab4
nmap <M-5> <Plug>AirlineSelectTab5
nmap <M-6> <Plug>AirlineSelectTab6
nmap <M-7> <Plug>AirlineSelectTab7
nmap <M-8> <Plug>AirlineSelectTab8
nmap <M-9> <Plug>AirlineSelectTab9

nnoremap <C-n> :CtrlPBuffer<cr>
nnoremap <C-c> :CtrlPCurWD<cr>

nnoremap <silent> <leader>gs :Gstatus<cr><C-w>P
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <leader>gdp :Gdiff<space>

" map <C-k> <C-W>k
" map <C-j> <C-W>j
noremap <A-n> <C-w><
noremap <A-m> <C-w>>
noremap <Esc>n <C-w><
noremap <Esc>m <C-w>>
noremap + <C-W>+
noremap - <C-W>-
noremap <A-+> 5<C-W>+
noremap <A--> 5<C-W>-
noremap = <C-W>=
noremap <C-w>; <C-w>p

nmap <leader>o :on<cr>

" set foldmethod=indent
set foldmethod=syntax
set foldnestmax=2
set foldlevel=20
nnoremap <space> za

" fix backspace
set bs=indent,eol,start

" remove trailing space
nnoremap <leader>ws :%s/\s\+$//g<CR>

" Visual mode sort
vnoremap <leader>s :sort<CR>

" Visual mode search
vnoremap // y/<C-r>"<CR>

" Better visual mode block indentation
vnoremap > >gv
vnoremap < <gv

" Visual copy
vnoremap <C-c> "+y

" Normal paste
nnoremap <Esc><C-v> "+p

set number
set tw=80
set fo-=t
set fo+=c
set colorcolumn=+1,+41

set hlsearch
set incsearch
set ignorecase
set smartcase
noremap <silent> <leader>/ :nohl<CR>

" Line wrapping
vmap Q gq
nmap Q gqap

set nobackup
set nowritebackup
set noswapfile

" Vimux
noremap <leader>vl :VimuxRunLastCommand<CR>
noremap <leader>vq :VimuxCloseRunner<CR>
noremap <leader>vc :VimuxInterruptRunner<CR>
noremap <leader>vm :VimuxRunCommand("make")<CR>
noremap <leader>vp :VimuxPromptCommand<CR>
noremap <leader>vz :VimuxZoomRunner<CR>
noremap <leader>vo :let g:VimuxRunnerIndex =<space>
noremap <leader>tl :call VimuxSendKeys('c-p')<cr>:call VimuxSendKeys('enter')<cr>

" Bufferline and Airline
" https://github.com/bling/vim-bufferline.git
" https://github.com/bling/vim-airline.git
set laststatus=2
set noshowmode
let g:bufferline_echo = 0
let g:bufferline_active_buffer_left = '['
let g:bufferline_active_buffer_right = ']'
let g:bufferline_rotate = 1
let g:bufferline_fixed_index = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline_theme="badwolfarch"
let g:airline_detect_modified = 1

let g:airline_powerline_fonts = 1
" Powerline
" yaourt -S python-powerline-git
" let $PYTHONPATH='/usr/lib/python3.4/site-packages'
" set guifont=Inconsolata\ for\ Powerline:h15
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup
" let g:Powerline_symbols = 'fancy'

" CtrlP
" git clone https://github.com/ctrlpvim/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*.o

" python-mode
" git clone https://github.com/klen/python-mode
" map <Leader>g :call RopeGotoDefinition()<CR>
" let ropevim_enable_shortcuts = 1
" let g:pymode_rope_goto_def_newwin = "vnew"
" let g:pymode_rope_extended_complete = 1
" let g:pymode_breakpoint = 0
" let g:pymode_syntax = 1
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_funcs = 0
" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" python folding
" set nofoldenable

" If you are using a console version of Vim, or dealing
" with a file that changes externally (e.g. a web server log)
" then Vim does not always check to see if the file has been changed.
" The GUI version of Vim will check more often (for example on Focus change),
" and prompt you if you want to reload the file.
"
" There can be cases where you can be working away, and Vim does not
" realize the file has changed. This command will force Vim to check
" more often.
"
" Calling this command sets up autocommands that check to see if the
" current buffer has been modified outside of vim (using checktime)
" and, if it has, reload it for you.
"
" This check is done whenever any of the following events are triggered:
" * BufEnter
" * CursorMoved
" * CursorMovedI
" * CursorHold
" * CursorHoldI
"
" In other words, this check occurs whenever you enter a buffer, move the cursor,
" or just wait without doing anything for 'updatetime' milliseconds.
"
" Normally it will ask you if you want to load the file, even if you haven't made
" any changes in vim. This can get annoying, however, if you frequently need to reload
" the file, so if you would rather have it to reload the buffer *without*
" prompting you, add a bang (!) after the command (WatchForChanges!).
" This will set the autoread option for that buffer in addition to setting up the
" autocommands.
"
" If you want to turn *off* watching for the buffer, just call the command again while
" in the same buffer. Each time you call the command it will toggle between on and off.
"
" WatchForChanges sets autocommands that are triggered while in *any* buffer.
" If you want vim to only check for changes to that buffer while editing the buffer
" that is being watched, use WatchForChangesWhileInThisBuffer instead.
"
command! -bang WatchForChanges                  :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0})
command! -bang WatchForChangesWhileInThisBuffer :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0, 'while_in_this_buffer_only': 1})
command! -bang WatchForChangesAllFile           :call WatchForChanges('*', {'toggle': 1, 'autoread': <bang>0})
" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
"     Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
"   * autoread: If set to 1, causes autoread option to be turned on for the buffer in
"     addition to setting up the autocommands.
"   * toggle: If set to 1, causes this behavior to toggle between on and off.
"     Mostly useful for mappings and commands. In scripts, you probably want to
"     explicitly enable or disable it.
"   * disable: If set to 1, turns off this behavior (removes the autocommand group).
"   * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
"     buffer you are editing. (Only the specified buffer will be checked for changes,
"     though, still.) If set to 1, the events will only be triggered while
"     editing the specified buffer.
"   * more_events: If set to 1 (the default), creates autocommands for the events
"     listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
"     (Presumably, having too much going on for those events could slow things down,
"     since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
  " Figure out which options are in effect
  if a:bufname == '*'
    let id = 'WatchForChanges'.'AnyBuffer'
    " If you try to do checktime *, you'll get E93: More than one match for * is given
    let bufspec = ''
  else
    if bufnr(a:bufname) == -1
      echoerr "Buffer " . a:bufname . " doesn't exist"
      return
    end
    let id = 'WatchForChanges'.bufnr(a:bufname)
    let bufspec = a:bufname
  end
  if len(a:000) == 0
    let options = {}
  else
    if type(a:1) == type({})
      let options = a:1
    else
      echoerr "Argument must be a Dict"
    end
  end
  let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
  let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
  let disable     = has_key(options, 'disable')     ? options['disable']     : 0
  let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
  let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0
  if while_in_this_buffer_only
    let event_bufspec = a:bufname
  else
    let event_bufspec = '*'
  end
  let reg_saved = @"
  "let autoread_saved = &autoread
  let msg = "\n"
  " Check to see if the autocommand already exists
  redir @"
    silent! exec 'au '.id
  redir END
  let l:defined = (@" !~ 'E216: No such group or event:')
  " If not yet defined...
  if !l:defined
    if l:autoread
      let msg = msg . 'Autoread enabled - '
      if a:bufname == '*'
        set autoread
      else
        setlocal autoread
      end
    end
    silent! exec 'augroup '.id
      if a:bufname != '*'
        "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
        "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
        exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
      end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec
      " The following events might slow things down so we provide a way to disable them...
      " vim docs warn:
      "   Careful: Don't do anything that the user does
      "   not expect or that is slow.
      if more_events
        exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
        exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
      end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
  end
  " If they want to disable it, or it is defined and they want to toggle it,
  if l:disable || (l:toggle && l:defined)
    if l:autoread
      let msg = msg . 'Autoread disabled - '
      if a:bufname == '*'
        set noautoread
      else
        setlocal noautoread
      end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
  elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
  end
  " echo msg
  let @"=reg_saved
endfunction

let autoreadargs={'autoread':1, 'more_events':0}
execute WatchForChanges("*", autoreadargs)
