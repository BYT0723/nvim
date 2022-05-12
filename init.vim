 "  ___           _   _                 _
 " |_ _|  _ __   (_) | |_      __   __ (_)  _ __ ___
 "  | |  | '_ \  | | | __|     \ \ / / | | | '_ ` _ \
 "  | |  | | | | | | | |_   _   \ V /  | | | | | | | |
 " |___| |_| |_| |_|  \__| (_)   \_/   |_| |_| |_| |_|
 

 "  ____   __   __  _____    ___    _____   ____    _____
 " | __ )  \ \ / / |_   _|  / _ \  |___  | |___ \  |___ /
 " |  _ \   \ V /    | |   | | | |    / /    __) |   |_ \
 " | |_) |   | |     | |   | |_| |   / /    / __/   ___) |
 " |____/    |_|     |_|    \___/   /_/    |_____| |____/
 " 
 " Author: https://github.com/BYT0723


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

" 异步运行 -> quickfix
Plug 'skywind3000/asyncrun.vim'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" other
Plug 'preservim/nerdcommenter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vista.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'

" filesystem
Plug 'kevinhwang91/rnvimr'

" code
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'BYT0723/vim-goctl'
Plug 'joereynolds/SQHell.vim'

" markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }


" git
Plug 'kdheepak/lazygit.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'

" theme
Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

call plug#end()

" coc-explorer
nnoremap <silent> <leader>e :CocCommand explorer<CR>

" rnvimr
nnoremap <silent> <leader>r :RnvimrToggle<CR>
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 1
highlight link RnvimrNormal CursorLine

" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fl :Rg<CR>

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
            \'coc-explorer',
            \'coc-marketplace',
            \'coc-snippets',
            \'coc-docker',
            \'coc-emmet',
            \'coc-css',
            \'coc-json',
            \'coc-vimlsp',
            \'coc-go',
            \'coc-sh',
            \'coc-tsserver']


" 回车补全展开
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
                              
" <TAB>补全、代码段跳转
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" coc-snippets
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

" [g || ]g 查找上一个或下一个报错点
nmap <silent> dk <Plug>(coc-diagnostic-prev)
nmap <silent> dj <Plug>(coc-diagnostic-next)

" 查看函数的定义和调用位置
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 重命名
nmap <silent> rn <Plug>(coc-rename)

" 注释配置
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = {
            \'c' : { 'left': '// ' },
            \'java' :{'left': '//' },
            \'go' : {'left': '//' },
            \'python': {'left':'#'}}
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
nmap <leader>m <plug>NERDCommenterToggle
vmap <leader>m <plug>NERDCommenterToggle

" 主题
set termguicolors
set background=dark

" solarized8_dark_high
" solarized8_light_high
" space-vim-dark
" materialtheme
" neodark
colorscheme solarized8_dark_high 

" airline 配置
set laststatus=2
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline_section_z = '%l/%L:%v'

" go配置 
autocmd FileType go nnoremap taj :CocCommand go.tags.add<CR>
autocmd FileType go nnoremap trj :CocCommand go.tags.remove<CR>
autocmd FileType go nnoremap tap :CocCommand go.tags.add.prompt<CR>
autocmd FileType go nnoremap trp :CocCommand go.tags.remove.prompt<CR>

" go test unit opt
autocmd FileType go nnoremap tsg :CocCommand go.test.toggle<CR>
autocmd FileType go nnoremap tsf :CocCommand go.test.generate.function<CR>

autocmd FileType go nnoremap sii :CocCommand go.impl.cursor<CR>


" goctl 
func! GoctlFormat()
    exec "silent !goctl api format --dir ."
    exec "e"
endfunction

func! GoctlDiagnostic()
    let mes = execute("silent !goctl api validate --api %")
    echo mes
endfunction

autocmd BufWritePre *.api :silent call GoctlDiagnostic()
autocmd BufWritePost *.api :silent call GoctlFormat()

autocmd FileType goctl nnoremap bd :AsyncRun goctl api go -api % -dir %:h -style goZero<CR>
autocmd FileType proto nnoremap bd :AsyncRun cd %:h && goctl rpc protoc %:t --go_out=. --go-grpc_out=. --zrpc_out=. --style=goZero<CR>

" blamer
let g:blamer_enabled = 1
let g:blamer_delay = 1000
let g:blamer_show_in_insert_modes = 0
let g:blamer_show_in_visual_modes = 1
let g:blamer_prefix = '  '
let g:blamer_relative_time = 1
" <author>, <author-mail>, <author-time>, <committer>, <committer-mail>, <committer-time>, <summary>, <commit-short>, <commit-long>
let g:blamer_template = '「 <committer>, <committer-time> • <summary> 」'

" markdown 
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
let g:instant_markdown_autoscroll = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" sql
let g:sqh_provider = 'mysql'
let g:sqh_connections = {
    \ 'default': {
    \   'user': 'root',
    \   'password': 'wangtao',
    \   'host': '127.0.0.1'
    \},
    \ 'remote': {
    \   'user': 'root',
    \   'password': 'wangtao',
    \   'host': 'frp.byt0723.xyz',
    \}
\}
nnoremap <silent> <leader>sql :SQHShowDatabases<CR>
autocmd FileType sql nnoremap bd :!goctl model mysql ddl -src % -dir %:h -c -style goZero<CR>

" html,css
autocmd FileType scss setl iskeyword+=@-@

" closetag
let g:closetag_filetypes = 'html,xhtml,xml,jsp'

" rainbow
let g:rainbow_active = 1 

" Vista 配置
" autocmd VimEnter * :silent Vista
nnoremap <silent> <leader>v :Vista!!<CR>
let g:vista_default_executive = 'coc'

" lazygit
nnoremap <silent> <leader>g :LazyGit<CR>

" indent
let g:indentLine_enabled = 1
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0

" AsyncRun
let g:asyncrun_open = 10
let g:asyncrun_trim = 1
nnoremap sc :AsyncStop<CR>

nnoremap ck :cp<CR>
nnoremap cj :cn<CR>
nnoremap cc :cc<CR>
nnoremap <leader>c :call ToggleQuickFix()<CR>
func! ToggleQuickFix()
    let id = getqflist({'winid' : 1}).winid
    if id > 0 
        exec "cclose"
    else
        exec "copen"
    endif
endfunction

" 编译运行
nnoremap rr :call CompileRun()<CR>
nnoremap rst :AsyncRun -mode=term -pos=st 
func! CompileRun()
    if &filetype == 'c'
        exec "AsyncRun gcc -pthread -o ./%< % && ./%< "
    elseif &filetype == 'cpp'
        exec "AsyncRun g++ -o %< % && ./%<"
    elseif &filetype == 'rust'
        exec "AsyncRun rustc --out-dir ./bin/ %:p:. && ./bin/%:p:.<"
    elseif &filetype == 'java'
        " 遍历./lib/
        " 将目录下所有的.jar加入classpath
        if isdirectory("./lib")
            let jarsStr = system("ls ./lib") 
            let jars = split(jarsStr,"\n")
            for i in range(len(jars))
                let jars[i] = "./lib/".jars[i]
            endfor
            let jarsStr = join(jars,":")
        endif
        exec "AsyncRun javac -d ./class/ -cp ./class:".jarsStr." %:h/*.java && java -ea -cp ./class:".jarsStr." -D:file.encoding=UTF-8 %<"
    elseif &filetype == 'python'
        exec "AsyncRun python %"
    elseif &filetype == 'go'
        exec "AsyncRun go run %"
        " exec ":GoRun"
    elseif &filetype == 'markdown'
        exec "InstantMarkdownPreview"
    elseif &filetype == 'proto'
        exec "AsyncRun protoc --proto_path=%:h --go_out=plugins=grpc:%:h/pb %"
    elseif &filetype == 'html'
        exec "silent !google-chrome-stable % &"
    elseif &filetype == 'sql'
        exec "SQHExecuteFile %"
    elseif &filetype == 'plantuml'
        exec "silent !plantuml % -o %:h/img/ && feh %:h/img/%:t:r.png"
    elseif &filetype == 'sh'
        exec "AsyncRun ./%:p:."
    endif
endfunction

" test unit
nnoremap tt :call TestFunction()<CR>
nnoremap tb :call BenchmarkFunction()<CR>
func! TestFunction() abort
  let funcName = GetName('func','func Test\([A-Za-z0-9]\+\)(t \*testing.T)')
  if funcName != ''
    exec "AsyncRun go test -v ./%:p:.:h -run='".funcName."'"
  else
    exec "AsyncRun go test -v ./%:p:."
  endif
endfunction

" benchmark
func! BenchmarkFunction() abort
  let funcName = GetName('func', 'func Benchmark\([A-Za-z0-9]\+\)(b \*testing.B)')
  if funcName != ''
    exec "AsyncRun go test -bench='".funcName."' ./%:h -run=none" 
  else
    exec "AsyncRun go test -bench=. ./%:h -run=none"
  endif
endfunction

func! GetName(typeName,regular) abort
  let index = search(a:typeName,'bn')
  if index > 0
    let currentLine = getline(index) 
    if match(currentLine, a:regular) > -1 
      let snipts = split(currentLine," ")
      return split(snipts[1],"(")[0]
    endif
  endif
  return ''
endfunction

" 窗口管理
nnoremap w <C-w>
nnoremap <C-j> :resize -5<CR>
nnoremap <C-k> :resize +5<CR>
nnoremap <C-h> :vertical resize -5<CR>
nnoremap <C-l> :vertical resize +5<CR>

" buffer 编辑
nnoremap bk :bp<CR>
nnoremap bj :bn<CR>
nnoremap bq :bd<CR>

" 标签切换
nnoremap tk :tabp<CR>
nnoremap tj :tabn<CR>
nnoremap tq :tabc<CR>

" quick position
noremap gh ^
noremap ge $
noremap sa gg^vG$

nnoremap fw :w!<CR>
nnoremap fq :q!<CR>

" codeFold
" za      toggleFold
" zA      reToggleFold
" zo      openFold
" zO      reOpenFold
" zc      closeFold
" zC      reCloseFold
" zm      closeAllFold
" zM      reCloseAllFold
" zr      openAllFold
" zR      reOpenAllFold
set foldmethod=indent
set foldlevelstart=99

" 设置缓冲区
set hidden

" 响应速度
set updatetime=200

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
set fileencodings=utf-8,gb18030,latin1,ucs-bom

" 启用256色
set t_Co=256

" 开启文件检查
filetype indent on

" 缩进
set autoindent
set tabstop=2
set shiftwidth=2

" tab转空格
set expandtab
set softtabstop=2

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

inoreabbrev github@ https://github.com/BYT0723
inoreabbrev qqmail@ 1151713064@qq.com
inoreabbrev gmail@ twang9739@gmail.com
