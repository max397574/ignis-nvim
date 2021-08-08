## These are my configurations for nvim
I recently switched to `init.lua`.

At the moment there are still some files in vimscript.

- [x] Switch to `init.lua`
- [ ] Change more files to lua
- [x] Configure TreeSitter
- [x] Create mappings for TreeSitter
- [x] Switch to lua plugin manager
- [x] Lazy Loading

long term:
- [ ] Create lua functions/plugins
```
                 == ==                     max397574 ~ git version 2.24.3 (Apple Git-128)
          ==               ==    @@@@@@    ----------------------------------------------
               @@@@@@@@@@       @@@@@@@@   Project: Vim_Config (3 branches)
     ==    @@@@@@@@@@@@@@@@@    @@@@@@@@   HEAD: 571f6bb (master, origin/master)
   ==    @@@@@@@@@@@@@@@@@@@@@   @@@@@@    Created: 2 months ago
        @@@@@@@@@@@@@@@@@@@@@@@@           Languages: Lua (81.7 %) VimScript (18.3 %)
 ==    @@@@@@@@@@@@@@@@@@@@@@@@@@    ==    Authors: 98% max397574 493
==    @@@@@@@@@@@@@@@@@@@@@@@@@@@@    ==            1% max397574 6
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Last change: 2 minutes ago
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Repo: https://github.com/max397574/Vim_Config.git
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Commits: 499
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Lines of code: 914
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Size: 39.70 KiB (17 files)
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
│   ├── autocommands.lua
│   ├── config_files
│   │   └── options.lua
│   ├── mappings.lua
│   ├── plugins.lua
│   └── utils.lua
├── plugins
│   ├── markdown.vim
│   └── simplefunctions.vim
├── queries
├── random.vim
├── tablemode.vim
└── vimhelp
    └── treesitter.md

5 directories, 14 files
```

Feel free to write something in the Discussions tab.
