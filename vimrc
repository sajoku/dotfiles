set nocompatible                  " Always use vim mode, even when starting with vi

runtime bundle/tpope-vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

filetype plugin on
filetype indent on
syntax on

" set ruby path so ruby.vim can find it fast 
" without this there is an extra 12 seconds of loading!!
if !empty($MY_RUBY_HOME)
  let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/ruby/site_ruby/*'),"\n"),',')
endif

runtime macros/matchit.vim        " Load the matchit plugin.

set backspace=indent,eol,start    " Allow backspacing over everything in insert mode
set autoindent                    " Always set autoindenting on
set history=1000                  " Keep 50 lines in history
set ruler                         " Always show cursor
set showcmd                       " Display incomplete commands
set showmode
set mouse=a                       " Enable mouse
set mousehide                     " Hide mouse when typing
set number                        " Show line numbers
set timeoutlen=500                " Don't lag the leader key + command
set nofoldenable                  " Don't fold by default
set expandtab                     " Use spaces instead of tabs
set tabstop=2                     " Global tab width
set shiftwidth=2
set softtabstop=2
set virtualedit=onemore           "end of line + 1
set visualbell                    "no sounds
set incsearch                     "find as you type search
set listchars=tab:▸\ ,eol:¬       "fancy tabstops and eols symbols
set list listchars=tab:\▸\ ,trail:·


" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden
set viminfo='100,f1               "Save up to 100 marks, enable capital marks
set autoread                      "refresh on changes without confirmation
set ignorecase                    "Ignore case with /  searched
set smartcase                     "Don't ignore case when search has capital
set scrolloff=3                   "Keep more context when csrolling, also use zz
"Scroll faster with ctrl-e and ctrl-y
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>


" -----------------------------
"  Backup and restore
"  ----------------------------
silent !mkdir ~/.vim/backup > /dev/null 2>&1
set undodir=~/.vim/backup
set undofile
" Backup directories (don't polute project directory with .swp files)
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" set rake as default build mechanism for vim"
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
map <C-t> :FuzzyFinderTextMate<CR>
map <C-f> :ruby finder.rescan!<CR>
nmap ,n :NERDTreeToggle<CR>
nmap ,r :NERDTreeFind<CR>
map ,b :%s/></>\r</g<CR>:1<CR>=G " beautify xml"

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
imap <Tab> <C-P>"

" typo fixes
command! Q q
command! W w
command! Wa wa
command! Wq wq
command! Vsp vsp
command! Sp sp
command! Qa qa
command! Vs vs

" tagbar
nmap <F8> :TagbarToggle<CR>

" set 256 colors
set t_Co=256
colorscheme smyck
set background=dark

" filetype mappings
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,config.ru,*.rabl}    set ft=ruby
au BufRead,BufNewFile Watchr set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.hjs  set ft=handlebars
au BufRead,BufNewFile *.zsh-theme  set ft=sh

"Remove trailing whitespace when writing a file
autocmd BufWritePre *.{rb,php,erb,js,css,sass,scss,html,htm,yml,markdown,feature,haml,mustache,cofffee} :%s/\s\+$//e

" load operating system specific settings
let uname = substitute(system("uname"),"\n","","g")
if uname == "Linux" "ubuntu stuff
  :so ~/dotfiles/vimrc.linux
elseif uname == "Darwin" "osx stuff
  :so ~/dotfiles/vimrc.osx
endif
