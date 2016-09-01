" http://www.vim.org/scripts/script.php?script_id=2332
call pathogen#infect() 

" company settings
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab

" easier escape
imap ;a <esc>

" https://github.com/altercation/vim-colors-solarized#modify-vimrc
syntax enable
set background=dark
colorscheme solarized

set hlsearch " highlight search results
" higlight foreground is black
" hi Search ctermfg=Black

" indentation
set autoindent
set smartindent
set cindent

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

au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.js.es6 set filetype=javascript
" makeshift puppet highlighting
au BufNewFile,BufRead *.pp set filetype=ruby
au BufNewFile,BufRead *.erb set filetype=eruby

" Makefiles require hard tabs
autocmd FileType make set noexpandtab

" per-project .vimrc
" see http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
set exrc
set secure

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
