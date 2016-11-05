"========================moonfoam's Vim ConfigFiles=============================="
"First You Need Install Vundle to manage plugins
"To Know more about vundle: https://github.com/VundleVim/Vundle.vim
"Set up Vundle
"$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"================================================================================

set nocompatible              " be iMproved, required
filetype off                  " required


"=========================Plugin===============================
" Vundle Plugin Manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

" Package Manager
Plugin 'VundleVim/Vundle.vim'

" Function

Plugin 'sjl/gundo.vim'  "Time Machine
Plugin 'godlygeek/tabular'  "text filtering and alignment
Plugin 'majutsushi/tagbar'  "Source code browser
Plugin 'Lokaltog/vim-easymotion' "Quick Jump In This Page

" Theme
Plugin 'Zenburn'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'altercation/vim-colors-solarized'


" Window Manager
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'splitjoin.vim'
Plugin 'Lokaltog/powerline' , {'rtp': 'powerline/bindings/vim/'}
"Bundle 'powerline/fonts'
"Bundle 'vim-airline/vim-airline'
"Bundle 'vim-airline/vim-airline-themes'

" Code Force
Bundle 'Valloric/YouCompleteMe'
Bundle 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Bundle 'Valloric/ListToggle'
Bundle 'luochen1990/rainbow'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/syntastic'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'simplefold'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-surround'
Bundle 'ctrlpvim/ctrlp.vim'

""" Language
" PHP
Bundle 'spf13/PIV'
Bundle 'arnaud-lb/vim-php-namespace'
Bundle 'beyondwords/vim-twig'

" Python
Bundle 'klen/python-mode'
Bundle 'yssource/python.vim'
Bundle 'python_match.vim'
Bundle 'pythoncomplete'
Plugin 'vim-scripts/indentpython.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"=================Auto==================
" python  PEP8
au BufNewFile,BufRead *.py
\set tabstop=4
\set softtabstop=4
\set shiftwidth=4
\set textwidth=79
\set expandtab
\set autoindent
\set fileformat=unix

" js html css
au BufNewFile,BufRead *.js, *.html, *.css
\set tabstop=2
\set softtabstop=2
\set shiftwidth=2

"=========================Setting===============================
" My setting
colorscheme solarized "atom-dark-256
set background=dark

set encoding=utf-8
set expandtab      " Tabs are spaces, not tabs
set tabstop=4
set softtabstop=4 " Let backspace delete indent
set shiftwidth=4
set scrolljump=5
set backspace=indent,eol,start

set nu
set cursorline
set smartindent
set autoindent
set cindent        "在C编码时,自动完成indent缩进内嵌代码块
set hlsearch      "高亮显示搜索结果
set ignorecase    "搜索忽略大小写
set incsearch     " Find as you type search

" No Error Noise
set noerrorbells
set novisualbell
set vb t_vb=

syntax enable
syntax on

let g:solarized_termcolors=256
let mapleader = ","
set t_Co=256

"Keep the focus always on the center
nnoremap j jzz
nnoremap k kzz
"fast save
nnoremap w :w!<CR>
"行尾空格显示
set list                                         " 显示特殊符号
set listchars=trail:•,extends:#,nbsp:.           " Highlight problematic whitespace
"set listchars=tab:›\ ,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace

"[](){} 匹配
inoremap ( ()<esc>i
inoremap <expr>) CloseJump(")")
inoremap [ []<esc>i
inoremap <expr>] CloseJump("]")
inoremap { {<cr>}<esc>O
inoremap <expr>} CloseJump("}")
inoremap " ""<esc>i
inoremap ' ''<esc>i
:if expand("%:e") == "html"
    inoremap < <><esc>i
    inoremap <expr>> CloseJump(">")
:endif
inoremap <expr><tab> CloseJump("tab")

:function CloseJump(endchar)
    :let pc = matchstr(getline('.'), '\%' . col('.') . 'c.')
    :if a:endchar == "tab"
        :echo "yes"
        :if pc == ')' || pc == ']' || pc == '}' || pc == '"' || pc == "'" || (pc == '>' && expand("%:e") == "html")
            :return "la"
        :else
            :return "	"
        :endif
    :else
        :if pc == a:endchar
            :return "la"
        :else
            :if a:endchar == '"'
                :return '""'
            :endif
            :if a:endchar == "'"
                :return "''"
            :endif
            :return a:endchar
        :endif
    :endif
:endf

"============================Short Cut==============================
"paste mode 不进行缩进
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>
" Change t_co between 256 and 8
map <F4> <Esc>:call F4exec()<CR>
"call togglebg#map("<F4>")
map <F5> <Esc>:call F5exec()<CR>
map <F7> <esc>:call F7exec()<cr>
nmap <F8> <esc>:TagbarToggle<CR>
"tagbar
map <F10> <esc>:call F10exec()<cr>


"switch t_Co between 8(pure terminal) & 256
function F4exec()
    if &t_Co == '256'
        set t_Co=8
    else
        set t_Co=256
    endif
    set t_Co?
endf

"exec program
function F5exec()
    w
    if expand("%:e") == "cpp"
        !echo -e "\033[01;32m==== `date` ====\033[0m"; clang -std=c++11 % -c -o /dev/null && g++ --std=c++11 % -o exe -g  && ( echo -e "running:" && time ./exe ) || ( echo -e "\033[01;31mCompilation error.\033[0m" )
    endif
    if expand("%:e") == "sh"
        !echo -e "\033[01;32m==== `date` ====\033[0m"; time sh ./% 
    endif
    if expand("%:e") == "py"
        !echo -e "\033[01;32m==== `date` ====\033[0m"; time python % 
    endif
    if expand("%") == "makefile"
        !echo -e "\033[01;32m==== `date` ====\033[0m"; make
    endif
endf

function F7exec()
    w
    if expand("%:e") == "cpp"
        !echo -e "\033[01;32m==== `date` ====\033[0m"; clang -std=c++11 % -c -o /dev/null && g++ --std=c++11 % -o exe -g  && ( echo -e "\033[01;32mCompilation done.\033[0m" ) || ( echo -e "\033[01;31mCompilation error.\033[0m" )
    endif
    if expand("%:e") == "hpp"
        !echo -e "\033[01;32m==== `date` ====\033[0m"; clang -std=c++11 % -c -o /dev/null && ( echo -e "\033[01;32mCompilation done.\033[0m" ) || ( echo -e "\033[01;31mCompilation error.\033[0m" )
    endif
endf

function F10exec()
    w
    if expand("%:e") == "cpp"
        !echo -e "\033[01;32m==== `date` ====\033[0m"; g++ --std=c++11 % -o exe -g && gdb exe -tui
    endif
endf

"=======================Plugin Setting============================
" powerline
set laststatus=2
set guifont=Source\ Code\ Pro\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set termencoding=utf-8

" split
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Enable folding with the spacebar
nnoremap <space> za

" nerdtree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=233
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey


" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" rainbow
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ycm
"  -I dir
"  　　Add the directory dir to the list of directories to be searched
"  forheader files. Directories named by -I are searched before the standard
"  system include directories.
"
"  　　-isystem dir
"  　　Search dir for header files, after all directories specified by -I but
"  before the standard system directories.Mark it as a system directory, so
"  that it gets the same special treatment as is applied to the standard
"  system directories.
"
"  　　所以我们把自己项目中的头文件所在的文件夹放在-I后面，而把c++的库的头文件、qt的库的头文件放在-isystem后面
"       '-isystem',
"       '/usr/include',
"       '-isystem',
"       '/usr/include/c++',
"       '-isystem',
"       '/usr/include/c++/6.1.1',
"       '-isystem',
"       '/usr/include/linux'
"
let g:ycm_global_ycm_extra_conf='/home/wangchi/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"按,jd 会跳转到定义
"cpp
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"youcompleteme  默认tab  s-tab 和自动补全冲突
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']

let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_show_diagnostics_ui = 1    " 开启实时错误或者warning的检测

let g:ycm_collect_identifiers_from_tags_files=1     " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2         " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0                          " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1            " 语法关键字补全
let g:ycm_complete_in_strings = 1                   "在字符串输入中也能补全
"highlight YcmErrorLine guibg=#3f0000

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" Python-mode
" Activate rope
" Keys: 按键：
" K             Show python docs 显示Python文档
" <Ctrl-Space>  Rope autocomplete  使用Rope进行自动补全
" <Ctrl-c>g     Rope goto definition  跳转到定义处
" <Ctrl-c>d     Rope show documentation  显示文档
" <Ctrl-c>f     Rope find occurrences  寻找该对象出现的地方
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled) 断点
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
"            跳转到前一个/后一个类或函数
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
"              跳转到前一个/后一个类或方法
let g:pymode_rope = 1

" Documentation 显示文档
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting 代码查错，=1为启用
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting 高亮形式
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code 禁用自动代码折叠
let g:pymode_folding = 0


"gundo
nnoremap <Leader>u :GundoToggle<CR>

"tabular
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a,, :Tabularize /,\zs<CR>
vmap <Leader>a,, :Tabularize /,\zs<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

"================syntastic===========================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

