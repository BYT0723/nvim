lua require('init')

" neovide
if exists("g:neovide")
  set guifont=CaskaydiaCove\ Nerd\ Font\ SemiLight:i:h9
  let g:neovide_refresh_rate=60
  let g:neovide_refresh_rate_idle=20
  let g:neovide_transparency=0.9
  let g:neovide_hide_mouse_when_typing = v:true
  let g:neovide_cursor_animation_length=0.1
  let g:neovide_cursor_trail_size=0.5
  let g:neovide_remember_window_size = v:true
endif

" quickfix
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

" Golang
autocmd FileType go nnoremap taj :silent call TagAction('add', 'json')<CR>
autocmd FileType go nnoremap trj :silent call TagAction('remove', 'json')<CR>
function! TagAction(action,tagsName) abort
  let structName = GetName('struct','type [A-Za-z0-9_]\+ struct {')
  exec "!gomodifytags -file %:. -struct ".structName." -".a:action."-tags ".a:tagsName." -w --quiet -transform camelcase"
endfunction

autocmd FileType goctl nnoremap bd :FloatermNew goctl api go -api %:. -dir %:.:h -style goZero<CR>
autocmd FileType proto nnoremap bd :FloatermNew cd %:.:h && goctl rpc protoc %:.:t --go_out=. --go-grpc_out=. --zrpc_out=. --style=goZero<CR>


" 编译运行
nnoremap rr :call CompileRun()<CR>
func! CompileRun()
  if &filetype == 'c'
    exec "FloatermNew gcc -pthread -o ./%:.:r %:. && ./%:.:r "
  elseif &filetype == 'cpp'
    exec "FloatermNew g++ -o ./bin/%:.:r %:. && ./bin/%:.:r"
  elseif &filetype == 'rust'
    exec "FloatermNew cargo run"
    " exec "FloatermNew rustc --out-dir ./bin/%:.:h %:. && ./bin/%:.:r"
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
    exec "FloatermNew javac -d ./class/ -cp ./class:".jarsStr." %:.:h/*.java && java -ea -cp ./class:".jarsStr." -D:file.encoding=UTF-8 %:.:r"
  elseif &filetype == 'python'
    exec "FloatermNew python %:."
  elseif &filetype == 'go'
    exec "FloatermNew go run %:."
  elseif &filetype == 'markdown'
    exec "MarkdownPreviewToggle"
  elseif &filetype == 'proto'
    exec "FloatermNew protoc --proto_path=%:.:h --go_out=plugins=grpc:%:.:h/pb %:."
  elseif &filetype == 'html'
    exec "silent !firefox %:. &"
  elseif &filetype == 'sh'
    exec "FloatermNew ./%:."
  elseif &filetype == 'javascript' || &filetype == "typescript"
    exec "FloatermNew node ./%:."
  endif
endfunction

let g:mkdp_browser = 'chromium'

" test unit
nnoremap tt :call TestFunction()<CR>
nnoremap tb :call BenchmarkFunction()<CR>
func! TestFunction() abort
  let funcName = GetName('func','func Test\([A-Za-z0-9]\+\)(t \*testing.T)')
  if funcName != ''
    exec "FloatermNew go test -v ./%:.:h -run='".funcName."'"
  else
    exec "FloatermNew go test -v ./%:."
  endif
endfunction

" benchmark
func! BenchmarkFunction() abort
  let funcName = GetName('func', 'func Benchmark\([A-Za-z0-9]\+\)(b \*testing.B)')
  if funcName != ''
    exec "FloatermNew go test -bench='".funcName."' ./%:.:h -run=none"
  else
    exec "FloatermNew go test -bench=. ./%:.:h -run=none"
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

" terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-Space>t <C-\><C-n>:FloatermToggle<CR>
nnoremap <C-Space>t :FloatermToggle<CR>

" 窗口管理
nnoremap w <C-w>
nnoremap <C-h> :vertical resize -5<CR>
nnoremap <C-l> :vertical resize +5<CR>
nnoremap <C-j> :resize +5<CR>
nnoremap <C-k> :resize -5<CR>

" quick position
noremap gh ^
noremap ge $

nnoremap tj :tabn<CR>
nnoremap tk :tabp<CR>
nnoremap tc :tabclose<CR>

nnoremap W :w!<CR>
nnoremap Q :q!<CR>

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

" 设置默认使用系统剪贴板
set clipboard=unnamedplus

" 设置行数
set number
set relativenumber

" 开启文件检查
filetype indent on

" 自动缩进长度为2
set shiftwidth=2
" tab自动转空格
set expandtab

set tabstop=2
set softtabstop=2

" 行高亮
set cursorline

" 折行
set nowrap

" 符号匹配
set showmatch

" 搜索忽略大小写
set ignorecase

" 不创建交换
set noswapfile
