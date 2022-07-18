"  _           _   _                 _
" (_)  _ __   (_) | |_      __   __ (_)  _ __ ___
" | | | '_ \  | | | __|     \ \ / / | | | '_ ` _ \
" | | | | | | | | | |_   _   \ V /  | | | | | | | |
" |_| |_| |_| |_|  \__| (_)   \_/   |_| |_| |_| |_|
"
"  ____   __   __  _____    ___    _____   ____    _____
" | __ )  \ \ / / |_   _|  / _ \  |___  | |___ \  |___ /
" |  _ \   \ V /    | |   | | | |    / /    __) |   |_ \
" | |_) |   | |     | |   | |_| |   / /    / __/   ___) |
" |____/    |_|     |_|    \___/   /_/    |_____| |____/
"

lua require('init')

" AsyncRun
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

" JSON
autocmd BufWritePost *.json :silent %!python -m json.tool --tab --no-ensure-ascii

" Godot
autocmd BufNewFile,BufRead *.gd set filetype=gdscript
autocmd BufNewFile,BufRead project.godot set filetype=godot_resource
autocmd BufNewFile,BufRead *.tscn set filetype=godot_resource
autocmd BufNewFile,BufRead *.tres set filetype=godot_resource

" Golang
" autocmd BufWritePost *.go :silent !goimports -w %:.
autocmd BufWritePost *.go :silent !gofmt -w %:.
autocmd FileType go nnoremap taj :silent call TagAction('add', 'json')<CR>
autocmd FileType go nnoremap trj :silent call TagAction('remove', 'json')<CR>
function! TagAction(action,tagsName) abort
  let structName = GetName('struct','type [A-Za-z0-9_]\+ struct {')
  exec "!gomodifytags -file %:. -struct ".structName." -".a:action."-tags ".a:tagsName." -w --quiet -transform camelcase"
endfunction

" goctl
func! GoctlFormat()
  exec "silent !goctl api format --dir ."
  exec "e"
endfunction

func! GoctlDiagnostic()
  let mes = execute("silent !goctl api validate --api %:.")
  echo mes
endfunction

autocmd BufWritePre *.api :silent call GoctlDiagnostic()
autocmd BufWritePost *.api :silent call GoctlFormat()

autocmd FileType goctl nnoremap bd :AsyncRun goctl api go -api %:. -dir %:.:h -style goZero<CR>
autocmd FileType proto nnoremap bd :AsyncRun cd %:.:h && goctl rpc protoc %:.:t --go_out=. --go-grpc_out=. --zrpc_out=. --style=goZero<CR>


" 编译运行
nnoremap rr :call CompileRun()<CR>
nnoremap rst :AsyncRun -mode=term -pos=st 
func! CompileRun()
  if &filetype == 'c'
    exec "AsyncRun gcc -pthread -o ./%:.:r %:. && ./%:.:r "
  elseif &filetype == 'cpp'
    exec "AsyncRun g++ -o %:.:r %:. && ./%:.:r"
  elseif &filetype == 'rust'
    exec "AsyncRun rustc --out-dir ./bin/%:.:h %:. && ./bin/%:.:r"
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
    exec "AsyncRun javac -d ./class/ -cp ./class:".jarsStr." %:.:h/*.java && java -ea -cp ./class:".jarsStr." -D:file.encoding=UTF-8 %:.:r"
  elseif &filetype == 'python'
    exec "AsyncRun python %:."
  elseif &filetype == 'go'
    exec "AsyncRun go run %:."
  elseif &filetype == 'markdown'
    exec "MarkdownPreviewToggle"
  elseif &filetype == 'proto'
    exec "AsyncRun protoc --proto_path=%:.:h --go_out=plugins=grpc:%:.:h/pb %:."
  elseif &filetype == 'html'
    exec "silent !firefox %:. &"
  elseif &filetype == 'sql'
    exec "SQHExecuteFile %:."
  elseif &filetype == 'plantuml'
    exec "silent !plantuml % -o %:h/img/ && feh %:h/img/%:t:r.png"
  elseif &filetype == 'sh'
    exec "AsyncRun ./%:."
  elseif &filetype == 'gdscript'
    exec "GodotRun"
  endif
endfunction

function OpenMarkdownPreview (url)
  execute "AsyncRun -silent surf " . a:url
  echo a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'

" test unit
nnoremap tt :call TestFunction()<CR>
nnoremap tb :call BenchmarkFunction()<CR>
func! TestFunction() abort
  let funcName = GetName('func','func Test\([A-Za-z0-9]\+\)(t \*testing.T)')
  if funcName != ''
    exec "AsyncRun go test -v ./%:.:h -run='".funcName."'"
  else
    exec "AsyncRun go test -v ./%:."
  endif
endfunction

" benchmark
func! BenchmarkFunction() abort
  let funcName = GetName('func', 'func Benchmark\([A-Za-z0-9]\+\)(b \*testing.B)')
  if funcName != ''
    exec "AsyncRun go test -bench='".funcName."' ./%:.:h -run=none" 
  else
    exec "AsyncRun go test -bench=. ./%:.:h -run=none"
  endif
endfunction

" 获取函数或结构体名称
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

let g:vsnip_snippet_dir = "~/.config/nvim/snippets"


" 窗口管理
nnoremap w <C-w>
nnoremap <C-h> :vertical resize -5<CR>
nnoremap <C-l> :vertical resize +5<CR>
nnoremap <C-j> :resize +5<CR>
nnoremap <C-k> :resize -5<CR>

nnoremap bq :bd<CR>

" quick position
noremap <C-a> gg^vG$
noremap gh ^
noremap ge $

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
set nocompatible

" 显示当前模式
set showcmd

set encoding=utf-8
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

" 不创建备份
set nobackup

" 不创建交换
set noswapfile

autocmd InsertLeave * :silent !fcitx5-remote -c
autocmd BufCreate *  :silent !fcitx5-remote -c
autocmd BufEnter *  :silent !fcitx5-remote -c
autocmd BufLeave *  :silent !fcitx5-remote -c

inoreabbrev github@ https://github.com/BYT0723
inoreabbrev qq@ 1151713064@qq.com
inoreabbrev 163@ twang9739@163.com
inoreabbrev gmail@ twang9739@gmail.com
