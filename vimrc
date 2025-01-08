" Always use vim mode, even when starting with vi
set nocompatible

"set cmdheight=20
"change mapleader to ,
let mapleader = ","

if filereadable(expand("~/dotfiles/vimrc.packages"))
  source ~/dotfiles/vimrc.packages
endif

" minpac commands:
command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

let &runtimepath.=',~/.vim/pack/minpac/start'

filetype plugin indent on

set encoding=utf-8

"This must be before the colorscheme command otherwise it will not stick
" This highlights match-up with underlines in things like html files instead of 
" coloring the whole line. So this keeps the regular syntax highlighting
augroup matchup_matchparen_highlight
  autocmd!
  autocmd ColorScheme * hi MatchParen ctermbg=NONE
  autocmd ColorScheme * hi MatchWord  ctermbg=NONE cterm=undercurl gui=undercurl
augroup END


"colorscheme catppuccin-frappe "-macchiato " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

set clipboard=unnamed                    "Allow copy paste in terminal vim
set noshowmode                           "Do not show the regular mode ( --- INSERT --) because airline already does this"

" Automatic go to last edited line when opening file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif


"NerdTree configuration
let g:NERDTreeWinSize=31
let g:NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>
"map <Leader>n :Lexplore<CR>

"open in a vertial split
"let g:netrw_browse_split =1 

"Nerdtree like setup for netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Lexplore
" augroup END

"---------------------------------
"Mapping keys
"---------------------------------
" Shortcuts



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

"Copy the current filepath
nmap <Leader>cp :let @+=expand("%p")<CR>

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
au BufRead,BufNewFile *.strings set ft=yaml
au BufRead,BufNewFile *.md set ft=markdown
au BufNewFile,BufRead *.json.jbuilder set ft=ruby
au BufNewFile,BufRead *.html.eex set ft=html
au BufNewFile,BufRead *.exs set ft=elixir
au BufNewFile,BufRead *.handlebars ft=mustache


autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal spelllang=en,nl

autocmd FileType asciidoc setlocal spell
autocmd FileType asciidoc setlocal spelllang=en,nl

autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal spelllang=en,nl


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

function! StatusDiagnostic() abort
  let info = get(b:, '', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, '', '')
endfunction






set showtabline=2
set guioptions-=e
set laststatus=2

set showtabline=0
set laststatus=2

" autoresize splits when resizing
au VimResized * exe "normal! \<c-w>="

let g:matchup_matchparen_nomode = 'i'
let g:matchup_matchpref = {}
let g:matchup_matchpref.html = {'tagnameonly': 1}
let g:matchup_matchpref.htmldjango = {'tagnameonly': 1}
let g:matchup_matchparen_offscreen = {'method': 'popup'}


"Running  commands from vim to fish is slow when the shell is set to fish :(
"Setting it to bin/sh it's fast although we lose fish as the shell
set shell=/bin/sh
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

if filereadable(expand(printf('%s/%s', getcwd(), '.vimrc.test_runners')))
  exec printf('source %s/%s', getcwd(), '.vimrc.test_runners')
endif
let g:test#strategy = 'vimux'


"Python support for vim tmux runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

"SEARCHING --------------------
set rtp+=/opt/homebrew/opt/fzf

"Git
nnoremap <leader>G :Git commit<cr>

" Allow ale to open the quickfix window and show all warnings and errors
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"inject a debugger statement based on the current filetype
"nnoremap <leader>d oimport code; code.interact(local=dict(globals(), **locals()))<ESC>
augroup myautocmds
  autocmd!
  au BufNewFile,BufRead,BufEnter *.rb nnoremap <leader>d obinding.pry<ESC>
  au BufNewFile,BufRead,BufEnter *.py nnoremap <leader>d obreakpoint()<ESC>
  au BufNewFile,BufRead,BufEnter *.js nnoremap <leader>d odebugger;<ESC>
  au BufNewFile,BufRead,BufEnter *.ts nnoremap <leader>d odebugger;<ESC>
augroup END


au BufNewFile,BufRead,BufEnter *.py nnoremap <leader>c ofrom celery.contrib import rdb;rdb.set_trace()<ESC>


"nnoremap <leader>f %!python -m json.tool

"If openen a read only file without sudo:
" :w !sudo tee %
"
"Golang (vim-go settings)
"" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

"create skeleton files for these 
autocmd BufNewFile readme.md 0r ~/dotfiles/skeletons/readme.md
autocmd BufNewFile *.rb 0r ~/dotfiles/skeletons/ruby.rb


set secure
if filereadable(expand(printf('%s/%s', getcwd(), '.vimrc')))
  exec printf('source %s/%s', getcwd(), '.vimrc')
endif

function! s:SourceConfigFilesIn(directory)
  let directory_splat = '~/dotfiles/vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    if filereadable(config_file)
      execute 'source' config_file
    endif
  endfor
endfunction

let g:python3_host_prog = "~/.pyenv/versions/3.12.2/bin/python"

"source files from rcfiles moves config files for plugins to own files
call s:SourceConfigFilesIn('ftplugin')
call s:SourceConfigFilesIn('rcfiles')
