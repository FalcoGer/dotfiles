local hex = require("hex")

hex.setup({
  dump = {
    cmd = 'xxd',
    -- Replicating your old hexGroupSize and hexColumnSize
    args = { '-g', '1', '-c', '16', '-u' },
  },
  -- Automatically handle these extensions
  ft_enabled = { 'bin', 'img', 'exe', 'dll' },
})

-- Map your old commands to the new plugin functions
-- This keeps your muscle memory for :Hex and :Unhex intact
vim.api.nvim_create_user_command('Hex', hex.dump, {})
vim.api.nvim_create_user_command('Unhex', hex.assemble, {})
