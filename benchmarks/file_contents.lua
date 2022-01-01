-- remove buf get lines to allow to use more runs (it's so slow :( )
require("plenary/benchmark")("IO vs LIBUV vs READFILE vs BUF_GET_LINES", {
  warmup = 0,
  runs = 20,
  fun = {
    {
      "buf get lines",
      function()
        vim.fn.bufload("~/.config/nvim_config/init.lua")
        local bufname = vim.fn.bufname("init.lua")
        local bufnr = vim.fn.bufnr(bufname)
        local data = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        vim.cmd("bunload! " .. bufnr)
        return data
      end,
    },
    {
      "uv",
      function()
        local fd = assert(vim.loop.fs_open("init.lua", "r", 438))
        local stat = assert(vim.loop.fs_fstat(fd))
        local data = assert(vim.loop.fs_read(fd, stat.size, 0))
        assert(vim.loop.fs_close(fd))
        data = vim.split(data, "\n")
        return data
      end,
    },
    {
      "io",
      function()
        local fp = assert(io.open("init.lua"), "r")
        local data = fp:read("*all")
        fp:close()
        data = vim.split(data, "\n")
        return data
      end,
    },
    {
      "readfile",
      function()
        local data = vim.fn.readfile("init.lua")
        return data
      end,
    },
  },
})
