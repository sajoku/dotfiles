" Maintained by Sajoku
" Always use vim mode, even when starting with vi
set nocompatible

" change mapleader to ,
let mapleader = ","

if filereadable(expand("~/dotfiles/vimrc.plugins"))
  source ~/dotfiles/vimrc.plugins
endif

filetype plugin indent on

syntax enable
set encoding=utf-8

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

"set backspace=indent,eol,start    " Allow backspacing over everything in insert mode
set nobackup
set nowritebackup
set noswapfile                    " Stop using .swp files
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


set visualbell                    "no sounds
set incsearch                     "find as you type search
set noesckeys
setglobal relativenumber
set relativenumber
set number                        " Show line numbers
set numberwidth=5
set laststatus=2

" http://items.sjbach.com/319/configuring-vim-right
set viminfo='100,f1               "Save up to 100 marks, enable capital marks
set autoread                      "refresh on changes without confirmation
set ignorecase                    "Ignore case with /  searched
set smartcase                     "Don't ignore case when search has capital
set scrolloff=3                   "Keep more context when csrolling, also use zz

"Softtabs 
set expandtab                     " Use spaces instead of tabs
set tabstop=2                     " Globul tab width
set shiftwidth=2
set softtabstop=2

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set directory=~/.vim/backup
set backupdir=~/.vim/backup
set makeprg=rake

"Allow copy paste in terminal vim
set clipboard=unnamed

"highlight search words
set hlsearch

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
" Shortcuts
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

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"exclude dirs for ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,/build/,/resources/Storyboard.storyboardc/*,*.nib,*.tmp,*.log,releases/*
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\.git$\|\.hg$\|\.svn$\|public\/images\|public\/system\|data\|log\|tmp$',
      \ 'file': '\.app$\|\.so$\|\.dat$\|.nib$\|.log$'
      \ }

" typo fixes
command! Q q
command! Qa qa
command! Qall qall

command! W w
command! Wa wa
command! Wq wq
command! Wqa wqa

command! Vsp vsp
command! Sp sp
command! Vs vs

" set 256 colors
colorscheme base16-ocean
set t_Co=256
set background=light

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
au BufNewFile,BufRead *.hamlc set ft=haml
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
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" autoresize splits when resizing
au VimResized * exe "normal! \<c-w>="
" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

let g:airline_powerline_fonts = 1

runtime! macros/matchit.vim

" RSpec.vim mappings

set shell=sh
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "!spring rspec --drb {spec}"
"let g:rspec_command = "Dispatch spring rspec --drb {spec}"
"let g:rspec_command = "rspec --drb {spec}"

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>g :call RunAllSpecs()<CR>

let @t="ggirequire 'rails_helpero"
map <Leader>a :DelimitMateSwitch<CR>

" Remap to escape
inoremap jk <esc>
let g:hardtime_default_on = 1
let g:hardtime_timeout = 1000
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2
map <Leader>ht :call HardTimeToggle()<CR>

" Open new split panes to right and bottom, which feels more natural
"set splitbelow
"set splitright

let g:ruby_indent_access_modifier_style = "indent"



hi LineProximity ctermfg=white ctermbg=gray guifg=white guibg=#757160 
hi LineOverflow  ctermfg=white ctermbg=red guifg=white guibg=#FF2270
autocmd BufRead,BufNewFile,VimEnter *.rb,*.coffee let w:m1=matchadd('LineProximity', '\%<85v.\%>80v', -1)
autocmd BufRead,BufNewFile,VimEnter *.rb,*.coffee let w:m2=matchadd('LineOverflow', '\%>84v.\+', -1)
" autocmd VimEnter *.rb autocmd WinEnter * let w:created=1
" autocmd VimEnter *.rb let w:created=1
