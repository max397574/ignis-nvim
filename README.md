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
- [x] Switch to nvim-cmp
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
├── UltiSnips
├── colors
│   ├── galaxy.lua
│   └── galaxy_light.lua
├── init.lua
├── lua
│   ├── autocommands.lua
│   ├── colors
│   │   ├── color_galaxy.lua
│   │   ├── color_galaxy_light.lua
│   │   ├── fixed_highlights.lua
│   │   └── themes.lua
│   ├── configs
│   │   ├── bufferline.lua
│   │   ├── cmp.lua
│   │   ├── dashboard.lua
│   │   ├── lsp.lua
│   │   ├── lsp_kind.lua
│   │   ├── lualine.lua
│   │   ├── lvim_helper.lua
│   │   ├── nvim_comment.lua
│   │   ├── shade.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   ├── vmath.lua
│   │   └── which_key.lua
│   ├── mappings.lua
│   ├── options.lua
│   ├── plugins.lua
│   └── utils.lua
├── my_snippets
│   ├── java.snippets
│   ├── lua.snippets
│   ├── markdown.snippets
│   └── tex.snippets
├── notes.txt
├── plugin
│   ├── packer_compiled.lua
│   └── simplefunctions.vim
├── queries
│   ├── lua
│   │   └── highlights.scm
│   └── vim
│       └── highlights.scm
├── random.vim
├── stylua.toml
└── vimhelp
    ├── cmp.md
    ├── latex.md
    ├── telescope.md
    ├── treesitter.md
    ├── ts_textobjects_move.md
    └── ts_textobjects_select.md

11 directories, 43 files
```

Features:
---------

### Completition with nvim-cmp
![cmp](https://user-images.githubusercontent.com/81827001/132104885-a8961020-dccf-4be4-9e02-0fce969c74c7.png)


### Syntax Highlighting with TreeSitter
![treesitter](https://user-images.githubusercontent.com/81827001/132104907-ed1f152d-c2ce-4cb4-ab12-04358f148872.png)


### Telescope for:
  * Finding Files
  * Live Grep
  * Search History
  * Command History
  * Help Tags
  * And more...

![Screen Shot 2021-09-04 at 20 44 40](https://user-images.githubusercontent.com/81827001/132104944-7c75754d-5d5f-44d9-8453-2fdead83f270.png)


### Plugins and Mappings for all Git Commands
![git](https://user-images.githubusercontent.com/81827001/129145817-6ceb0aa2-b5ec-49c9-ad21-e45ef821c3e6.png)

### Which Key to display mappings
![which_key](https://user-images.githubusercontent.com/81827001/132104980-a7efc624-2062-40cd-982e-518ed3f22b4d.png)


### Mappings for easy markdown
### Snippets for UltiSnips and vim-snippets
### LspDiagnostics
![lsp](https://user-images.githubusercontent.com/81827001/132105006-e6f88337-30e9-4156-ad25-ff3215d40de8.png)


### TreeSitter plugins for:
  * TextObjects
  * Refacotr
  * Motions
  * Context of Function
  * Structural Editing with Queries
![ts_context](https://user-images.githubusercontent.com/81827001/129145865-8301102f-5b75-440f-9b61-218600248df1.png)

Feel free to write something in the Discussions tab.
