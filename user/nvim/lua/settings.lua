-- neovim settings

--------------
-- keybinds --
--------------

local opts = { noremap = true, silent = true }
local function bind(mode, key, command) vim.api.nvim_set_keymap(mode, key, command, opts) end

bind('n', '<leader>m\\', ':PackerSync<CR>')
bind('n', '<leader>m]', ':Mason<CR>')

--------------
-- terminal --
--------------

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd 'set nonumber'
    vim.cmd 'startinsert!'
  end
})
