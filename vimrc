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

let &runtimepath.=',~/.vim/pack/minpac/start'

filetype plugin indent on

syntax enable
syntax on
set encoding=utf-8


silent! colorscheme dim

set clipboard=unnamed                    "Allow copy paste in terminal vim
set noshowmode                           "Do not show the regular mode ( --- INSERT --) because airline already does this"

" Automatic go to last edited line when opening file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

let g:netrw_banner = 1 "Show the banner until i get all these commands in my muscle memory
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_list_hide = &wildignore
let g:netrw_sort_sequence = '[\/]$,*' " sort is affecting only: directories on the top, files below

"---------------------------------
"Mapping keys
"---------------------------------
" Shortcuts
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

map <Leader>n :Lexplore<CR>

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
  let info = get(b:, 'coc_diagnostic_info', {})
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


function! StatusLine(current)
  return (a:current ? crystalline#mode() . '%#Crystalline#' : '%#CrystallineInactive#')
        \ . ' %f%h%w%m%r '
        \ . (a:current ? '%#CrystallineFill# %{fugitive#head()} ' : '')
        \ . '%=' . (a:current ? '%#Crystalline# %{&paste?"PASTE ":""}%{&spell?"SPELL ":""}' . crystalline#mode_color() : '')
        \ . (a:current ? '[%{StatusDiagnostic()}]' : '[]')
        \ . ' %{&ft}[%{&enc}][%{&ffs}] %l/%L %c%V %P '
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'badwolf'
set showtabline=0
set laststatus=2

" autoresize splits when resizing
au VimResized * exe "normal! \<c-w>="

runtime! macros/matchit.vim

" These are coming from jank-m/vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>

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
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nmap g/ :Ack!<space>
nmap <c-p> :cclose<CR>:FzfFiles<CR>
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

let g:fzf_files_options =
\ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

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

"Git
nnoremap <leader>G :Gcommit<cr>

" Allow ale to open the quickfix window and show all warnings and errors
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"inject a debugger statement based on the current filetype
"nnoremap <leader>d oimport code; code.interact(local=dict(globals(), **locals()))<ESC>
autocmd FileType python       nnoremap <leader>d oimport pdb; pdb.set_trace()<ESC>
autocmd FileType ruby         nnoremap <leader>d obinding.pry<ESC>
autocmd FileType javascript   nnoremap <leader>d odebugger;<ESC>
autocmd FileType typescript   nnoremap <leader>d odebugger;<ESC>

"nnoremap <leader>f %!python -m json.tool

"If openen a read only file without sudo:
" :w !sudo tee %
"
"Golang (vim-go settings)
"" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

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
"source files from rcfiles moves config files for plugins to own files
call s:SourceConfigFilesIn('rcplugins')
call s:SourceConfigFilesIn('rcfiles')
