" https://github.com/junegunn/vim-plug/wiki/faq/61895a373e6a888f585b51a5c53a0b11b970f812#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" https://github.com/junegunn/vim-plug/tree/5fc9eab788608fb4adcb07a8d79354dcafefaa6a#usage
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/editorconfig/editorconfig-vim'
Plug 'https://github.com/bogado/file-line'
Plug 'https://github.com/rust-lang/rust.vim'
Plug 'https://github.com/leafgarland/typescript-vim'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/ntpeters/vim-better-whitespace'
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/mxw/vim-jsx'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/moll/vim-node'
" Plug 'https://github.com/Valloric/YouCompleteMe' " additional required steps here: https://github.com/Valloric/YouCompleteMe#installation
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/MarcWeber/vim-addon-local-vimrc'
Plug 'https://github.com/sbdchd/neoformat'
Plug 'https://github.com/tpope/vim-rsi'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-unimpaired' " [n and ]n jump to prev/next merge conflict: https://github.com/tpope/vim-unimpaired/blob/9a8be3696bc50064b9d9d146041ec4264e36e341/plugin/unimpaired.vim#L103-L145
Plug 'https://github.com/exu/pgsql.vim'
Plug 'https://github.com/tpope/tpope-vim-abolish'
Plug 'https://github.com/udalov/kotlin-vim'
Plug 'https://github.com/keith/swift.vim'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'https://github.com/vim-ruby/vim-ruby'
Plug 'https://github.com/tpope/vim-rails'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/slim-template/vim-slim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " conqueror of completion"
Plug 'https://github.com/APZelos/blamer.nvim'
call plug#end()

let g:jsx_ext_required = 0

" company settings
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab

" easier escape
imap ;a <esc>
vmap ;a <esc>

" https://github.com/altercation/vim-colors-solarized#modify-vimrc
syntax enable
filetype plugin indent on
set background=dark
" colorscheme solarized

set hlsearch " highlight search results
" higlight foreground is black
" hi Search ctermfg=Black
set incsearch " highlight search results while typing pattern

" indentation
set autoindent
set cindent
set cinkeys-=0#
set indentkeys-=0#

autocmd BufEnter * silent! lcd %:p:h " cd to current file

" vim-better-whitespace seems not to be enabled by default,
" so try turning it off and on again
" https://stackoverflow.com/questions/6821033/vim-how-to-run-a-command-immediately-when-starting-vim/6821698#6821698
autocmd VimEnter * ToggleWhitespace
autocmd VimEnter * ToggleWhitespace

" case-insensitive and extended searching
nmap / /\c\v

" fix scrolling on wrapped lines
nmap j gj
nmap k gk

set ruler " show line/column in status bar
set rulerformat=%l,%c%V\ %o "Add byte offset to status bar https://codeyarns.com/2010/11/28/vim-ruler-and-default-ruler-format/

" https://stackoverflow.com/questions/10488717/how-can-i-permanently-display-the-path-of-the-current-file-in-vim/10488747#10488747
" always show status bar
set laststatus=2
" Add full file path to your existing statusline
set statusline+=%F

au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.js.es6 set filetype=javascript
au BufNewFile,BufRead .env.* set syntax=sh
" makeshift puppet highlighting
au BufNewFile,BufRead *.pp set filetype=ruby
au BufNewFile,BufRead *.erb set filetype=eruby

" Makefiles require hard tabs
autocmd FileType make set noexpandtab

" Enable rust.vim Syntastic checker
" https://github.com/rust-lang/rust.vim/issues/118#issue-185772908
autocmd FileType rust let g:syntastic_rust_checkers = ['rustc']

" Enable eslint_d checker for javascript
" Requires eslint_d to be installed globally: yarn global add eslint_d
autocmd FileType javascript let g:syntastic_javascript_checkers = ['eslint']
autocmd FileType javascript let g:syntastic_javascript_eslint_exec = 'eslint_d'

" Disable Syntastic everywhere but rust/javascript files
let g:syntastic_mode_map = {
		\ "mode": "passive",
		\ "active_filetypes": ["rust", "javascript"],
		\ "passive_filetypes": [] }

" per-project .vimrc
" see http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
" XXX commented out because it's not secure:
" https://github.com/vim/vim/issues/1015
" set exrc
" set secure

" http://amix.dk/blog/post/19548
set undodir=~/.vim/undodir
set undofile

" indent wrapped lines
" set breakindent

" http://stackoverflow.com/a/3534075
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd Filetype gitcommit setlocal expandtab shiftwidth=4

" http://unix.stackexchange.com/a/30757
set tabpagemax=100

" https://stackoverflow.com/questions/4760428/how-can-i-make-vims-j-and-gq-commands-use-one-space-after-a-period/4760477#4760477
set nojoinspaces

" Enable the mouse
" set mouse=a

set autoindent
