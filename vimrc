" Maintained by Sajoku
"
" Always use vim mode, even when starting with vi
set nocompatible

" required!
filetype off

"Vundles
set rtp+=~/dotfiles/vim/bundle/Vundle.vim
call vundle#begin()
" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-liquid'
Plugin 'tpope/vim-endwise'
Plugin 'junegunn/vim-easy-align'
Plugin 'rking/ag.vim'
"Plugin "skwp/greplace.vim"
Plugin 'takac/vim-hardtime'

Plugin 'groenewege/vim-less'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'ervandew/supertab'
Plugin 'bling/vim-airline'

Plugin 'slim-template/vim-slim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'othree/html5.vim'
"Plugin 'fatih/vim-go.git'

Plugin 'scrooloose/syntastic'
Plugin 'sajoku/vim-indent-guides'
Plugin 'Raimondi/delimitMate'

" nelstrom's plugin depends on kana's
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'

"color themes via vundle yeay
Plugin 'chriskempson/base16-vim'
Plugin 'endel/vim-github-colorscheme'
Plugin 'altercation/vim-colors-solarized'

Plugin 'thoughtbot/vim-rspec'

call vundle#end()
filetype plugin indent on

syntax on
syntax enable
filetype plugin indent on
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
set tabstop=2                     " Globul tab width
set shiftwidth=2
set softtabstop=2
set visualbell                    "no sounds
set incsearch                     "find as you type search
set noesckeys
setglobal relativenumber
set relativenumber
set number                        " Show line numbers
set numberwidth=5

" http://items.sjbach.com/319/configuring-vim-right
set viminfo='100,f1               "Save up to 100 marks, enable capital marks
set autoread                      "refresh on changes without confirmation
set ignorecase                    "Ignore case with /  searched
set smartcase                     "Don't ignore case when search has capital
set scrolloff=3                   "Keep more context when csrolling, also use zz

set listchars=tab:▸\ ,extends:>,precedes:< " fancy tabstops and eols symbols

set directory=~/.vim/backup
set backupdir=~/.vim/backup
set makeprg=rake

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

"Map j and k when pressing tab to move, prevents from typing j and k though
inoremap <expr> j pumvisible() ? "\<C-N>" : "j"
inoremap <expr> k pumvisible() ? "\<C-P>" : "k"

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
map <Leader>l :set list!<CR>
map <Leader>n :NERDTreeToggle<CR>
map <Leader>r :NERDTreeFind<CR>
map <Leader>ps ysiw

map <Leader>ea: :EasyAlign \<CR>
map <Leader>ea= :EasyAlign =<CR>
map <leader>ea :EasyAlign

"resource and edit vimrc
nmap <leader>rs :so ~/.vimrc<CR>
nmap <leader>es :e ~/.vimrc<CR>

"indent and move cursor back to previous pos
map <Leader>i mmgg=G`m<CR>
"Paste with correct indentation
map <Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>

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

"Disable Ex mode
map Q <Nop>

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
command! Qall qall

" set 256 colors
colorscheme base16-chalk
set t_Co=256
set background=dark

" filetype mappings
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,config.ru,*.rabl,Capfile}    set ft=ruby
au BufRead,BufNewFile Watchr set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.hjs  set ft=handlebars
au BufRead,BufNewFile *.jst.ejs  set ft=html
au BufRead,BufNewFile *.zsh-theme  set ft=sh
au BufRead,BufNewFile *.strings set ft=yaml
au BufRead,BufNewFile *.md set ft=markdown
au BufRead,BufNewFile *.eye set ft=ruby
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
autocmd FileType markdown setlocal spell

"Remove trailing whitespace when writing a file
autocmd BufWritePre *.{rb,erb,js,css,sass,scss,html,htm,yml,markdown,feature,haml,mustache,cofffee,slim} :%s/\s\+$//e

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
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'


set laststatus=2
runtime! macros/matchit.vim

" RSpec.vim mappings
set shell=sh
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "!rspec --drb -fd {spec}"

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>g :call RunAllSpecs()<CR>

" Rails configuration
autocmd User Rails map <Leader>m :Rmodel
autocmd User Rails map <Leader>c :Rcontroller
autocmd User Rails map <Leader>v :Rview

let @t="ggirequire 'spec_helpero"
map <Leader>a :DelimitMateSwitch<CR>

" Remap to escape
inoremap jk <esc>
let g:hardtime_default_on = 1
let g:hardtime_timeout = 1000
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
