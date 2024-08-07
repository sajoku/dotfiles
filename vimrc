" Always use vim mode, even when starting with vi
set nocompatible

"set cmdheight=20
"change mapleader to ,
let mapleader = ","

if filereadable(expand("~/dotfiles/vimrc.packages"))
  source ~/dotfiles/vimrc.packages
endif

" minpac commands:
command! PackUpdate source $MYVIMRC | call minpac#update()
command! PackClean  source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

let &runtimepath.=',~/.vim/pack/minpac/start'

filetype plugin indent on

set encoding=utf-8


"This must be before the colorscheme command otherwise
" it will not stick
augroup matchup_matchparen_highlight
  autocmd!
  autocmd ColorScheme * hi MatchParen ctermbg=NONE
  autocmd ColorScheme * hi MatchWord  ctermbg=NONE cterm=underline gui=underline
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


map <Leader>n :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>
"map <Leader>n :Lexplore<CR>

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


function! g:GroupSuffix()
  if mode() ==# 'i' && &paste
    return '2'
  endif
  if &modified
    return '1'
  endif
  return ''
endfunction

function! g:CrystallineStatuslineFn(winnr)
  let g:crystalline_group_suffix = g:GroupSuffix()
  let l:curr = a:winnr == winnr()
  let l:s = ''

  if l:curr
    let l:s .= crystalline#ModeSection(0, 'A', 'B')
  else
    let l:s .= crystalline#HiItem('Fill')
  endif
  let l:s .= ' %f%h%w%m%r '
  if l:curr
    let l:s .= crystalline#Sep(0, 'B', 'Fill') . ' %{fugitive#Head()} - %{StatusDiagnostic()}'
  endif

  let l:s .= '%='
  if l:curr
    let l:s .= crystalline#Sep(1, 'Fill', 'B') . '%{&paste ? " PASTE " : " "}'
    let l:s .= crystalline#Sep(1, 'B', 'A')
  endif
  if winwidth(a:winnr) > 80
    let l:s .= ' %{&ft} %l/%L %2v %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! g:CrystallineTablineFn()
  let l:max_width = &columns
  let l:right = '%='

  let l:right .= crystalline#Sep(1, 'TabFill', 'TabType')
  let l:max_width -= 1

  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  let l:right .= l:vimlabel
  let l:max_width -= strchars(l:vimlabel)

  let l:max_tabs = 23

  return crystalline#DefaultTabline({
        \ 'enable_sep': 1,
        \ 'max_tabs': l:max_tabs,
        \ 'max_width': l:max_width
        \ }) . l:right
endfunction

set showtabline=2
set guioptions-=e
set laststatus=2
let g:crystalline_auto_prefix_groups = 1

let g:crystalline_theme = 'hybrid'
set showtabline=0
set laststatus=2

" autoresize splits when resizing
au VimResized * exe "normal! \<c-w>="

let g:matchup_matchparen_nomode = 'i'
let g:matchup_matchpref = {}
let g:matchup_matchpref.html = {'tagnameonly': 1}
let g:matchup_matchpref.htmldjango = {'tagnameonly': 1}


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
  au BufNewFile,BufRead,BufEnter *.py nnoremap <leader>d oimport pdb; pdb.set_trace()<ESC>
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

"CocAction
"nnoremap <silent><nowait> <space>d :call CocAction("jumpDefinition", v:false)<CR>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" " Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')


"Pick a differnt color for the currentl selection
"nnoremap <silent><nowait> <space>c :call CocAction('colorPresentation')<CR>

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
