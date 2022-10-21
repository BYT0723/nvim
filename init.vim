lua require('init')

" Golang
autocmd FileType go nnoremap taj :silent call TagAction('add', 'json')<CR>
autocmd FileType go nnoremap trj :silent call TagAction('remove', 'json')<CR>
function! TagAction(action,tagsName) abort
  let structName = GetName('struct','type [A-Za-z0-9_]\+ struct {')
  exec "!gomodifytags -file %:. -struct ".structName." -".a:action."-tags ".a:tagsName." -w --quiet -transform camelcase"
endfunction

autocmd FileType goctl nnoremap bd :TermExec cmd='goctl api go -api %:. -dir %:.:h -style goZero'<CR>
autocmd FileType proto nnoremap bd :TermExec dir='%:.:h' cmd='goctl rpc protoc %:.:t --go_out=. --go-grpc_out=. --zrpc_out=. --style=goZero'<CR>

" test unit
nnoremap tt :call TestFunction()<CR>
nnoremap tb :call BenchmarkFunction()<CR>
func! TestFunction() abort
  let funcName = GetName('func','func Test\([A-Za-z0-9]\+\)(t \*testing.T)')
  if funcName != ''
    exec "TermExec cmd='go test -v ./%:.:h -run=".funcName."'"
  else
    exec "TermExec cmd='go test -v ./%:.'"
  endif
endfunction

" benchmark
func! BenchmarkFunction() abort
  let funcName = GetName('func', 'func Benchmark\([A-Za-z0-9]\+\)(b \*testing.B)')
  if funcName != ''
    exec "TermExec cmd='go test -bench=".funcName." ./%:.:h -run=none'"
  else
    exec "TermExec cmd='go test -bench=. ./%:.:h -run=none'"
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

" 开启文件检查
filetype indent on
