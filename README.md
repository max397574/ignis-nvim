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
     ==    @@@@@@@@@@@@@@@@@    @@@@@@@@   HEAD: bfc1874 (master, origin/master)
   ==    @@@@@@@@@@@@@@@@@@@@@   @@@@@@    Created: 2 months ago
        @@@@@@@@@@@@@@@@@@@@@@@@           Languages: Lua (57.7 %) VimScript (42.3 %)
 ==    @@@@@@@@@@@@@@@@@@@@@@@@@@    ==    Authors: 98% max397574 397
==    @@@@@@@@@@@@@@@@@@@@@@@@@@@@    ==            1% max397574 6
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Last change: 23 minutes ago
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Repo: https://github.com/max397574/Vim_Config.git
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Commits: 403
     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Lines of code: 1181
==   @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ==   Size: 45.41 KiB (30 files)
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
│   ├── bettersubstitute.vim
│   ├── fixspelling.vim
│   ├── hudigraphs.vim
│   ├── markdown.vim
│   ├── move_em.vim
│   └── simplefunctions.vim
├── plugins.vim
├── spelling.vim
├── tablemode.vim
└── vimhelp
    └── treesitter.md
```

Feel free to write something in the Discussions tab.
