## Neovim

> It's my neovim configuration

### feature

- use Packer.nvim
- Neovim's LSP

![neovim-preview](https://github.com/BYT0723/nvim/blob/master/imgs/nvim-preview.png)

#### required

- lua

check your depend by `:checkhealth`

#### Plugins in `lua/plugins.lua`

```lua
aaaa
return require('packer').startup(function()
    use '...package name'
end)
```
