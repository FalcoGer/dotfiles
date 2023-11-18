local chatgpt = require('chatgpt')

local decryptApiKey = function()
    local cmd = 'openssl enc -d -aes-256-cbc -pbkdf2 -iter 10000 -pass "file:/' ..
        os.getenv('HOME') ..
        '/Documents/Machine/NVimChatGptAPIKey_passphrase.txt" -in ' ..
        os.getenv('HOME') .. '/Documents/Machine/NVimChatGptAPIKey.bin'
    -- execute cmd and return it's output
    return "echo " .. vim.fn.systemlist(cmd)[1]
end

local options = {
    -- https://github.com/jackMort/ChatGPT.nvim#secrets-management
    api_key_cmd = decryptApiKey(),
    yank_register = "+",
    edit_with_instructions = {
        diff = false,
        keymaps = {
            close = "<C-c>",
            accept = "<C-y>",
            toggle_diff = "<C-d>",
            toggle_settings = "<C-o>",
            cycle_windows = "<Tab>",
            use_output_as_input = "<C-i>",
        },
    },
    chat = {
        welcome_message = WELCOME_MESSAGE,
        loading_text = "Loading, please wait ...",
        question_sign = "",
        answer_sign = "ﮧ",
        max_line_length = 120,
        sessions_window = {
            border = {
                style = "rounded",
                text = {
                    top = " Sessions ",
                },
            },
            win_options = {
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            },
        },
        keymaps = {
            close = { "<C-c>", "<ESC>" },
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = { "<C-u>", "<C-Up>" },
            scroll_down = {"<C-d>", "<C-Down>" },
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            cycle_modes = "<C-f>",
            next_message = "<C-j>",
            prev_message = "<C-k>",
            select_session = "<Space>",
            rename_session = "r",
            delete_session = "d",
            draft_message = "<C-d>",
            edit_message = "e",
            delete_message = "d",
            toggle_settings = "<C-o>",
            toggle_message_role = "<C-r>",
            toggle_system_role_open = "<C-s>",
            stop_generating = "<C-x>",
        },
    },
    popup_layout = {
        default = "center",
        center = {
            width = "80%",
            height = "80%",
        },
        right = {
            width = "30%",
            width_settings_open = "50%",
        },
    },
    popup_window = {
        border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
                top = " ChatGPT ",
            },
        },
        win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "1",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
        buf_options = {
            filetype = "markdown",
        },
    },
    system_window = {
        border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
                top = " SYSTEM ",
            },
        },
        win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "2",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
    },
    popup_input = {
        prompt = "  ",
        border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
                top_align = "center",
                top = " Prompt ",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
        submit = "<C-Enter>",
        submit_n = "<Enter>",
        max_visible_lines = 20,
    },
    settings_window = {
        border = {
            style = "rounded",
            text = {
                top = " Settings ",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
    },
    openai_params = {
        model = "gpt-3.5-turbo",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 300,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
    openai_edit_params = {
        model = "gpt-3.5-turbo",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
    },
    use_openai_functions_for_edits = false,
    actions_paths = {},
    show_quickfixes_cmd = "Trouble quickfix",
    predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
}

chatgpt.setup(options)
