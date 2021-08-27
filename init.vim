" auto vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" leader 键位映射
let mapleader = " "

" 插件管理
call plug#begin("~/.config/nvim/plugged")

"COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" function
Plug 'preservim/nerdcommenter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vista.vim'
Plug 'jiangmiao/auto-pairs'


" filesystem
Plug 'kevinhwang91/rnvimr'

" code
Plug 'fatih/vim-go'
Plug 'neoclide/jsonc.vim'
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'

" markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'

" git
Plug 'kdheepak/lazygit.nvim'
Plug 'airblade/vim-gitgutter'

" theme
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ajmwagar/vim-deus'

call plug#end()

" coc-explorer
nnoremap <silent> <leader>e :CocCommand explorer<CR> 

" rnvimr
nnoremap <silent> <leader>r :RnvimrToggle<CR>
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 1
highlight link RnvimrNormal CursorLine

let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-s>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'cd': 'JumpNvimCwd',
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': float2nr(round(0.9 * &columns)),
            \ 'height': float2nr(round(0.8 * &lines)),
            \ 'col': float2nr(round(0.05 * &columns)),
            \ 'row': float2nr(round(0.10 * &lines)),
            \ 'style': 'minimal' }


" auto change workspce
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'cd '.argv()[0] | endif

" coc 插件管理
let g:coc_global_extensions = [
            \'coc-docker',
            \'coc-marketplace',
            \'coc-snippets',
            \'coc-json',
            \'coc-vimlsp',
            \'coc-go',
            \'coc-sh',
            \'coc-python',
            \'coc-tsserver']

" Ctrl + 空格 显示补全
inoremap <silent><expr> <C-space> coc#refresh()
" 回车补全展开
inoremap <silent><expr> <cr> !pumvisible() ? "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
            \: coc#_select_confirm()
            " \: !coc#expandable() ? coc#refresh()
                              
" <TAB>补全、代码段跳转
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" : "\<TAB>"
            " \ <SID>check_back_space() ? "\<TAB>" :
            " \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" coc-snippets
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'

" [g || ]g 查找上一个或下一个报错点
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" 查看函数的定义和调用位置
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>

" 重命名
nmap <silent> rn <Plug>(coc-rename)

" 注释配置
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = {
            \'c' : { 'left': '// ' },
            \'java' :{'left': '//' },
            \'go' : {'left': '//' }}
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
vmap <C-m> <space>c<space>

" 主题
set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
colorscheme deus
let g:deus_termcolors=256

" airline 配置
set laststatus=2
let g:airline_theme = 'deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_z = 'ln:%l/%L[%p%%]  %v'
let g:airline_solarized_bg='dark'

" buffer 编辑
noremap <C-k> :bp<CR>
noremap <C-j> :bn<CR>
noremap bq :bdelete<CR>


" go配置 
" autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtc :CocCommand go.tags.clear<cr>

let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_code_completion_enabled = 0

" markdown 
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
let g:instant_markdown_autoscroll = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" rainbow
let g:rainbow_active = 1 

" Vista 配置
nnoremap <silent> <leader>v :Vista!!<CR>

" lazygit
nnoremap <silent> <leader>g :LazyGit<CR>

" 自定义按键映射
noremap gh ^
noremap ge $
noremap sa ggvG$

inoremap <C-l> <Right>
inoremap <C-d> <BackSpace>
inoremap <C-f> <Delete>

noremap fw :w!<CR>
noremap fq :q!<CR>

" 窗口切换
nnoremap w <C-w>

" 标签切换
" nnoremap <C-h> :tabp<CR>
" nnoremap <C-l> :tabn<CR>

nnoremap cmd :vnew<CR>:term<CR>

" 编译运行
map r :call CompileRun()<CR>
func! CompileRun()
    if &filetype == 'c'
        exec "!gcc -pthread -o ./%< % && ./%<"
    elseif &filetype == 'cpp'
        exec "! g++ -o %< % && ./%<"
    elseif &filetype == 'java'
        exec "! javac -d ./class/ %:h/*.java && java -ea -cp ./lib/mysql-connector-java-8.0.24.jar:./class -D:fiel.encoding=UTF-8 %<"
    elseif &filetype == 'python'
        exec "! python %"
    elseif &filetype == 'go'
        exec "! go run %"
    elseif &filetype == 'markdown'
        exec "InstantMarkdownPreview"
    elseif &filetype == 'proto'
        exec "! protoc --go_out=plugins=grpc:. %"
    elseif &filetype == 'html'
        exec "! google-chrome-stable % &"
    endif
endfunction

" file test 
map t :call FileTest()<CR>
func! FileTest() abort
    if &filetype == "go"
        exec "! go test -v %"
    endif
endfunction

" 设置缓冲区
set hidden

" 响应速度
set updatetime=300

" 精简提示
set shortmess+=c

" 设置默认使用系统剪贴板
set clipboard=unnamedplus 

" 设置行数
set number

" 设置相对行号
set relativenumber

" 语法高亮
syntax enable
set nocompatible

" 显示当前模式
set showmode

set showcmd

set encoding=utf-8
" set fileencoding=utf-8
set fileencodings=utf-8,gb18030,latin1,ucs-bom

" 启用256色
set t_Co=256

" 开启文件检查
filetype indent on

" 缩进
set autoindent
set tabstop=4
set shiftwidth=4

" tab转空格
set expandtab
set softtabstop=4

" 行列高亮
set cursorline
" set cursorcolumn

" 自动折行
" set linebreak
set nowrap

" 显示光标位置
set ruler

" 符号匹配
set showmatch
set hlsearch

" 搜索自动跳转第一个结果
set incsearch

" 搜索忽略大小写
set ignorecase

" 单词拼写检查
" set spell spelllang=en_us

" 不创建备份
set nobackup

" 不创建交换
set noswapfile

" 设置命令模式补全
set wildmenu

" 忽略大小写
set ic
