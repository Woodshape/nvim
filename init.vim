syntax enable
filetype plugin indent on

" better search behavior
set incsearch
set nohlsearch
set noshowmode
" do not wrap lines if they get too long
set nowrap

" show whitespace characters
set listchars=eol:⏎,tab:>-,trail:·,extends:>,precedes:<
set list

" no error tone when doing illegal stuff
set noerrorbells

" Stop nvim from creating *.swp or backup files
set noswapfile
set nobackup

" Set numbering to show relative numbers except on the line you are on.
" Show absolute line nr on current line
set number
set relativenumber
set numberwidth=6
highlight LineNr ctermbg=16
highlight LineNr ctermfg=15
highlight CursorLineNr ctermbg=8

" Column after 100 cahracter per line to stop endless lines
set colorcolumn=100
" Show signcolumn. Used by plugins to show errors, git diff and so on
set signcolumn=yes
highlight ColorColumn ctermbg=6
" set command line hight to 2 for better readablity of longer commands
set cmdheight=2

set updatetime=50

" configure tab behavior
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent

" set offset when scrolling down, up, left or right to start scrolling when you are 10
" characters away from the side in question
set scrolloff=10
set sidescrolloff=10

" Better completion menu
set completeopt=longest,menuone,noinsert,noselect
set wildchar=<Tab> wildmenu wildmode=full
set hidden

" Plugins
call plug#begin()
    Plug 'BurntSushi/ripgrep'
    Plug 'jremmen/vim-ripgrep'
    Plug 'vim-scripts/cSyntaxAfter'
    Plug 'morhetz/gruvbox'
    Plug 'vhdirk/vim-cmake'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'enricobacis/vim-airline-clock'
    Plug 'justmao945/vim-clang'
    Plug 'rhysd/vim-clang-format'
    Plug 'yuezk/vim-js'
    Plug 'HerringtonDarkholme/yats.vim'
    Plug 'maxmellon/vim-jsx-pretty'
    Plug 'rust-lang/rust.vim'
    Plug 'neomake/neomake'
    Plug 'voldikss/vim-floaterm'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'xavierd/clang_complete'
    Plug 'ervandew/supertab'
    Plug 'mbbill/undotree'
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

    Plug 'habamax/vim-godot'
call plug#end()

colorscheme gruvbox

" highlight TODOs and FIXMEs in comments
highlight todo term=italic,bold cterm=italic ctermbg=darkyellow ctermfg=white gui=bold,italic guibg=darkyellow guifg=white
syntax match todo /\v(TODO|FIXME).*/ containedin=.*Comment

" set vim airline theme and tab bar (top)
let g:airline_theme='onedark'
let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline#extensions#tabline#enabled=1

" nicer NERDTree characters for opened and closed folders
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" lat clang look for style file in pwd and auto format on save
let g:clang_format#detect_style_file=1
let g:clang_format#auto_format=1

" path to directory where library can be found
let g:clang_library_path='/usr/lib/llvm-10/lib/libclang-10.so.1'

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed

let g:mkdp_auto_close = 1

" leader for macros used later (seen as <Leader> in remaps)
let mapleader=" "

" make these languages look better
autocmd! FileType c,cpp,java,php call CSyntaxAfter()

" more convenient split navigation
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" more convenient insert mode -> normal mode switch
inoremap jj <Esc>

" shortcuts fzf (fuzzy file finder) and ripgrep (fuzzy file content finder,
" requires ripgrep to be installed)
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>f :Rg<CR>
nnoremap <Leader>g :Commits<CR>

" Undo tree for easier undo and redo management
nnoremap <Leader>u :UndotreeToggle<CR>

" easier in vim terminal management
nnoremap <Leader>t :FloatermToggle<CR>
tnoremap <Leader>t <C-\><C-n>:FloatermToggle<CR>

" shortcut to open nerd tree
nnoremap <Leader>e :NERDTree<CR>

" move lines up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>j :m .+1<CR>==
nnoremap <Leader>k :m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
" make Y behave normally
nnoremap Y y$
" keep it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
" resizing buffer
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
" replace trailing commas with {} and line breaks (used for *.c files after
" copzing the finction definitions from header files)
nnoremap <Leader>ci :%s/;/ {\r\r}\r/g<CR>
" search and replace word under cursor
nnoremap <Leader>r :%s/<C-R><C-W>//g<Left><Left>
" search and replace word under cursor with confimration before replace
nnoremap <Leader>rc :%s/<C-R><C-W>//gc<Left><Left>

" Automatically close ", ', (, [, {
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
      let n = a:colnr - 1
      execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
      execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
      match Keyword /^[^,]*/
      normal! 0
  else
      match
  endif
endfunction
" command to highlight certain column in csv file
command! -nargs=1 Csv :call CSVH(<args>)

" ignore file names when using ripgrep
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
