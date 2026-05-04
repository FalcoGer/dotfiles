-- https://github.com/olimorris/codecompanion.nvim

local url = "http://paul-pc.lan:11434"

local function get_ollama_choices()
  local handle = io.popen("sh -c 'curl " .. url .. "/api/tags 2>/dev/null'")
  local jsonStr = ""

  if handle then
    for line in handle:lines() do
      jsonStr = jsonStr .. line
    end
    handle:close()
  end

  local result = {}

  local modelValues = {}
  for match in jsonStr:gmatch('"model":"([^"]+)"') do
    -- Add the extracted model value to the list of model values
    modelValues[match] = true
  end

  -- Convert the keys of the table to a list
  for model, _ in pairs(modelValues) do
    table.insert(result, model)
  end

  return result
end

require("codecompanion").setup({
  strategies = {
    chat = "ollama",
    inline = "ollama"
  },
  adapters = {
    ollama = require("codecompanion.adapters").use("ollama", {
      url = url .. "/api/chat",
      schema = {
        model = {
          default = "deepseek-coder:6.7b",
          choices = get_ollama_choices(),
        },
      },
    })
  }
})

vim.api.nvim_set_keymap("n", "<Leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>cc", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>cc", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })

