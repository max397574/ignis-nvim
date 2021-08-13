# These are my configurations for nvim
#### Always WIP ¯\\\_(ツ)_/¯

I recently switched to `init.lua`.

At the moment there are still some files in vimscript.

Table of Contents
=================

* [Todo](https://github.com/max397574/Vim_Config#todoplans)
* [Structure](https://github.com/max397574/Vim_Config#the-structure-of-the-directory)
* [Features](https://github.com/max397574/Vim_Config#features)

## Todo/Plans:

- [x] Switch to `init.lua`
- [ ] Change more files to lua
- [x] Configure TreeSitter
- [x] Create mappings for TreeSitter
- [x] Switch to lua plugin manager

long term:
- [ ] Create lua functions/plugins

## The structure of the directory:
```
.
├── README.md
├── init.lua
├── lua
│   ├── autocommands.lua
│   ├── colors
│   │   ├── color_galaxy.lua
│   │   ├── fixed_highlights.lua
│   │   └── vimcolors.lua
│   ├── mappings.lua
│   ├── options.lua
│   ├── plugins.lua
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
└── vimhelp
    └── treesitter.md

6 directories, 17 files
```

Features:
---------

### Completition with nvim-compe
![compe](https://user-images.githubusercontent.com/81827001/129145672-b2119bfd-d7ff-4de8-8110-f2e31d3e8d5b.png)

### Syntax Highlighting with TreeSitter
![highlight](https://user-images.githubusercontent.com/81827001/129145712-337d5daa-7862-4cf7-a15a-9ceaa7d92828.png)

### Telescope for:
  * Finding Files
  * Live Grep
  * Search History
  * Command History
  * Help Tags
![telescope](https://user-images.githubusercontent.com/81827001/129145747-c3dc649f-ad13-4bd4-87ea-e8afe33d0a0a.png)

### Plugins and Mappings for all Git Commands
![git](https://user-images.githubusercontent.com/81827001/129145817-6ceb0aa2-b5ec-49c9-ad21-e45ef821c3e6.png)

### Which Key to display mappings
![which_key](https://user-images.githubusercontent.com/81827001/129145832-74f42989-70f8-440a-989c-f408294b78f6.png)

### Mappings for easy markdown
### Snippets for UltiSnips and vim-snippets
### LspDiagnostics
![lsp_diagnostics](https://user-images.githubusercontent.com/81827001/129145849-7c9fc267-9aa6-4eb3-994e-15566c303a07.png)

### TreeSitter plugins for:
  * TextObjects
  * Refacotr
  * Motions
  * Context of Function
  * Structural Editing with Queries
![ts_context](https://user-images.githubusercontent.com/81827001/129145865-8301102f-5b75-440f-9b61-218600248df1.png)

Feel free to write something in the Discussions tab.
