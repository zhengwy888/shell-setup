"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

" Sets how many lines of history VIM has to remember
set history=700

" Pathogen Enable
if v:version >= 700
    call pathogen#infect()
endif

" Enable filetype plugins
filetype plugin indent on
syntax enable
" filetype indent on
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/plugin/closetag.vim

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" ctags
set tags=./tags;/
"map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Height of the command bar
" set cmdheight=2
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" UTF8 support
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8                     " better default than latin1
  setglobal fileencoding=utf-8           " change default file encoding when writing new files
endif

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab
set smartindent
set autoindent

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
  endif

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <CR> :noh<CR><CR>


" Map key to toggle opt
function MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
    endfunction
command -nargs=+ MapToggle call MapToggle(<f-args>)

" Display-altering option toggles
if v:version >= 700
    "MapToggle <F1> hlsearch
    MapToggle <F2> wrap
    MapToggle <F3> list
    nnoremap <F5> :!echo %:p <CR>
    nnoremap <C-F5> redr!

    nmap <F9> :TagbarToggle<CR>
    " Behavior-altering option toggles
    MapToggle <F10> scrollbind
    MapToggle <F11> ignorecase
    MapToggle <F12> paste
endif
set pastetoggle=<F12>

command PE execute "!p4 edit %"

" command-t options
let g:CommandTCancelMap=['<ESC>','<C-c>']
"let g:CommandTAcceptSelectionMap = '<C-t>'
"let g:CommandTAcceptSelectionVSplitMap='<CR>'
"let g:CommandTAcceptSelectionTabMap = '<CR>'
"let g:CommandTSelectNextMap='<Down>'


"CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_depth=20
