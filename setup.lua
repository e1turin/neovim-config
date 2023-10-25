-- Settings
require('core.settings')
require('core.mappings') -- Make sure to set `mapleader` before Lazy (plugin manager) so your mappings are correct
require('core.plugin-manager')
require('core.theme') -- setup plugged theme

-- startup configuration
require('core.on-startup')
