# Neovim configuration with Lua

## Usage

The configuration can be used through importing `setup` module from the root of repository.

Steps to do so:
1. clone repository.
2. rename directory to 'lua'.
3. import the `setup` module from 'init.lua' (must lay near to the lua directory).

Steps 1-2:
```bash
git clone --depth 1 https://github.com/e1turin/neovim-config lua
```

Content of 'init.lua':
```lua
require('setup')
```
