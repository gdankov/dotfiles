" ------------------------------ PLUGINS ------------------------------
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/vim-plug'                                                                        " This plugin manager

    Plug 'vim-airline/vim-airline'                                                                  " Status line
    Plug 'vim-airline/vim-airline-themes'                                                           " Themes for the status line
    Plug 'edkolev/tmuxline.vim'                                                                     " Tmux status line generator that supports airline
    Plug 'tpope/vim-fugitive'                                                                       " Git wrapper. Used to display branch in airline

    Plug 'scrooloose/nerdtree'                                                                      " Directory tree explorer

    Plug 'w0rp/ale'                                                                                 " Asynchronous Lint Engine

    Plug 'Shougo/deoplete.nvim'                                                                     " Dark powered asynchronous completion framework for neovim/Vim8
    Plug 'roxma/nvim-yarp'                                                                          " Yet Another Remote Plugin Framework for Neovim (and Vim 8)
    Plug 'roxma/vim-hug-neovim-rpc'                                                                 " Build a compatibility layer for neovim rpc client working on vim8 -- Note: should probably run pip3 install neovim
    Plug 'zchee/deoplete-go', { 'do': 'make'}                                                       " Go completion for deoplete
    Plug 'Shougo/neosnippet.vim'                                                                    " Add snippet support. Used for function prototype completion
    Plug 'Shougo/neosnippet-snippets'                                                               " Collection of snippets for neosnippet

    Plug '/usr/local/opt/fzf'                                                                       " Use brew installed fzf
    Plug 'junegunn/fzf.vim'                                                                         " Awesome fuzzy finder

    Plug 'jiangmiao/auto-pairs'                                                                     " Insert/delete brackets

    Plug 'tpope/vim-surround'                                                                       " Provides mappings to easily delete, change and add surroundings (parentheses, brackets, quotes, XML tags, and more) in pairs

    Plug 'JamshedVesuna/vim-markdown-preview'                                                       " Preview markdown files in the browser

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }                                              " Golang plugin
    Plug 'trayo/vim-ginkgo-snippets'                                                                " Add snippets for Ginkgo BDD testing library for go
    Plug 'SirVer/ultisnips'                                                                         " Add various code snippets
    Plug 'josharian/impl'                                                                           " Generates method stubs for implementing an interface

    "Plug 'jeffkreeftmeijer/vim-numbertoggle'                                                       " Toggle between relative and absolute line numbers -- Note: currently disabled because it's causing lag for some reason

    Plug 'vim-ruby/vim-ruby'                                                                        " Ruby plugin

    Plug 'mhinz/vim-startify'                                                                       " Fancy start screen

    Plug 'zirrostig/vim-schlepp'                                                                    " Move lines (or bocks) of text around easily

    Plug 'tpope/vim-commentary'                                                                     " Comment stuff out

    Plug 'christoomey/vim-system-copy'                                                              " Add mappings to copy to clipboard

    Plug 'junegunn/vim-slash'                                                                       " Improve in-buffer search
    Plug 'henrik/vim-indexed-search'                                                                " Print total number of matches and the index of current match when searching

    Plug 'joshdick/onedark.vim'                                                                     " My current colorscheme
call plug#end()
" ---------------------------------------------------------------------



" ------------------------------ GENERAL ------------------------------
set mouse=a                                                         "Enable mouse
set ttymouse=sgr                                                    "Make the mouse work even in columns beyond 223
set backspace=indent,eol,start                                      "Make backspace normal
set nocompatible                                                    "Disable vi compatibility. Because we're not in 1995
set tw=0                                                            "Disable automactic line wrapping
set list                                                            "Display whitespace characters
set listchars=tab:▸\ ,trail:~,extends:>,precedes:<,space:·          "Specify whitespace characters visualization
set noerrorbells                                                    "Disable beeping
set encoding=utf8                                                   "Encoding
set ffs=unix,dos                                                    "File formats that will be tried (in order) when vim reads and writes to a file
set splitbelow                                                      "Set preview window position to bottom of the page
set scrolloff=5                                                     "Show at least N lines above/below the cursor.

set termguicolors                                                   "Enable TrueColor

let mapleader=","                                                   "Leader is comma

"Replace escape with jk
inoremap jk <esc>

"Save a given assortment of windows so that they're there next time vim is opened (using vim -S)
nnoremap <leader>s :mksession<CR>

" Save file with sudo
command W w !sudo tee % > /dev/null

" Add two new commands:
"    * DiffSaved - show the changes after the last save
"    * diffoff - exit from the mode
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

com! DiffSaved call s:DiffWithSaved()
" ---------------------------------------------------------------------


" ------------------------------ COLORS ------------------------------
syntax enable                                           "Enable syntax processing
colorscheme onedark                                     "This colorscheme
highlight SpecialKey ctermfg=240 guifg=grey35           "Whitespace characters color
highlight Search ctermfg=255 ctermbg=240                "Search result highlight color
highlight VertSplit guifg=#ACB2BE                       "Vertical split highlight color


let g:airline_theme = 'onedark'                     "Airilne theme
" ---------------------------------------------------------------------


" ------------------------------ SPACES & TABS -----------------------------
set tabstop=4               "Number of visual spaces per TAB
set softtabstop=4           "Number of spaces in tab when editing
set expandtab               "Tabs are spaces
set shiftwidth=4            "Indent with 4 spaces
" ---------------------------------------------------------------------


" ------------------------------ UI CONFIG ------------------------------
set number                              "Show line numbers
set nocursorline
filetype indent on                      "Load filetype-specific indent files
set wildmenu                            "Visual autocomplete for command menu
set lazyredraw                          "Redraw only when we need to.
set showmatch                           "Highlight matching [{()}]
" set cursorline                          "Highlight current line - found it to be slow
" highlight CursorLine ctermbg=8
" ---------------------------------------------------------------------


" ------------------------------ SEARCHING ------------------------------
set incsearch               "Incremental search
set hlsearch                "Highlight matches
set ignorecase              "Ignore case on search
" ---------------------------------------------------------------------


" ------------------------------ FOLDING ------------------------------
set foldenable              "Enable folding
set foldmethod=syntax       "Fold based on syntax highlighting
set foldlevelstart=99       "Do not close folds when a buffer is opened
" ---------------------------------------------------------------------


" ------------------------------ MOVEMENT ------------------------------
"Move vertically (down) by visual line
nnoremap j gj
"Move vertically (up) by visual line
nnoremap k gk

" Movement in popup menu
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" ---------------------------------------------------------------------



" =======================================================================================
" =============================== PLUGIN CONFIGURATIONS =================================
" =======================================================================================

" --------------------------------- NERDTree -------------------------------

function! NERDTreeToggleAndFind()
  if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
    execute ':NERDTreeClose'
  else
    if (expand("%:t") != '')
        execute ':NERDTreeFind'
    else
        execute ':NERDTreeToggle'
    endif
  endif
endfunction

" Toggle NERDTree
nnoremap <C-n> :call NERDTreeToggleAndFind()<CR>

" Single mouse click will open any node
let g:NERDTreeMouseMode=3

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Automatically close NerdTree when you open a file
let NERDTreeQuitOnOpen = 1

" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Hide 'Press ? for help' and bookmarks
let NERDTreeMinimalUI = 1

" Directory colors
highlight Directory ctermfg=blue

" Expand directory symbols
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Do not show whitespace characters in NERDTree window
autocmd FileType nerdtree setlocal nolist

" Show hidden files
let NERDTreeShowHidden=1

" --------------------------------------------------------------------------



" --------------------------------- Airline --------------------------------

" Show branch name
let g:airline#extensions#branch#enabled = 1
"
" Do not override tmux settings
let g:airline#extensions#tmuxline#enabled = 0

" Enable powerline symbols
let g:airline_powerline_fonts = 1

" --------------------------------------------------------------------------



" --------------------------------- Vim-Go --------------------------------

" Highlight different language structs
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1

map <leader>n :cnext<CR>
map <leader>p :cprevious<CR>
nnoremap <leader>cc :cclose<CR>

map <leader>n :lnext<CR>
map <leader>p :lprevious<CR>
nnoremap <leader>cc :lclose<CR>

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Build file
autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
" Run
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
" Run tests
autocmd FileType go nmap <leader>gt  <Plug>(go-test)
" Show coverage
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)

" Call goimports on save
let g:go_fmt_command = "goimports"

" Alternate toggles
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')              " Switch to test file
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')           " Vertical split with test file
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')            " Horizontal split with test file

" Show type info for word under the cursor
let g:go_auto_type_info = 1

" Highlight all uses of the identifier under the cursor
let g:go_auto_sameids = 1

" --------------------------------------------------------------------------



" --------------------------------- Vim-Markdown-Preview --------------------------------

" Use Chrome
let vim_markdown_preview_browser='Google Chrome'

" Use github syntax
let vim_markdown_preview_github=1

" --------------------------------------------------------------------------



" --------------------------------- Deoplete -------------------------------

" Enable lazy loading
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()

" Use smart case
let g:deoplete#enable_smart_case = 1

" Disable annoying preview window
set completeopt-=preview

" Set delay for autocompletion after input
call deoplete#custom#option('auto_complete_delay', 200)

" Limit the number of candidates shown
call deoplete#custom#option('max_list', 80)

" --------------------------------------------------------------------------



" --------------------------------- Neosnippet -------------------------------

" Enable function prototype completion
let g:neosnippet#enable_completed_snippet = 1

" Hide annoying symbols
set conceallevel=2
set concealcursor=niv

" Completion shortcut
imap <expr><C-o> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>"
smap <expr><C-o> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>"
xmap <expr><C-o> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<C-o>"

" --------------------------------------------------------------------------



" --------------------------------- ALE -------------------------------

" Enable completion where available.
let g:ale_completion_enabled = 1

" Error sign in gutter
let g:ale_sign_error = '·X'

" Warning sign in gutter
let g:ale_sign_warning = '·!'
" Warning sign color
highlight ALEWarningSign ctermfg=yellow

" Display error information in Airline
let g:airline#extensions#ale#enabled = 1

" Format for echo messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Navigate between errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Do not run when typing
let g:ale_lint_on_text_changed = 'never'

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

" Disable highlighting
let g:ale_set_highlights = 0

" --------------------------------------------------------------------------



" --------------------------------- Startify -------------------------------

" Center the cow
function! s:filter_header(lines) abort
        let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
        let centered_lines = map(copy(a:lines),
            \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
        return centered_lines
endfunction

let g:startify_custom_header = s:filter_header(startify#fortune#cowsay())

" Center the lists
let g:startify_padding_left = 130
" --------------------------------------------------------------------------



" --------------------------------- Schlepp -------------------------------

" Movement
vmap <unique> <up>    <Plug>SchleppUp
vmap <unique> <down>  <Plug>SchleppDown
vmap <unique> <left>  <Plug>SchleppLeft
vmap <unique> <right> <Plug>SchleppRight

" --------------------------------------------------------------------------



" --------------------------------- FZF  -------------------------------

" Fuzzy find files
nnoremap <silent> <leader>f :Files<CR>

" Search for a string in all files
nnoremap <silent> <leader>s :execute 'Rg ' . input('Search for --> ')<CR>

" Search the word under the cursor
nnoremap <silent> <leader>c :execute 'Rg' expand('<cword>')<CR>

" Layout config
let g:fzf_layout = { 'down': '~30%' }

" Show preview when searching files
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Use Rg for searching for contents and show preview
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg  --line-number --no-heading  --smart-case --no-ignore --hidden --follow --glob "!vendor/" '.shellescape(<q-args>), 1,
  \    fzf#vim#with_preview({'down': '60%', 'options': '--bind alt-down:preview-down --bind alt-up:preview-up'},'right:50%', '?'),
  \   <bang>0)


" Extra key bindings
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" --------------------------------------------------------------------------
