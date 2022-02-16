# These are my configurations for nvim
### Bloat but Blazing
#### Always WIP ¯\\\_(ツ)_/¯

Most likely this config won't work for you if you just clone it because there is so much local stuff.
But feel free to use it as a reference and copy configs or code snippets you like.

- Tables of contents
    + [Structure](#structure)
    + [Features](#features)
      - [Completion with nvim-cmp](#completion-with-nvim-cmp)
      - [Telescope with custom pickers](#telescope-with-custom-pickers)
        * [Custom layout strategy](#custom-layout-strategy)
        * [Colorscheme Switcher (live preview)](#colorscheme-switcher--live-preview-)
      - [LSP](#lsp)
        * [Custom Diagnostic Float (layout and messages)](#custom-diagnostic-float--layout-and-messages-)
        * [Errors in trouble.nvim](#errors-in-troublenvim)
        * [Peek Definitions](#peek-definitions)
      - [Mappings with which-key.nvim](#mappings-with-which-keynvim)
      - [Startup.nvim](#startupnvim)
      - [Toggleterm](#toggleterm)
        * [Lazygit](#lazygit)
        * [Run Code](#run-code)
      - [Neorg](#neorg)
    + [Credits](#credits)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

### Structure
All the configurations for plugins are in `/lua/configs/`.
General settings (options, mapping, plugins) are directly in `/lua/`.
In `vimhelp` there are some custom helpfiles which I can display with a local plugin.

### Features

#### Completion with nvim-cmp
![completion](https://user-images.githubusercontent.com/81827001/148636648-0ca0c870-f038-460c-8447-d6e9c1f1e381.png)

#### Telescope with custom pickers

##### Custom layout strategy
![custom_bottom](https://user-images.githubusercontent.com/81827001/148636875-ea155bd1-3deb-4f76-842f-4ff3fa034c64.png)

##### Colorscheme Switcher (live preview)

https://user-images.githubusercontent.com/81827001/148636889-94167d71-626f-4f1a-949a-30861423859b.mov

#### LSP

Easily see where errors are with underline and sign.
Diagnostic count in statusline.

![lsp_signs_count](https://user-images.githubusercontent.com/81827001/148636951-9d1603f6-90c6-4ac8-9d4e-e4e80e9de787.png)

##### Custom Diagnostic Float (layout and messages)

![custom_diag_1](https://user-images.githubusercontent.com/81827001/148636927-d7d81ad8-b193-45bb-aa63-169c5b6c80f1.png)
![custom_diag_2](https://user-images.githubusercontent.com/81827001/148636932-96ffe083-27aa-4cd9-a095-15dd077be5e0.png)

##### Errors in trouble.nvim

![trouble](https://user-images.githubusercontent.com/81827001/148636965-78e8130e-0d88-4fc5-8f3f-cab6967e7f86.png)

##### Peek Definitions
![peek_definition](https://user-images.githubusercontent.com/81827001/148637041-87214f3c-4c7c-4653-a06c-dc89dc9687f3.png)

#### Mappings with which-key.nvim
![which-key](https://user-images.githubusercontent.com/81827001/148637523-fcb4540f-9b60-4570-ae26-b157a934f610.png)

#### Startup.nvim

![startup](https://user-images.githubusercontent.com/81827001/148637556-658c7282-bd03-4a9d-a083-6bcae28157e1.png)

#### Toggleterm

##### Lazygit

![lazygit](https://user-images.githubusercontent.com/81827001/148637630-292d5a33-c764-40fd-b467-2a422b9c5bb6.png)

##### Run Code

![run_code](https://user-images.githubusercontent.com/81827001/148637617-76dba56c-7ea5-439d-85d6-cffa047986ba.png)

#### Neorg

![neorg_gtd](https://user-images.githubusercontent.com/81827001/148637690-43d802f2-dace-40cf-a622-7ea2f2fc296c.png)

![neorg_cpp_notes](https://user-images.githubusercontent.com/81827001/148637720-4678b437-e7d5-42eb-901a-8f2411db0715.png)

![neorg_cur_buf](https://user-images.githubusercontent.com/81827001/148637762-477a1936-3988-4c50-8f96-ad9002cf7e0a.png)

![neorg_insert_link](https://user-images.githubusercontent.com/81827001/148637782-5824b524-fe22-44e2-9a78-67e71ebe37c5.png)

### Credits
I took inspiration (and code snippets 😄)from a lot of configs.
The most important ones where:
- [doom-nvim](https://github.com/ntbbloodbath/doom-nvim)
- [nvchad](https://github.com/nvchad/nvchad)
- [tjdevries](https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim)
- [abzcoding](https://github.com/abzcoding/nvim)
- [tamton-aquib](https://github.com/tamton-aquib/nvim)
