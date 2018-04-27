autocmd! bufwritepost .vimrc source %

filetype off " required by vundle

let g:powerline_pycmd = 'py3'

" badwolfarch airline theme, not in a git repo so can't use Plugin
set rtp+=~/dotfiles/custom-airline-themes

call plug#begin('~/.vim/plugged')

Plug 'djoshea/vim-autoread'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'b4winckler/vim-angry'
Plug 'tomtom/tcomment_vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'peterhoeg/vim-qml'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'Shougo/denite.nvim'

call plug#end()

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

nnoremap <leader>s <c-w>v<c-w>l
nnoremap <leader>v V']
nnoremap <leader>wb <c-w>b
nnoremap <leader>wp <c-w>p
nnoremap <leader>pc :pc<cr>
nnoremap <leader>e :Ranger<cr>
nnoremap <leader>le :lopen<cr>
nnoremap <leader>lc :lclose<cr>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_references()<cr>
nnoremap <silent> <leader>qb :call LanguageClient#cquery_base()<cr>
nnoremap <silent> <leader>qd :call LanguageClient#cquery_derived()<cr>
nnoremap <silent> <leader>qv :call LanguageClient#cquery_vars()<cr>
nnoremap <silent> <leader>qc :call LanguageClient#cquery_callers()<cr>
inoremap <silent> <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent> <expr><S-tab> pumvisible() ? "\<c-p>" : "\<S-tab>"

let g:LanguageClient_serverCommands = { 'cpp': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory": "/usr/local/google/home/btolsch/.cache/cquery"}'] }
let g:LanguageClient_loadSettings = 1
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('camel_case', 'v:true')
call deoplete#custom#option('ignore_case', 'v:true')
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
call denite#custom#option('_', 'highlight_matched_char', 'Number')
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
  \ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <space>p :DeniteBufferDir file_rec<cr>
nnoremap <space>n :Denite buffer<cr>
nnoremap <space>s :DeniteProjectDir file_rec/git<cr>

" incsearch.vim x fuzzy x vim-easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

nmap <leader>;         <Plug>(easymotion-repeat)
map  <leader><leader>j <Plug>(easymotion-sol-bd-jk)
map  <leader>j         <Plug>(easymotion-bd-jk)
map          /         <Plug>(easymotion-sn)
omap         /         <Plug>(easymotion-tn)
map  <leader>f         <Plug>(easymotion-bd-f)
nmap <leader>f         <Plug>(easymotion-overwin-f)
map  <leader>t         <Plug>(easymotion-bd-t)
map          f         <Plug>(easymotion-bd-fl)
map          t         <Plug>(easymotion-bd-tl)
map  <leader>h         <Plug>(easymotion-lineanywhere)
map  <leader>l         <Plug>(easymotion-lineanywhere)
map  <leader>w         <Plug>(easymotion-bd-w)
nmap <leader>w         <Plug>(easymotion-overwin-w)

let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_startofline = 0

let g:ranger_map_keys = 0

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:airline_theme = 'dark_modified'
let g:airline#extensions#obsession#enabled = 1

set previewheight=25
set timeoutlen=150 ttimeoutlen=0

set omnifunc=syntaxcomplete#Complete

nnoremap <leader>bs :cex []<bar>execute 'bufdo vimgrepadd @@g %'<bar>cw<s-left><s-left><right>

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
autocmd BufNewFile,BufRead /tmp/cl_description* setlocal filetype=gitcommit
autocmd BufNewFile,BufRead *.vs,*.gs,*.fs set filetype=glsl

map <silent> <leader>so :source $MYVIMRC<cr>

nnoremap <silent> <leader>cf :call FormatAll()<CR>
vnoremap <silent> <leader>cf :pyf /usr/lib/clang-format/clang-format.py<CR>
" imap <silent> <C-i> <C-o>:pyf /usr/share/clang/clang-format.py<CR>

function! FormatAll()
  let l:lines="all"
  pyf /usr/lib/clang-format/clang-format.py
endfunction

" Alt sometimes emulated as <Esc>
nnoremap <silent> <M-h> :bprevious<CR>
nnoremap <silent> <M-l> :bnext<CR>
nnoremap <silent> <M-j> :tabprevious<CR>
nnoremap <silent> <M-k> :tabnext<CR>
nnoremap <silent> <M-;> :b#<cr>
nnoremap <silent> [q :cprev<cr>
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> <leader>co :copen<cr>
nnoremap <silent> <leader>cc :cclose<cr>
nnoremap <silent> <leader>cw :cw<cr>

nnoremap <silent> <leader>m <C-w>_
nnoremap <silent> <leader>n <C-w>\|

nnoremap <silent> <M-<> :tabm -1<CR>
nnoremap <silent> <M->> :tabm +1<CR>
nnoremap <C-M-n> :tab split<cr>

" Insert home key motion with Alt
inoremap <M-h> <C-o>h
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
inoremap <M-l> <C-o>l

noremap <leader>c "_c
noremap <leader>C "_C
noremap <leader>d "_d
noremap <leader>D "_D

" Faster scrolling with cursor in the middle
" nnoremap <C-x> LztM
" nnoremap <C-c> HzbM

noremap <C-M-e> 5<C-e>
noremap <C-M-y> 5<C-y>

inoremap <M-o> <C-o>o
inoremap <M-O> <C-o>O
inoremap <M-a> <C-o>a
inoremap <M-A> <C-o>A
inoremap <M-p> <C-o>p
inoremap <M-P> <C-o>P

nnoremap <silent> [d :call LanguageClient#textDocument_definition()<cr>

nmap <M-1> <Plug>AirlineSelectTab1
nmap <M-2> <Plug>AirlineSelectTab2
nmap <M-3> <Plug>AirlineSelectTab3
nmap <M-4> <Plug>AirlineSelectTab4
nmap <M-5> <Plug>AirlineSelectTab5
nmap <M-6> <Plug>AirlineSelectTab6
nmap <M-7> <Plug>AirlineSelectTab7
nmap <M-8> <Plug>AirlineSelectTab8
nmap <M-9> <Plug>AirlineSelectTab9

nnoremap <silent> <leader>gs :Gstatus<cr><C-w>P
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <leader>gdp :Gdiff<space>

" nnoremap <expr> [j &diff ? ']c' : '<C-w>j'
" nnoremap <expr> [k &diff ? '[c' : '<C-w>k'

function! MoveFoldStartDown()
  let l:line_nr = line(".")
  let l:fold_start = foldclosed(l:line_nr)
  if l:fold_start == -1
    return
  endif
  let l:fold_end = foldclosedend(l:line_nr)
  set foldmethod=manual

  let l:new_start = l:fold_start + 5
  execute "normal zd"
  execute ":".l:new_start.",".l:fold_end."fold"
  execute "normal 5j"
endfunction

function! MoveFoldEndUp()
  let l:line_nr = line(".")
  let l:fold_start = foldclosed(l:line_nr)
  if l:fold_start == -1
    return
  endif
  let l:fold_end = foldclosedend(l:line_nr)
  set foldmethod=manual

  let l:new_end = l:fold_end - 5
  execute "normal zd"
  execute ":".l:fold_start.",".l:new_end."fold"
endfunction

nnoremap <leader>- :call MoveFoldEndUp()<cr>
nnoremap <leader>= :call MoveFoldStartDown()<cr>

" map <C-k> <C-W>k
" map <C-j> <C-W>j
noremap <A-n> <C-w><
noremap <A-m> <C-w>>
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

" Better visual mode block indentation
vnoremap > >gv
vnoremap < <gv

" Visual copy
vnoremap <C-c> "+y

" Normal paste
nnoremap <C-M-v> "+p

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
