To register a new lsp configuration you must:
1. Create a file with the name of the lsp server. e. g. gopls.lua
2. Add the configuration object, this file should return an object with the configuration
```
return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' }
}
```
3. Register this new file in ../lua/configs/neovim/lsp.lua
