## These are my configurations for nvim
#### Always WIP ¯\_(ツ)_/¯

I recently switched to `init.lua`.

At the moment there are still some files in vimscript.

- [x] Switch to `init.lua`
- [ ] Change more files to lua
- [x] Configure TreeSitter
- [x] Create mappings for TreeSitter
- [x] Switch to lua plugin manager

long term:
- [ ] Create lua functions/plugins

The structure of the directory:
```
.
├── README.md
├── highlights.vim
├── init.lua
├── lua
│   ├── autocommands.lua
│   ├── mappings.lua
│   ├── options.lua
│   ├── plugins.lua
│   ├── temporary.lua
│   └── utils.lua
├── my_snippets
│   └── lua.snippets
├── plugin
│   ├── markdown.vim
│   ├── packer_compiled.lua
│   └── simplefunctions.vim
├── queries
├── random.vim
├── stylua.toml
├── temporary.vim
└── vimhelp
    └── treesitter.md

5 directories, 17 files
```

Features:
---------

* Completition with nvim-compe
* Syntax Highlighting with TreeSitter
* Telescope for:
  * Finding Files
  * Live Grep
  * Search History
  * Command History
  * Help Tags
* Plugins and Mappings for all Git Commands
* Which Key to display mappings
* Mappings for easy markdown
* Snippets for UltiSnips and vim-snippets
* LspDiagnostics
* TreeSitter plugins for:
  * TextObjects
  * Refacotr
  * Motions
  * Context of Function
  * Structural Editing with Queries

Feel free to write something in the Discussions tab.
