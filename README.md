## These are my configurations for nvim
I recently switched to `init.lua`.

At the moment there are still some files in vimscript.

- [x] Switch to `init.lua`
- [x] Change more files to lua
- [x] Configure TreeSitter
- [x] Create mappings for TreeSitter
- [x] Switch to lua plugin manager

long term:
- [ ] Create lua functions/plugins
```
                 == ==                     max397574 ~ git version 2.24.3 (Apple Git-128)
          ==               ==    @@@@@@    ----------------------------------------------
               @@@@@@@@@@       @@@@@@@@   Project: Vim_Config (3 branches)
     ==    @@@@@@@@@@@@@@@@@    @@@@@@@@   HEAD: 56f567e (master, origin/master)
   ==    @@@@@@@@@@@@@@@@@@@@@   @@@@@@    Created: 2 months ago
        @@@@@@@@@@@@@@@@@@@@@@@@           Languages: Lua (70.2 %) VimScript (29.8 %)
 ==    @@@@@@@@@@@@@@@@@@@@@@@@@@    ==    Authors: 98% max397574 464
==    @@@@@@@@@@@@@@@@@@@@@@@@@@@@    ==            1% max397574 6
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Last change: 2 minutes ago
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Repo: https://github.com/max397574/Vim_Config.git
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Commits: 470
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Lines of code: 949
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Size: 39.21 KiB (15 files)
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
│   ├── mappings.lua
│   └── plugins.lua
├── mapping.vim
├── plugins
│   ├── markdown.vim
│   └── simplefunctions.vim
├── queries
├── tablemode.vim
└── vimhelp
    └── treesitter.md

5 directories, 12 files
```

Feel free to write something in the Discussions tab.
