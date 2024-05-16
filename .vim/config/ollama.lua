-- https://github.com/olimorris/codecompanion.nvim

local url = "http://paul-pc.lan:11434"

local function get_ollama_choices()
  local url = "http://paul-pc.lan:11434"
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
          order = 1,
          mapping = "parameters",
          type = "enum",
          desc = "ID of the model to use.",
          -- default = "deepseek-coder:6.7b",
          default = "codegemma",
          choices = get_ollama_choices(),
        },
        temperature = {
          order = 2,
          mapping = "parameters.options",
          type = "number",
          optional = true,
          default = 0.8,
          desc = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top_p but not both.",
          validate = function(n)
            return n >= 0 and n <= 2, "Must be between 0 and 2"
          end,
        },
      },
    })
  }
})

vim.api.nvim_set_keymap("n", "<Leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>cc", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>cc", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })

