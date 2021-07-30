## These are my configurations for nvim
I recently switched to `init.lua`.

At the moment there are still some files in vimscript.

- [x] Switch to `init.lua`
- [ ] Change more files to lua
- [ ] Configure TreeSitter
- [ ] Create mappings for TreeSitter

long term:
- [ ] Create lua functions/plugins
```
                 == ==                     max397574 ~ git version 2.24.3 (Apple Git-128)
          ==               ==    @@@@@@    ----------------------------------------------
               @@@@@@@@@@       @@@@@@@@   Project: Vim_Config (3 branches)
     ==    @@@@@@@@@@@@@@@@@    @@@@@@@@   HEAD: 257c105 (master, origin/master)
   ==    @@@@@@@@@@@@@@@@@@@@@   @@@@@@    Created: 2 months ago
        @@@@@@@@@@@@@@@@@@@@@@@@           Languages: Lua (59.0 %) VimScript (41.0 %)
 ==    @@@@@@@@@@@@@@@@@@@@@@@@@@    ==    Authors: 98% max397574 435
==    @@@@@@@@@@@@@@@@@@@@@@@@@@@@    ==            1% max397574 6
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Last change: 16 seconds ago
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Repo: https://github.com/max397574/Vim_Config.git
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Commits: 441
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Lines of code: 1150
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Size: 46.56 KiB (28 files)
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==
      @@@@@@@@@@@@@@@@@@@@@@@@@@@@
==     @@@@@@@@@@@@@@@@@@@@@@@@@     ==
 ==      @@@@@@@@@@@@@@@@@@@@@      ==
           @@@@@@@@@@@@@@@@@
   ==          @@@@@@@@@@        ==
     ==                        ==
          ==              ==
                 == ==
```

The structure of the directory:
```
.
├── README.md
├── autocmds.vim
├── highlights.vim
├── init.lua
├── lua
│   ├── config_files
│   │   └── options.lua
│   └── plugin_settings
│       ├── colorizer.lua
│       ├── comment.lua
│       ├── compe.lua
│       ├── lsp.lua
│       ├── lvim_helper.lua
│       ├── telescope.lua
│       ├── todo-comments.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       ├── twilight.lua
│       └── which_key.lua
├── mapping.vim
├── plugins
│   ├── fixspelling.vim
│   ├── hudigraphs.vim
│   ├── markdown.vim
│   ├── move_em.vim
│   └── simplefunctions.vim
├── plugins.vim
├── tablemode.vim
└── vimhelp
    └── treesitter.md

5 directories, 25 files
```

Feel free to write something in the Discussions tab.
