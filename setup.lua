-- Settings
require('core.settings')
require('core.mappings') -- Make sure to set `mapleader` before Lazy (plugin manager) so your mappings are correct
require('core.plugin-manager')
require('core.theme')

-- Plugin settings
require('plugins.mason') -- IMPORTANT: After setting up mason-lspconfig you may set up servers via lspconfig
require('plugins.neodev') -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require('plugins.cmp')
require('plugins.lspconfig')
