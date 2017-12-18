" Maintained by Sajoku
" Always use vim mode, even when starting with vi
set nocompatible

" change mapleader to ,
let mapleader = ","

if filereadable(expand("~/dotfiles/vimrc.packages"))
  source ~/dotfiles/vimrc.packages
endif

" minpac commands:
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

"Add ale to the runtime path so it can execute
filetype off
let &runtimepath.=',~/.vim/bundle/ale'

filetype plugin indent on

syntax enable
syntax on
set encoding=utf-8
set t_Co=256

"Tru color support
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


set background=dark
silent! colorscheme Tomorrow-Night

" ==========================================================================================================
"  OPTIONS  {{{~
" ==========================================================================================================

set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup
set nowritebackup
set noswapfile                 " Stop using .swp files
set autoindent                 " Always set autoindenting on
set history=100                " Keep x lines in history
set ruler                      " Always show cursor
set showcmd                    " Display incomplete commands
set showmode
set mouse=a                    " Enable mouse
set mousehide                  " Hide mouse when typing
set timeoutlen=500             " Don't lag the leader key + command
set showmatch
set nofoldenable               " Don't fold by default
set foldmethod=indent
set foldlevel=99
set visualbell                 " no sounds
                               " syntax sync minlines=256
set ttyfast
                               " disabling syntax highlighting after 128 columns and/or minlines set to 256
set synmaxcol=200
syntax sync minlines=256
                               " Search related settings
set incsearch                  " find as you type search
set hlsearch                   " Highlight all search matches
nmap <leader>h :nohlsearch<cr>
set ignorecase                 " Ignore case with / searched
set smartcase                  " Don't ignore case when search has capital
set noesckeys
setglobal relativenumber
set relativenumber
set number                     " Show line numbers
set numberwidth=2
set laststatus=2
set autoread                   " Automatically read files changed on disk by other programs

                               " http://items.sjbach.com/319/configuring-vim-right
set viminfo='100,f1            " Save up to 100 marks, enable capital marks
set scrolloff=3                " Keep more context when csrolling, also use zz

                               " Softtabs
set tabstop=2                  " Global tab width
set shiftwidth=2
set shiftround
set expandtab                  " Use spaces instead of tab
set softtabstop=2

set splitbelow                 " Split windows below the current window.
                               " Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t,i
set completeopt=menu,preview
set fileformat=unix

"Prepend linebreaks with @ symbol
set showbreak="@"

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

set directory=~/.vim/backup
set backupdir=~/.vim/backup
"Set rake as default make program. Uncomment if I do alot of Rails
"set makeprg=rake

"Allow copy paste in terminal vim
set clipboard=unnamed

" ==========================================================================================================
"  }}}
" ==========================================================================================================

" Automatic go to last edited line when opening file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

"--------------------
" Autoformat code when saving files
" Uses neoformat
"--------------------

let g:neoformat_try_formatprg = 1


augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

let g:neoformat_javascript_prettier = {
  \ 'exe': 'prettier',
  \ 'args': ['--stdin', '--single-quote', '--print-width 120', '--no-bracket-spacing'],
  \ 'stdin': 1,
  \ }

"let g:neoformat_elixir_exfmt = {
"  \ 'exe': 'mix',
"  \ 'args': ['exfmt', '--stdin'],
"  \ 'stdin': 1
"  \ }
"
"let g:neoformat_enabled_elixir = ['exfmt']

let g:neoformat_htmldjango_tidyhtml5 = {
        \ 'exe': 'tidy',
        \ 'args': ['-quiet',
        \          '--indent auto',
        \          '--indent-spaces ' . shiftwidth(),
        \          '--vertical-space yes',
        \          '--tidy-mark no',
        \          '-wrap ' . &textwidth
        \         ]
        \ }
let g:neoformat_enabled_htmldjango = ['htmlbeautify', 'tidy', 'prettydiff', 'tidyhtml5']

"--------------------
" End of autoformat
"--------------------


let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"---------------------------------
"Mapping keys
"---------------------------------
" Shortcuts
map <Leader>n :NERDTreeToggle<CR>

map <Leader>ea: :EasyAlign \<CR>
map <Leader>ea = :EasyAlign =<CR>
map <leader>ea :EasyAlign

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

"remap so i can use vim-suround
xmap s S

map <Leader>a :DelimitMateSwitch<CR>
" Remap to escape
"inoremap <esc> <nop>
inoremap jj <esc>

" insert blank lines without going into insert mode
nmap go o<esc>

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


"---------------------------------
"Typo fixes
"---------------------------------
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

"---------------------------------
"filetype mappings
"---------------------------------
au BufRead,BufNewFile {Gemfile,Rakefile,Guardfile,Vagrantfile,Thorfile,config.ru,*.rabl,Capfile}    set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.strings set ft=yaml
au BufRead,BufNewFile *.md set ft=markdown
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
au BufNewFile,BufRead *.html.eex set ft=html
au BufNewFile,BufRead *.exs set ft=elixir

autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

"Remove trailing whitespace when writing a file
autocmd BufWritePre *.{rb,erb,js,css,sass,scss,html,htm,yml,markdown,feature,haml,mustache,cofffee,slim,eex} :%s/\s\+$//e

"Alert tabstops for python. Python uses 4 spaces instead of 2 which I'm used
"to in Ruby land
au BufNewFile,BufRead *.py
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal shiftwidth=4 |
    \ setlocal textwidth=120 |
    \ setlocal expandtab |
    \ setlocal autoindent |
    \ setlocal fileformat=unix

let python_highlight_all = 1

"You complete me plugin
let g:ycm_autoclose_preview_window_after_completion=1

let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-t>"
let g:UltiSnipsJumpBackwardTrigger="<c-r>"

"Airline and extension settings
set noshowmode "Do not show the regular mode ( --- INSERT --) because airline already does this"
let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = 'E:'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

let g:airline#extensions#whitespace#checks = ['indent', 'trailing', 'long', 'mixed-indent-file']

"Ale syntax checker settings
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '⚠ '
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_set_highlights = 1
let g:ale_linters = {
\   'javascript': ['jshint', 'eslint'],
\}

let g:ale_fixers = {
\ 'javacsript': ['prettier', 'eslint'],
 \}
"let g:ale_javascript_prettier_use_global = 1


"let g:ale_javascript_eslint_executable = '/usr/local/Cellar/node/8.1.2/bin/eslint'

" Set the correct flake8 executable and arguments to have typechecking
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_args = '-m flake8'

let g:ale_lint_on_text_changed = 1
let g:ale_fix_on_save = 1

highlight ALEErrorSign guibg=NONE guifg=red ctermbg=NONE ctermfg=red
highlight ALEError cterm=underline guibg=NONE guifg=red ctermbg=NONE ctermfg=red
highlight ALEWarning cterm=underline guibg=NONE guifg=red ctermbg=NONE ctermfg=red

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

"nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" autoresize splits when resizing
au VimResized * exe "normal! \<c-w>="

runtime! macros/matchit.vim

"let g:rspec_runner = "os_x_iterm"
"let g:rspec_command = "VtrSendCommandToRunner! rspec {spec}"
"map <Leader>t :call RunCurrentSpecFile()<CR>
"map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"nnoremap <leader>va :VtrAttachToPane<cr>

" These are coming from jank-m/vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>


if filereadable(expand("~/dotfiles/vimrc.test_runners"))
  source ~/dotfiles/vimrc.test_runners
endif
let g:test#strategy = 'vtr'


"Python support for vim tmux runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

"SEARCHING --------------------
set rtp+=/usr/local/opt/fzf
" shortcut for searching through whole folder
nmap g/ :Ag<space>
nmap <c-p> :cclose<CR>:FZF<CR>
"let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --glob"!__init__.py" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)


command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

"if executable('rg')
"  set grepprg=rg\ --color=never
"  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
"  let g:ctrlp_use_caching = 0
"  set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,/build/,*.nib,*.tmp,*.log,releases/*,*.pyc
"  " Sane Ignore For ctrlp
"  let g:ctrlp_custom_ignore = {
"        \ 'dir':  '\.git$\|\.hg$\|\.svn$\|public\/images\|public\/system\|data\|log\|tmp$|*.Storyboardc|node_modules',
"        \ 'file': '\.app$\|\.so$\|\.dat$\|.nib$\|.log$|\.pyc$'
"        \ }
"endif
"
"
" FZF
" -----------------
" This prefixes all FZF-provided commands with 'Fzf' so I can easily find cool
" FZF commands and not have to remember 'Colors' and 'History/' etc.
let g:fzf_command_prefix = 'Fzf'

nnoremap <ctrl>p :FZF<CR>
nnoremap <leader>p :FZF<CR>
nnoremap <leader>b :FzfBuffers<CR>

"Introduce ripgrep
"let g:rg_command = '
"  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
"  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
"  \ -g "!*.{min.js,swp,o,zip,pyc}" 
"  \ -g "!{__init__.py}" 
"  \ -g "!{.git,node_modules,vendor,__pycache__}/*" '


"Zoom and resize stuff
"Resize splits with shift-(h,j,k,l)
nnoremap <S-h> :exe "vertical resize +10"<CR>
nnoremap <S-l> :exe "vertical resize -10"<CR>
nnoremap <S-k> :exe "resize +10"<CR>

" automatically rebalance windows on vim resize
"autocmd VimResized * :wincmd =
" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

"Git 
nnoremap <leader>G :Gcommit<cr>

" Use better search highlighting
nnoremap <silent> n   n:call HLNext()<cr>
nnoremap <silent> N   N:call HLNext()<cr>
"Blink current search item - from Damian Conway 'More Instantly Better Vim'
" Remove the blinktime and just highlight the selected searchterm
function! HLNext()
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat  = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
endfunction

" Allow ale to open the quickfix window and show all warnings and errors
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"Refresh NerdTree automagically taken from
"https://bluz71.github.io/2017/05/21/vim-plugins-i-like.html
function! NERDTreeRefresh()
  if &filetype == "nerdtree"
    silent exe substitute(mapcheck("R"), "<CR>", "", "")
  endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

"Git integration for nerdtree, uses Plug nerdtree-git-plugin
let g:NERDTreeUpdateOnCursorHold = 0

"Show indentlines uses Plug indentLine
"let g:indentLine_faster = 1
"let g:indentLine_setConceal = 0
let g:diminactive_enable_focus = 1


:ia pryp <CR>import code; code.interact(local=dict(globals(), **locals()))
"If openen a read only file without sudo:
" :w !sudo tee % 
"inoremap <leader> c <CR>import code; code.interact(local=dict(globals(), **locals()))
