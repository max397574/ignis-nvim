-- Some of this code is from https://github.com/ntbbloodbath/doom-nvim/blob/b5e30226288a27dcd9a4dcc4d743e33e6a65ba67/lua/doom/core/system/init.lua#L1

local system = {}

---System separator
system.separator = package.config:sub(1, 1)

---The directory of your config (default: $XDG_CONFIG_HOME/nvim)
system.ignis_dir = vim.fn.stdpath("config")

---The default directory for the ignis config (default: $XDG_CONFIG_HOME_HOME/ignis-nvim)
system.ignis_config_dir = vim.fn.stdpath("config"):match(".*[/\\]"):sub(1, -2)
    .. system.separator
    .. "ignis-nvim"

return system
