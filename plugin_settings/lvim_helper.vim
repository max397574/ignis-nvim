call plug#begin('~/.vim/plugged')
Plug 'lvim-tech/lvim-helper'
call plug#end()
lua <<EOF
local home = os.getenv('HOME')
require('lvim-helper').setup({
    files = {
	home .. "/.config/nvim/vimhelp/treesitter.md",
	home .. "/.config/nvim/vimhelp/vim_cheat_sheet_cursor_movement.md",
	home .. "/.config/nvim/vimhelp/personal_mappings.md",

    },
    width = 80,
    side = 'right',
    current_file = 1,
    winopts = {
        relativenumber = false,
        number = false,
        list = false,
        winfixwidth = true,
        winfixheight = true,
        foldenable = false,
        spell = false,
        signcolumn = 'no',
        foldmethod = 'manual',
        foldcolumn = '0',
        cursorcolumn = false,
        colorcolumn = '0',
        wrap = false,
        winhl = table.concat({'Normal:LvimHelperNormal'}, ',')
    },
    bufopts = {
        swapfile = false,
        buftype = 'nofile',
        modifiable = false,
        filetype = 'LvimHelper',
        bufhidden = 'hide'
    }
})
EOF
