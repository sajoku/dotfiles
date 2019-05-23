" Always use vim mode, even when starting with vi
set nocompatible

"set cmdheight=20
"change mapleader to ,
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

silent! colorscheme dim
" ============================================================
"  OPTIONS  {{{~
" =============================================================
set nocursorline                         " Do not show a horizontal bar the cursor is
set backspace=indent,eol,start           " Allow backspace over everything in insert
set nobackup
set nowritebackup
set noswapfile                           " Stop using .swp files
set autoindent                           " Always set autoindenting on
set history=100                          " Keep x lines in history
set ruler                                " Always show cursor
set showcmd                              " Display incomplete commands
set showmode
set mouse=a                              " Enable mouse
set mousehide                            " Hide mouse when typing
set timeoutlen=500                       " Don't lag the leader key + command
set showmatch
set nofoldenable                         " Don't fold by default
set foldmethod=indent
set foldlevel=99
set visualbell                           " no sounds
set ttyfast
                                         " Search related settings
set incsearch                            " find as you type search
set hlsearch                             " Highlight all search matches
set ignorecase                           " Ignore case with / searched
set smartcase                            " Don't ignore case when search has capital
set noesckeys
setglobal relativenumber
set relativenumber
set number                               " Show line numbers
set linespace=3
set numberwidth=2
set laststatus=2
set autoread                             " Automatically read files changed on disk by other programs
                                         " http://items.sjbach.com/319/configuring-vim-right
set viminfo='100,f1                      " Save up to 100 marks, enable capital marks
set scrolloff=3                          " Keep more context when csrolling, also use zz
                                         " Softtabs
set tabstop=2                            " Global tab width
set shiftwidth=2
set shiftround
set expandtab                            " Use spaces instead of tab
set softtabstop=2

set splitbelow                           " Split windows below the current window.
                                         " Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t,i
set completeopt=menu,preview
set fileformat=unix
set showbreak="@"                        " Prepend linebreaks with @ symbol
set list listchars=tab:»·,trail:·,nbsp:· " Display extra whitespace

set directory=~/.vim/backup
set backupdir=~/.vim/backup
set undodir=~/.vim/undodir
set undofile

set clipboard=unnamed                    "Allow copy paste in terminal vim
set noshowmode                           "Do not show the regular mode ( --- INSERT --) because airline already does this"
"Set rake as default make program. Uncomment if I do alot of Rails
"set makeprg=rake

" ==========================================================================================================
"  }}}
" ==========================================================================================================

" Automatic go to last edited line when opening file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree
let g:NERDTreeUpdateOnCursorHold = 0 " Git integration for nerdtree, uses Plug nerdtree-git-plugin

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
au BufNewFile, BufRead *.handlebars ft=mustache

autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.html set filetype=html
augroup END

"Remove trailing whitespace when writing a file
autocmd BufWritePre *.{erb,js,css,sass,scss,html,htm,yml,markdown,feature,haml,mustache,cofffee,slim,eex} :%s/\s\+$//e

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

" Use `tab` key to select completions.  Default is arrow keys.
" When enter is pressed, select option and insert return

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:completor_auto_close_doc = 1
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Use tab to cycle through options
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"



" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use tab to trigger auto completion.  Default suggests completions as you type.
let g:completor_auto_trigger = 1
inoremap <expr> <Tab> Tab_Or_Complete()

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

function! StatusLine(current)
  return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CrystallineInactive#')
        \ . ' %f%h%w%m%r '
        \ . (a:current ? '%#CrystallineFill# %{fugitive#head()} ' : '')
        \ . '%=' . (a:current ? '%#Crystalline# %{&paste?"PASTE ":""}%{&spell?"SPELL ":""}' . crystalline#mode_color() : '')
        \ . (a:current ? ' %{LinterStatus()}': '')
        \ . ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'hybrid'
set showtabline=0
set laststatus=2

"Ale syntax checker settings
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_column_always = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '✖'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_set_highlights = 1

let g:ale_linters = {}
let g:ale_fixers = {}

let g:ale_html_htmlhint_executable = 'htmlhint'
let g:ale_html_htmlhint_use_global = 1
let g:html_htmlhint_use_global = 1


let g:ale_linters = {'ruby': ['standardrb']}
let g:ale_fixers = {'ruby': ['standardrb']}

let g:ale_linters.javascript = [
\    'prettier', 'jshint'
\]

let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['vue'] = ['prettier']
let g:ale_javascript_prettier_use_local_config = 1

let g:ale_linters.python = [
\    'black', 'flake8', 'isort', 'pylint'
\]

let g:ale_fixers.python = [
\ 'black', 'isort'
\]

let g:ale_linters['css'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']

let g:ale_linter_aliases = {}
let g:ale_linter_aliases = {
\ 'js': 'javascript',
\}

let g:ale_javascript_prettier_use_global = 1
let g:ale_completion_enabled = 1

"let g:ale_javascript_eslint_executable = '/usr/local/Cellar/node/8.1.2/bin/eslint'

" Set the correct flake8 executable and arguments to have typechecking
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_args = '-m flake8'
let g:ale_python_pylint_options = '--rcfile ~/dotfiles/pylint.rc'

let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1

highlight ALEErrorSign guibg=NONE guifg=red ctermbg=NONE ctermfg=red
highlight ALEError cterm=underline guibg=NONE guifg=red ctermbg=NONE ctermfg=red
highlight ALEWarning cterm=underline guibg=NONE guifg=red ctermbg=NONE ctermfg=red

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" autoresize splits when resizing
au VimResized * exe "normal! \<c-w>="

runtime! macros/matchit.vim

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
"let g:test#strategy = 'asyncrun'


"Python support for vim tmux runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

"SEARCHING --------------------
set rtp+=/usr/local/opt/fzf
" shortcut for searching through whole folder
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nmap g/ :Ack!<space>
nmap <c-p> :cclose<CR>:FZF<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build/*,/build/,*.nib,*.tmp,*.log,releases/*,*.pyc
"
" FZF
" -----------------
" This prefixes all FZF-provided commands with 'Fzf' so I can easily find cool
" FZF commands and not have to remember 'Colors' and 'History/' etc.
let g:fzf_command_prefix = 'Fzf'

nnoremap <ctrl>p :FZF<CR>
nnoremap <leader>p :FZF<CR>
nnoremap <leader>b :FzfBuffers<CR>

"Zoom and resize stuff
"Resize splits with shift-(h,j,k,l)
nnoremap <S-h> :exe "vertical resize +10"<CR>
nnoremap <S-l> :exe "vertical resize -10"<CR>
nnoremap <S-k> :exe "resize +10"<CR>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

"Git
nnoremap <leader>G :Gcommit<cr>

" Use better search highlighting
nmap <leader>h :nohlsearch<cr>
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


nnoremap <leader>d oimport code; code.interact(local=dict(globals(), **locals()))<ESC>

"If openen a read only file without sudo:
" :w !sudo tee %
"
"Golang (vim-go settings)
"" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

"Enable per project .vimrc
set exrc
set secure
