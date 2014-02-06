" Maintained by Sajoku
"
" Always use vim mode, even when starting with vi
set nocompatible                  

if !empty($MY_RUBY_HOME)
  let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/ruby/site_ruby/*'),"\n"),',')
endif

" required!
filetype off 

"Vundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'kien/ctrlp.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-liquid'
Bundle 'tpope/vim-endwise'
Bundle 'tsaleh/vim-align'
Bundle 'endel/vim-github-colorscheme'
Bundle 'rking/ag.vim'
"languages
Bundle 'othree/html5.vim'
Bundle 'groenewege/vim-less'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'ervandew/supertab'
Bundle 'bling/vim-airline'
"File specific
Bundle 'slim-template/vim-slim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'othree/html5.vim'
"syntax
Bundle 'scrooloose/syntastic'

" nelstrom's plugin depends on kana's
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'

"color themes via vundle yeay
Bundle 'chriskempson/base16-vim'


filetype plugin indent on
syntax on
syntax enable
set encoding=utf-8

set backspace=indent,eol,start    " Allow backspacing over everything in insert mode
set autoindent                    " Always set autoindenting on
set history=50                  " Keep 50 lines in history
set ruler                         " Always show cursor
set showcmd                       " Display incomplete commands
set showmode
set mouse=a                       " Enable mouse
set mousehide                     " Hide mouse when typing
set timeoutlen=500                " Don't lag the leader key + command
set nofoldenable                  " Don't fold by default
set foldlevel=99
set expandtab                     " Use spaces instead of tabs
set tabstop=2                     " Global tab width
set shiftwidth=2
set softtabstop=2
set visualbell                    "no sounds
set incsearch                     "find as you type search

set listchars=tab:▸\ ,extends:>,precedes:< " fancy tabstops and eols symbols

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" http://items.sjbach.com/319/configuring-vim-right
set viminfo='100,f1               "Save up to 100 marks, enable capital marks
set autoread                      "refresh on changes without confirmation
set ignorecase                    "Ignore case with /  searched
set smartcase                     "Don't ignore case when search has capital
set scrolloff=3                   "Keep more context when csrolling, also use zz

"Map j and k when pressing tab to move, prevents from typing j and k though
inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"

setglobal relativenumber
set relativenumber
set number                        " Show line numbers
set numberwidth=5

set backupdir=~/.vim/backup
set directory=~/.vim/backup
set makeprg=rake
" fancy status line
set statusline=%t%(\ [%n%M]%)%(\ %H%R%W%)\ %(%c-%v,\ %l\ of\ %L,\ (%o)\ %P\ 0x%B\ (%b)%)
" Automatic go to last edited line when opening file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
"---------------------------------
"Mapping keys
"---------------------------------
" change mapleader to ,
let mapleader = ","
" Shortcuts
map <Leader>m :RVmodel<CR>
map <Leader>c :RVcontroller<CR>
nmap <leader>l :set list!<CR>
nmap ,n :NERDTreeToggle<CR>
nmap ,r :NERDTreeFind<CR>

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

" easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"remap so i can use vim-suround
xmap s S

" Split settings
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s
set splitbelow   "Split windows below the current window.
" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t
set completeopt=menu,preview

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

"exclude dirs for ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,/build/,/resources/Storyboard.storyboardc/*,*.nib,*.tmp,*.log,releases/*
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.app$\|\.so$\|\.dat$\|.nib$\|.log$'
  \ }

" typo fixes
command! Q q
command! W w
command! Wa wa
command! Wq wq
command! Wqa wqa
command! Vsp vsp
command! Sp sp
command! Qa qa
command! Vs vs

" set 256 colors
colorscheme base16-eighties
set t_Co=256
set background=dark

" filetype mappings
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,config.ru,*.rabl}    set ft=ruby
au BufRead,BufNewFile Watchr set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.hjs  set ft=handlebars
au BufRead,BufNewFile *.jst.ejs  set ft=html
au BufRead,BufNewFile *.zsh-theme  set ft=sh
au BufRead,BufNewFile *.strings set ft=yaml
au BufRead,BufNewFile *.md set ft=markdown

autocmd FileType markdown setlocal spell

"Remove trailing whitespace when writing a file
autocmd BufWritePre *.{rb,php,erb,js,css,sass,scss,html,htm,yml,markdown,feature,haml,mustache,cofffee,slim} :%s/\s\+$//e

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
let g:syntastic_quiet_messages = {'level': 'warnings'}

" autoresize splits when resizing
au VimResized * exe "normal! \<c-w>="
" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv 

let g:airline_powerline_fonts = 1
set laststatus=2
runtime! macros/matchit.vim

hi LineProximity guibg=#FFCB75
hi LineOverflow guibg=#F7767B
let w:m1=matchadd('LineProximity', '\%<81v.\%>75v', -1)
let w:m2=matchadd('LineOverflow', '\%>80v.\+', -1)


" Quick'n'dirty hack to run rails tests
map <Leader>rt :!rake test %<CR>
map <Leader>rr :!ruby %<CR>
