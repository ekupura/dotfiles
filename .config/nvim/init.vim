if !&compatible
  set nocompatible
endif

" エンコーディング
set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,cp932
set fileencoding=utf-8
set fileformats=unix,dos

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み＆キャッシュ作成
" プラグインは./config/nvim/dein.tomlに書く
let s:toml_directory = fnamemodify(expand('<sfile>'), ':h') 
if has ('nvim')
    let s:toml_file = s:toml_directory .'/dein.toml'
else
    let s:toml_file = s:toml_directory .'/.dein.toml'
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" font(GUI用)
" CUIの場合は端末に依存する
if has ('unix')
    set guifont=inconsolata:h12
elseif has ('win32' || 'win64')
    set guifont=consolata:h12
    set guifontwide=MS_Gothic:h12
endif 

" Neovim特有の設定(ターミナル周りとか)
if has ('nvim')
    set sh=zsh
    tnoremap <silent> <ESC> <C-\><C-n>
endif

" インデント(共通)
" htmlとかはfiletypeごとに設定する
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set smartindent

" 検索
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" その他設定
set nobackup
set noswapfile
set hidden
set list
set backspace=indent,eol,start
set number
set textwidth=0
set clipboard=unnamed,unnamedplus
set mouse=a
set history=1000

filetype plugin indent on
