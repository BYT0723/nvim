## Neovim

> It's my neovim configuration

### feature

- use Packer.nvim
- Neovim's LSP
- some custom environment

![neovim-preview](https://github.com/BYT0723/nvim/blob/master/imgs/nvim-preview.png)

#### required

- nvim-python
- Lua

check your depend by `:checkhealth`

#### Plugins in `lua/plugins.lua`

```lua
aaaa
return require('packer').startup(function()
    use '...package name'
end)
```

#### some run configuration in `init.vim`

```vimscript
something of coding, like function run file and tag manager
```
