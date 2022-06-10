## Neovim
> It's my neovim configuration

### feature
* use Packer.nvim
* Neovim's LSP
* some custom environment

![neovim-preview](https://github.com/BYT0723/nvim/blob/master/imgs/nvim-preview.png) 

#### required
* nvim-python
* Lua

check your depend by ```:checkhealth```

#### Plugins in ```lua/plugins.lua```

```lua
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- theme
  use 'kyazdani42/nvim-web-devicons'
  use 'luochen1990/rainbow'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/tokyonight.nvim'

  -- common code plugin
  -- auto plugin
  use 'jiangmiao/auto-pairs' -- 括号自动闭合
  use 'alvan/vim-closetag' -- html标签自动闭合

  -- other
  use 'numToStr/Comment.nvim' --- 注释
  use 'mg979/vim-visual-multi' -- 多选
  use 'tpope/vim-surround' -- 包裹符号
  use 'simrat39/symbols-outline.nvim' -- syntax tree
  use 'skywind3000/asyncrun.vim' -- 异步运行
  use 'folke/trouble.nvim'

  -- language
  use 'BYT0723/vim-goctl'
  use 'Nguyen-Hoang-Nam/nvim-preview-csv'

  -- git
  use 'kdheepak/lazygit.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- nvim-tree
  use 'kyazdani42/nvim-tree.lua'

  -- bufferline
  use { 'akinsho/bufferline.nvim', tag = "v2.*" }

  -- treesitter 代码高亮等
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- lspconfig
  use {
    "neovim/nvim-lspconfig",
    "williamboman/nvim-lsp-installer",
  }

  -- nvim-cmp
  use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
  use 'hrsh7th/cmp-buffer' -- { name = 'buffer' },
  use 'hrsh7th/cmp-path' -- { name = 'path' }
  use 'hrsh7th/cmp-cmdline' -- { name = 'cmdline' }
  use 'hrsh7th/nvim-cmp'
  -- vsnip
  use 'hrsh7th/cmp-vsnip' -- { name = 'vsnip' }
  use 'hrsh7th/vim-vsnip'
  use 'rafamadriz/friendly-snippets'
  -- lspkind
  use 'onsails/lspkind-nvim'


  -- quick startup
  use 'lewis6991/impatient.nvim'
  use 'nathom/filetype.nvim'

  -- markdown
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })
end)
```

#### some run configuration in ```init.vim```

```vimscript
" some go configuration
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
```
