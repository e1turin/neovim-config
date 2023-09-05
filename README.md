# Neovim configuration with Lua

## Usage

The configuration can be used through requiring `setup` module in the root of repository.

Steps to do so:
1. clone repository.
2. rename directory to 'lua'.
3. require the `setup` module from 'init.lua' near of the directory.


Steps 1-2:
```
git clone --depth 1 https://github.com/e1turin/neovim-config lua
```


Content of 'init.lua':
```
require('setup')
```
