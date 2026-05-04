vim.loader.enable() -- enable built in plugin loader

-- Done before plugins so plugins correctly set the keymaps
-- Set the leader button to , which is easier to press than the default \
-- see :help leader
vim.g.mapleader = ','
vim.g.maplocalleader = '.'
vim.g.timeoutlen = 1500 -- key combination timeout 1.5s (default 1.0s)

-- disable the built in file browser (replaced by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =============================================================================
-- Utility functions

local function make_protected_dir(target_path)
    if vim.fn.isdirectory(target_path) == 0 then
        vim.fn.mkdir(target_path, "p", "0700")
    end
end

require('user.configs.Shell')
require('user.configs.Table2String')

-- =============================================================================
-- Plugins

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- ==========================================
  -- CORE & LSP
  -- ==========================================
  {
    'neoclide/coc.nvim',
    branch = 'release',
    build = ':CocUpdate',
    dependencies = {
      {
        'fannheyward/telescope-coc.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function()
          local telescope = require('telescope')

          -- Configure the extension
          telescope.setup({
            extensions = {
              coc = {
                prefer_preview = true,
                prefer_locations = true,
              }
            }
          })

          -- Load it
          telescope.load_extension('coc')

          -- Keymaps
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { silent = true, noremap = true, desc = desc })
          end

          map("<Space>a", telescope.extensions.coc.diagnostics, "CoC Diagnostics")
          map("<Space>A", telescope.extensions.coc.workspace_diagnostics, "CoC Workspace Diagnostics")
          map("<Space>s", telescope.extensions.coc.document_symbols, "CoC Document Symbols")
          map("<Space>S", telescope.extensions.coc.workspace_symbols, "CoC Workspace Symbols")
          map("<Space>c", telescope.extensions.coc.commands, "CoC Commands")
          map("<Space>x", telescope.extensions.coc.references, "CoC References")
          map("<Space>X", telescope.extensions.coc.references_used, "CoC References Used")
          map("<Space>d", telescope.extensions.coc.declarations, "CoC Declarations")
          map("<Space>D", telescope.extensions.coc.definitions, "CoC Definitions")
          map("<Space>i", telescope.extensions.coc.implementations, "CoC Implementations")
        end
      }
    },
    config = function()
      -- Sourcing your original coc.vim and coc-keybinds
      vim.cmd('source ' .. vim.fn.stdpath('config') .. '/lua/user/configs/coc.vim')
      require('user.configs.coc-keybinds')
    end
  },
  {
    -- TODO: check out windwp/nvim-autopairs
    'Raimondi/delimitMate',
    dependencies = 'windwp/nvim-ts-autotag',
    -- Load on InsertEnter to keep startup fast, as it's an editing utility
    event = "InsertEnter",
    init = function()
      -- https://github.com/Raimondi/delimitMate
      -- :help delimitMate-contents
      vim.g.delimitMate_expand_cr = 0
      vim.g.delimitMate_expand_space = 0
      vim.g.delimitMate_jump_expansion = 0
      vim.g.delimitMate_balance_matchpairs = 1
      vim.g.delimitMate_insert_eol_marker = 1
      vim.g.delimitMate_eol_marker = ''
      vim.g.delimitMate_excluded_regions = 'Comment'

      vim.g.delimitMate_smart_quotes = [===[\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)]===]
      vim.g.delimitMate_smart_matchpairs = [===[^\%(\w\|\!\|[£$]\|[^[:space:][:punct:]]\)]===]
    end,
    config = function()
      local augroup = vim.api.nvim_create_augroup("DelimitMateAutoCloseDisable", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        pattern = "html",
        callback = function()
          vim.b.delimitMate_autoclose = 0
        end,
      })
    end
  },
  {
    'andymass/vim-matchup',
    dependencies = 'nvim-treesitter/nvim-treesitter-context',
    -- Load on setup or when needed for motion
    init = function()
      -- 1. Configuration Variables
      vim.g.matchup_matchparen_enabled = 1
      vim.g.matchup_matchparen_stopline = 200
      vim.g.matchup_matchparen_timeout = 300
      vim.g.matchup_matchparen_insert_timeout = 60
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_hi_surround_always = 0
      vim.g.matchup_motion_override_Npercent = 0
      vim.g.matchup_motion_cursor_end = 1

      -- 2. Dynamic Offscreen Method logic
      -- We check for the context plugins directly in the global package list
      if package.loaded['treesitter-context'] or package.loaded['context'] then
        vim.g.matchup_matchparen_offscreen = { method = 'status', syntax_hl = 1 }
      else
        vim.g.matchup_matchparen_offscreen = { method = 'popup', fullwidth = 1, syntax_hl = 1, border = 1 }
      end
    end,
    config = function()
      -- 3. Keymaps (Plug mappings)
      -- In Lua, we use :normal or call the Plug command via vim.cmd for legacy Plug binds
      vim.keymap.set('n', '<M-Down>', '<Plug>(matchup-%)', { silent = true, desc = "Next matching word" })
      vim.keymap.set('n', '<M-Up>', '<Plug>(matchup-g%)', { silent = true, desc = "Previous matching word" })

      -- 4. Highlights
      local set_hl = vim.api.nvim_set_hl

      set_hl(0, 'MatchParen', { bold = true, reverse = true })
      set_hl(0, 'MatchWord', { bold = true, reverse = true, fg = '#008000', bg = '#FF5F00' })
      set_hl(0, 'MatchParenCur', { bold = true, underdouble = true, sp = '#FFFF00' })

      -- Link MatchWordCur to MatchWord
      vim.cmd('highlight link MatchWordCur MatchWord')
    end
  },

  -- ==========================================
  -- UI & AESTHETICS
  -- ==========================================
  {
    'vim-airline/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes' },
    init = function()
      -- 1. Core behavior
      vim.opt.showmode = false -- set noshowmode
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = 'dark'
      vim.g.airline_experimental = 1
      vim.g.airline_statusline_ontop = 0
      vim.g.airline_skip_empty_sections = 1

      -- 2. Detectors
      vim.g.airline_detect_modified = 1
      vim.g.airline_detect_paste = 1
      vim.g.airline_detect_crypt = 1
      vim.g.airline_detect_spell = 1
      vim.g.airline_detect_spelllang = 'flag'
      vim.g.airline_detect_iminsert = 0

      -- 3. Visuals & Separators
      vim.g.airline_inactive_collapse = 1
      vim.g.airline_inactive_alt_sep = 1
      vim.g.airline_left_sep = ''
      vim.g.airline_left_alt_sep = ''
      vim.g.airline_right_sep = ''
      vim.g.airline_right_alt_sep = ''

      -- 4. Extensions & Parts (Handling the '#' character)
      vim.g['airline#extensions#tagbar#enabled'] = 0
      vim.g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'

      -- 5. Symbols
      vim.g.airline_symbols = {
        branch     = '',
        colnr      = ' ℅:',
        readonly   = '',
        linenr     = ' :',
        maxlinenr  = '☰ ',
        dirty      = '⚡'
      }

      -- 6. Mode Map
      vim.g.airline_mode_map = {
        n     = 'NORMAL',
        i     = 'INSERT',
        v     = 'VISUAL',
        V     = 'V-LINE',
        ['^V']  = 'V-BLOCK',
        c     = 'COMMAND',
        R     = 'REPLACE',
        Rv    = 'V REPLACE',
        t     = 'TERMINAL',
        -- Adding the rest of your specific mappings
        niV   = 'V REPLACE (NORMAL)',
        s     = 'SELECT',
        niI   = 'INSERT (NORMAL)',
        ic    = 'INSERT COMPL GENERIC',
        ['^S']  = 'S-BLOCK',
        no    = 'OP PENDING',
        multi = 'MULTI',
        cv    = 'VIM EX',
        ce    = 'EX',
        ['__']  = '------',
        ['no^V'] = 'OP PENDING BLOCK',
        ['!']   = 'SHELL',
        ix    = 'INSERT COMPL',
        rm    = 'MORE PROMPT',
        niR   = 'REPLACE (NORMAL)',
        r     = 'PROMPT',
        ['r?']  = 'CONFIRM',
        S     = 'S-LINE',
        noV   = 'OP PENDING LINE',
        Rc    = 'REPLACE COMP GENERIC',
        nov   = 'OP PENDING CHAR'
      }
    end
  },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      -- This must be set BEFORE the plugin loads for mouse features
      vim.opt.mousemoveevent = true
    end,
    config = function()
      require('user.configs.bufferline')
    end
  },
  { 'Bekaboo/dropbar.nvim', config = function() require('user.configs.dropbar') end },
  { 'rcarriga/nvim-notify', config = function() require('user.configs.notify') end },
  { 'stevearc/dressing.nvim', dependencies = 'MunifTanjim/nui.nvim', config = function() require('user.configs.dressing') end },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("user.configs.noice")

      -- 2. Register the Telescope extension if telescope is loaded
      local ok, telescope = pcall(require, "telescope")
      if ok then
        telescope.load_extension("noice")

        vim.keymap.set('n', '<Space>n', ':Telescope noice<CR>', {
          silent = true,
          desc = "Open noice history in telescope.",
          noremap = true
        })
      end
    end
  },

  -- ==========================================
  -- NAVIGATION & FILES
  -- ==========================================
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "mrbjarksen/neo-tree-diagnostics.nvim",
        config = function()
          -- empty
        end
      },
      -- Optional: Image support ONLY if using Kitty
      {
        "3rd/image.nvim",
        cond = function()
          return os.getenv("TERM") == "xterm-kitty"
        end,
      },
    },
    config = function()
      require("user.configs.neotree")
    end,
  },
  {
    'miversen33/netman.nvim',
    config = function()
      -- https://github.com/miversen33/netman.nvim
      local netman = require('netman')
    end
  },
  {
    'derekwyatt/vim-fswitch',
    config = function()
      -- Switch between header and implementation (e.g., .h <-> .cpp)
      vim.keymap.set('n', '<F4>', ':FSHere<CR>', { silent = true, desc = "Switch header/source" })
    end },
  {
    'mbbill/undotree',
    config = function()
      -- 1. Configuration Globals
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_SplitWidth = 24
      vim.g.undotree_DiffpanelHeight = 12
      vim.g.undotree_DiffAutoOpen = 1
      vim.g.undotree_SetFocusWhenToggle = 1

      -- Tree Shapes
      vim.g.undotree_TreeNodeShape = ''
      vim.g.undotree_TreeVertShape = ''
      vim.g.undotree_TreeSplitShape = '󰁜'
      vim.g.undotree_TreeReturnShape = '󱦵'

      -- UI Preferences
      vim.g.undotree_RelativeTimestamp = 1
      vim.g.undotree_HighlightChangedText = 1
      vim.g.undotree_HighlightChangedWithSign = 1
      vim.g.undotree_HelpLine = 1
      vim.g.undotree_CursorLine = 1

      -- 2. Keymap
      vim.keymap.set('n', '<C-u>', vim.cmd.UndotreeToggle, {
        silent = true,
        desc = "Toggle Undotree"
      })
    end
  },
  {
    'preservim/tagbar',
    config = function()
      -- State tracking (Local to this block, no globals needed)
      local tagbar_open = false

      local function toggle_tagbar()
        -- 1. Check if we need to toggle Treesitter Context
        local has_context = package.loaded['treesitter-context']

        if not tagbar_open then
          vim.cmd('TagbarOpen')
          tagbar_open = true

          if has_context then
            vim.cmd('TSContext disable')
          end
        else
          vim.cmd('TagbarClose')
          tagbar_open = false

          if has_context then
            vim.cmd('TSContext enable')
          end
        end
      end

      -- Register the keymap
      vim.keymap.set('n', '<C-t>', toggle_tagbar, {
        silent = true,
        desc = "Toggle between Tagbar and TSContext"
      })
    end
  },

  -- ==========================================
  -- TELESCOPE & FUZZY FINDING
  -- ==========================================
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('user.configs.telescope')
    end
  },
  { 'Pagliacii/fzf-lua', build = ':FzfLua setup_fzfvim_cmds' },
  {
    'barrett-ruth/http-codes.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require('telescope')

      telescope.setup({
        extensions = {
          http = {
            -- Default OS-based opener is usually sufficient,
            -- but you can specify 'open_url' here if needed.
          }
        }
      })

      -- Load the extension
      telescope.load_extension('http')

      -- Register the keymap
      vim.keymap.set('n', "<Space>H", telescope.extensions.http.list, {
        silent = true,
        desc = "Open HTTP status code list in telescope.",
        noremap = true
      })
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- "smart_case", "ignore_case" or "respect_case"
                                            -- the default case_mode is "smart_case"
          }
        }
      })
      telescope.load_extension('fzf')
    end
  },
  {
    'xiyaowong/telescope-emoji.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require('telescope')

      telescope.setup({
        extensions = {
          emoji = {
            action = function(emoji)
              -- emoji is a table: {name="", value="", category="", description=""}
              -- Insert emoji directly at the cursor
              vim.api.nvim_put({ emoji.value }, 'c', false, true)
            end,
          }
        }
      })

      -- Load the extension
      telescope.load_extension('emoji')

      -- Register the keymap
      vim.keymap.set('n', "<Space>E", telescope.extensions.emoji.emoji, {
        silent = true,
        desc = "Open emoji list in telescope.",
        noremap = true
      })
    end
  },
  {
    'ghassan0/telescope-glyph.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require('telescope')

      telescope.setup({
        extensions = {
          glyph = {
            action = function(glyph)
              -- Insert the glyph character directly at the cursor
              vim.api.nvim_put({ glyph.value }, 'c', false, true)
            end
          }
        }
      })

      -- Load the extension
      telescope.load_extension('glyph')

      -- Register the keymap
      vim.keymap.set('n', "<Space>G", telescope.extensions.glyph.glyph, {
        silent = true,
        desc = "Open glyph list in telescope.",
        noremap = true
      })
    end
  },
  {
    'nat-418/telescope-color-names.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local telescope = require('telescope')

      -- Setup extension (empty table since you use defaults)
      telescope.setup({
        extensions = {
          color_names = {}
        }
      })

      -- Load the extension
      telescope.load_extension('color_names')

      -- Register the keymap
      vim.keymap.set('n', "<Space>C", telescope.extensions.color_names.color_names, {
        silent = true,
        desc = "Open color name list in telescope.",
        noremap = true
      })
    end
  },
  -- ==========================================
  -- TREESITTER & SYNTAX
  -- ==========================================
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('user.configs.treesitter')
    end,
    dependencies = {

    }
  },
  { 'nvim-treesitter/nvim-treesitter-context', dependencies = 'nvim-treesitter/nvim-treesitter', config = function() require('user.configs.treesitter-context') end },
  { 'windwp/nvim-ts-autotag', dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'guns/xterm-color-table.vim' },

  -- ==========================================
  -- GIT
  -- ==========================================
  { 'tpope/vim-fugitive' },
  {
    'rbong/vim-flog',
    dependencies = 'tpope/vim-fugitive',
    config = function()
      -- https://github.com/rbong/vim-flog/
      -- Mappings for Flog Git Graph
      vim.keymap.set('n', '<M-g>', ':Flogsplit<CR>', { silent = true, desc = "Open Flog Git Graph" })
      vim.keymap.set('n', '<C-g>', ':vertical Floggit<CR>', { silent = true, desc = "Open Vertical Flog" })
    end
  },
  {
    'chrisbra/changesPlugin',
    init = function()
      vim.g.changes_autocmd = 1
      vim.g.changes_vcs_check = 1
      vim.g.changes_vcs_system = ''
      vim.g.changes_diff_preview = 0
      vim.g.changes_respect_SignColumn = 1
      vim.g.changes_linehi_diff = 0
      vim.g.changes_sign_text_utf8 = 1

      -- Set NerdFont icons
      vim.g.changes_add_sign = ' '
      vim.g.changes_delete_sign = ' '
      vim.g.changes_modified_sign = ' '
      vim.g.changes_utf8_add_sign = ' '
      vim.g.changes_utf8_delete_sign = ' '
      vim.g.changes_utf8_modifed_sign = ' '
    end,
    config = function()
      -- Source the file that contains ToggleChangesDiffMode() and the Highlights
      local path = vim.fn.stdpath('config') .. '/lua/user/configs/changesplugin.vim'
      vim.cmd('source ' .. path)
    end
  },

  -- ==========================================
  -- DEBUGGING (DAP)
  -- ==========================================
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- 1. REPL Highlights
      {
        'LiadOz/nvim-dap-repl-highlights',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
          -- https://github.com/LiadOz/nvim-dap-repl-highlights
          require('nvim-dap-repl-highlights').setup()
          require('nvim-treesitter.config').setup({ ensure_installed = { 'dap_repl' }})
        end
      },

      -- 2. UI Stack
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function() require('user.configs.nvim_dap_ui') end
      },

      -- 3. Virtual Text
      {
        'theHamsta/nvim-dap-virtual-text',
        config = function() require('user.configs.nvim_dap_virtual_text') end
      },

      -- 4. Persistent Breakpoints
      {
        'Weissle/persistent-breakpoints.nvim',
        config = function() require('user.configs.nvim_dap_persistent_breakpoints') end
      },

      -- 5. Language Specific (Python)
      {
        'mfussenegger/nvim-dap-python',
        config = function() require('dap-python').setup('/usr/bin/python') end
      },

      -- 6. Telescope Integration (The Extension)
      {
        'nvim-telescope/telescope-dap.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function()
          local telescope = require('telescope')
          telescope.setup({
            extensions = {
              dap = { layout_strategy = "vertical" }
            }
          })
          telescope.load_extension('dap')

          -- Keymaps for DAP + Telescope
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { silent = true, noremap = true, desc = desc })
          end
          map("<Leader>lb", telescope.extensions.dap.list_breakpoints, "DAP Breakpoints")
          map("<Leader>dv", telescope.extensions.dap.variables, "DAP Variables")
          map("<Leader>df", telescope.extensions.dap.frames, "DAP Frames")
          map("<Leader>dc", telescope.extensions.dap.commands, "DAP Commands")
          map("<Leader>dC", telescope.extensions.dap.configurations, "DAP Configurations")
        end
      }
    },
    config = function()
      require('user.configs.nvim_dap')
    end
  },
  -- ==========================================
  -- SPECIALIZED TOOLS
  -- ==========================================
  { 'vim-scripts/DoxygenToolkit.vim' },
  { 'honza/vim-snippets' },
  { 'jmcantrell/vim-virtualenv' },
  { 'tpope/vim-dadbod', dependencies = { {'kristijanhusak/vim-dadbod-ui', config = function() require('user.configs.dadbodui') end} } },
  {
    'vim-test/vim-test',
    dependencies = { 'tpope/vim-dispatch' },
    init = function()
      -- Use 'init' for vim-test variables so they are available
      -- before the plugin's commands are triggered.
      vim.g['test#strategy'] = "dispatch"
    end,
    config = function()
      -- local map = vim.keymap.set
      -- map('n', '<Leader>tn', ':TestNearest<CR>', { silent = true, desc = "Test Nearest" })
      -- map('n', '<Leader>tf', ':TestFile<CR>', { silent = true, desc = "Test File" })
      -- map('n', '<Leader>ts', ':TestSuite<CR>', { silent = true, desc = "Test Suite" })
      -- map('n', '<Leader>tl', ':TestLast<CR>', { silent = true, desc = "Test Last" })
      -- map('n', '<Leader>tg', ':TestVisit<CR>', { silent = true, desc = "Test Visit" })
    end
  },
  { 'RaafatTurki/hex.nvim', config = function() require('user.configs.hexeditor') end },
  { 'sindrets/winshift.nvim', config = function() require('user.configs.winshift') end },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("user.configs.chatgpt")
    end,
  }
})

-- Fallback options
local has_hex, _ = pcall(require, "hex")

if not has_hex then
    local fallback = vim.fn.stdpath('config') .. '/lua/user/configs/hexeditor.vim'
    if vim.fn.filereadable(fallback) == 1 then
        vim.cmd('source ' .. fallback)
    end
end

-- =============================================================================
-- Options

-- set terminal title to reflect current file
vim.opt.title = true

-- Directory for swap and backup files
-- Trailing `//` makes sure full file locations are saved in the file name.
local swp_path = vim.fn.expand('~/.vim/swp//')
make_protected_dir(swp_path)
vim.opt.directory = swp_path
vim.opt.swapfile = true

local backup_path = vim.fn.expand('~/.vim/backup//')
make_protected_dir(backup_path)
vim.opt.backupdir = backup_path
vim.opt.backup = true

local undo_path = vim.fn.expand('~/.vim/undo//')
make_protected_dir(undo_path)
vim.opt.undodir = undo_path
vim.opt.undofile = true

vim.opt.showcmd    = true      -- Show (partial) command in status line.
vim.opt.showmatch  = true      -- Show matching brackets.
vim.opt.ignorecase = true      -- Do case insensitive matching
vim.opt.smartcase  = true      -- Do smart case matching
vim.opt.incsearch  = true      -- Incremental search, shows partial matches
vim.opt.autowrite  = true      -- Automatically save before commands like :next and :make
vim.opt.hidden     = true      -- Hide buffers when they are abandoned
vim.opt.mouse      = "a"       -- Enable mouse usage (all modes)

vim.opt.showtabline = 2        -- force showing tabline

-- Set conceal options
-- 0 - normal
-- 1 - each block is replaced by a single char, or whitespace if none is defined
-- 2 - text is replaced by a defined char, hidden if non defined
-- 3 - text is just concealed always, even if a replacement char is defined
vim.opt.conceallevel = 2
-- The modes in which the cursor line can still conceal stuff. visual is all
-- visually marked characters. any combination of
-- v (visual), n (normal), i (insert) and c (command)
vim.opt.concealcursor = "nc"

-- Highlight Whitespaces
vim.opt.list = true

local chars = {
  tab = "<->",              -- xy[z], x always, then y as many as will fit, then z as the last char to show
  lead = "-",               -- leading spaces
  leadmultispace = "|-->",  -- multiple leading spaces that are as wide as the string
  trail = "·",              -- trailing spaces
  extends = ">",            -- when wrapped is off, this will be displayed at the right edge of the screen if the text overflows
  precedes = "<",           -- same as extends, but on the left
}

-- Conditional EOL character based on terminal
if os.getenv("TERM") == "xterm-kitty" then
  chars.eol = '↵'
else
  chars.eol = "$"
end

vim.opt.listchars = chars

-- Enable spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- :help spellfile.vim
-- Download spell info from http://ftp.vim.org/pub/vim/runtime/spell/
-- Put it into runtimepath (~/.vim/spell/)
-- To download it automatically, only with NETRW
vim.g.spellfile_URL = "http://ftp.vim.org/vim/runtime/spell"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.synmaxcol = 2048        -- Stop syntax highlighting after this many characters on a single line (eg minified js, etc)

vim.opt.wildmenu = true         -- Enable command autocompletion to be a menu
vim.opt.confirm = true          -- Ask user to save instead of failing command to quit
vim.opt.lazyredraw = true       -- Do not update display while executing macros
vim.opt.showmode = true         -- Shows the current mode in the last line
vim.opt.wrapscan = true         -- wrap around while searching
vim.opt.cmdheight = 2           -- command line height
vim.opt.emoji = true            -- Smartly allocate 2 cells for emojis
vim.opt.ambiwidth = "single"    -- East Asian Width Class Ambiguous (special characters) take a single cell only.

vim.opt.showtabline = 2         -- show tabline 0: never, 1: if tab open (default), 2: always

-- The width of the sign column (used for example to display file changes and git status, etc)
vim.opt.signcolumn = "auto:1-3"

-- Allow backspacing over autoindent, line breaks and start of insert action
vim.opt.backspace = { "indent", "eol", "start" }

-- Allow cursor to wrap lines when moving left or right
-- See :help whichwrap
vim.opt.whichwrap:append("<,>,[,],h,l")

-- Stop certain movements from always going to the first character of a line.
vim.opt.startofline = false

--------------------------------------------------------------------------------
-- Statusline
local statusline = ""
statusline = statusline .. "%f"                   -- File Name
statusline = statusline .. " %m"                  -- Modifiable [+] or [-]
statusline = statusline .. " %r"                  -- Readonly [RO] or nothing
statusline = statusline .. " Line: %l/%L[%p%%]"   -- Line: CurLine/LastLine[Percent%]
statusline = statusline .. " Col: %c"             -- Current column
statusline = statusline .. " Buf: #%n"            -- Current buffer number
statusline = statusline .. " [%b][0x%B]"          -- current character under cursor

vim.opt.statusline = statusline

vim.opt.history = 1000 -- History size

-- Indentation settings
-- Do not change 'tabstop' from its default value of 8 with this setup.
vim.opt.shiftwidth = 4      -- Indent using 4 spaces
vim.opt.softtabstop = 4     -- Inserts tabstop number of spaces when tab is pressed
vim.opt.smarttab = true     -- Indent by shiftwidth at start of line, otherwise softtabstop
vim.opt.expandtab = true    -- Converts tabs to spaces

-- keep cursor off the edge when scrolling
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 10

-- highlight current line with "CursorLine" and "CursorLineNr"
vim.opt.cursorline = true

-- Wrap long lines
vim.opt.linebreak = true

-- allow selection of virtual text (ie empty space at end of line is treated as spaces, for example for multi line edits) in block mode
vim.opt.virtualedit = "block"

--------------------------------------------------------------------------------
-- Folding
vim.opt.foldenable = true

-- Auto open folds in these conditions
vim.opt.foldopen = { "block", "insert", "jump", "mark", "percent", "quickfix", "search", "tag", "undo" }

-- Custom Fold Text Function
function _G.MyFoldText()
    local line = vim.fn.getline(vim.v.foldstart)
    local n_lines = 1 + vim.v.foldend - vim.v.foldstart
    -- Remove fold markers like /* */ or {{{1
    local sub = vim.fn.substitute(line, [[/\*\|\*/\|{{{\d\=]], '', 'g')
    return vim.v.folddashes .. sub .. ' (' .. n_lines .. ' Lines)'
end

-- Use Treesitter for folding (Neovim native)
-- https://www.reddit.com/r/neovim/comments/16xz3q9/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldtext=v:lua.vim.treesitter.foldtext()
vim.opt.foldtext = "v:lua.MyFoldText()"

-- Fold Levels and Constraints
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldnestmax = 5           -- Only fold up to this many nested levels.
vim.opt.foldminlines = 1          -- Only fold if there are at least this many lines.
vim.opt.fillchars = { fold = "·", foldopen = "", foldclose = "" }

-- =============================================================================
-- Autocmds

-- Go back to line last edited when re-opening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 1 and last_pos <= vim.fn.line("$") then
      vim.cmd('normal! g\'"')
    end
   end,
})

-- clear replaces autocmd!
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
  group = numbertoggle,
  pattern = "*",
  callback = function()
    -- lua uses 1 based indexing
    if vim.fn.getbufinfo('%')[1].listed == 1 or vim.bo.buftype == 'help' then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    group = numbertoggle,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = false
    end,
})

-- automatically remove whitespace from certain file types
local whitespace_grp = vim.api.nvim_create_augroup("AutoremoveWhitespace", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = whitespace_grp,
    pattern = { "*.py", "*.c", "*.cpp", "*.h", "*.hpp", "*.lua", "*.vim" },
    callback = function()
        -- Check if trailing whitespace exists to avoid unnecessary 'undo' history entries
        if vim.fn.search([[\s\+$]], "nw") ~= 0 then
            local save_cursor = vim.fn.getpos(".")
            vim.cmd([[silent! %s/\s\+$//e]]) -- this might move the cursor
            vim.fn.setpos(".", save_cursor)
        end
    end,
})


-- =============================================================================
-- Colors

-- vim.api.nvim_set_hl(globalNs, "Name", {opts})
-- globalNs: almost always 0. others for specific buffers or floating windows an the like.
-- Name: same as vim
-- opts: attributes as follows
-- Colors (hex string (eg "#FFFFFF", can also be "NONE")): fg (str), bg(str), sp(str) ctermfg/ctermbg(number[0..255])
-- Text Styles (Boolean): bold, italic, underline, undercurl, underdouble, underdotted, underdashed, strikethrough, inverse (swap fg/bg), nocombine (don't combine with other highlights)
-- Logic: link(str) sets the same highlight as the given other highlight, default(bool) if set true the highlight only acts as a fallback if it was not defined before yet.

vim.opt.termguicolors = true

vim.cmd("syntax on")
vim.opt.background = "dark"

-- Right column marker
vim.opt.colorcolumn = "121" -- string because can accept multiple comma separated
vim.api.nvim_set_hl(0, "ColorColumn", { underdashed = true, sp = "#FF0000", ctermbg = 1, bg = "NONE", default = true })

-- Make Whitespace (listchars) less pronounced
-- For which highlight group goes where, check the end of ":help listchars"
vim.api.nvim_set_hl(0, "NonText", { bold = true, ctermfg=244, fg = "#808080" })
vim.api.nvim_set_hl(0, "SpecialKey", { link = "NonText" })

-- Do not have pink background for completion menues and ALE error/warning popups
-- Main text - Light gray on very dark gray
vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = 236, bg = "#303030", ctermfg = 248, fg = "#A8A8A8" })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })

-- Selected text - light yellow on even darker gray
vim.api.nvim_set_hl(0, "PmenuSel", { ctermbg = 235, bg = "#262626", ctermfg = 228, fg = "#FFFF87", underline = true })
-- Scrollbar - gray
vim.api.nvim_set_hl(0, "PmenuSbar", { ctermbg = 243, bg = "#767676" })
-- Scrollbar thumb - lighter than medium gray
vim.api.nvim_set_hl(0, "PmenuThumb", { ctermbg = 250, bg = "#BCBCBC" })

vim.api.nvim_set_hl(0, "FloatBorder", { ctermbg = 237, bg = "#3A3A3A", ctermfg = 248, fg = "#A8A8A8" })
vim.api.nvim_set_hl(0, "FloatTitle", { ctermbg = 234, bg = "#1C1C1C", ctermfg = 11, fg = "#FFFF00", bold = true })

-- Spelling
vim.api.nvim_set_hl(0, "SpellBad", { ctermbg = 198, ctermfg = "NONE", undercurl = true, sp = "#ff0087" })

-- Diagnostics
-- Error
vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = 9, fg = "#FF0000" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { ctermfg = 9, ctermbg = 235, fg = "#FF0000", bg = "#262626", underdotted = true, sp = "#444444" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { link = "DiagnosticError" })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermfg = 9, ctermbg = 234, bold = true, fg = "#FF0000", bg = "#1C1C1C" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#FF0000" })

-- Warning
vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 208, fg = "#FF8700" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { ctermfg = 208, ctermbg = 235, fg = "#FF8700", bg = "#262626", underdotted = true, sp = "#444444" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { link = "DiagnosticWarn" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermfg = 208, ctermbg = 234, bold = true, fg = "#FF8700", bg = "#1C1C1C" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#FF8700" })

-- Info
vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 27, fg = "#005FFF" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { ctermfg = 27, ctermbg = 235, fg = "#005FFF", bg = "#262626", underdotted = true, sp = "#444444" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { link = "DiagnosticInfo" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermfg = 27, ctermbg = 234, bold = true, fg = "#005FFF", bg = "#1C1C1C" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underdotted = true, sp = "#005FFF" })

-- Hint
vim.api.nvim_set_hl(0, "DiagnosticHint", { ctermfg = 14, fg = "#00FFFF" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { ctermfg = 6, ctermbg = 235, fg = "#008080", bg = "#262626", underdotted = true, sp = "#444444" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { link = "DiagnosticHint" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { ctermfg = 14, ctermbg = 234, bold = true, fg = "#00FFFF", bg = "#1C1C1C" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underdotted = true, sp = "#00FFFF" })

-- Ok
vim.api.nvim_set_hl(0, "DiagnosticOk", { ctermfg = 10, fg = "#00FF00" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextOk", { ctermfg = 10, ctermbg = 235, fg = "#00FF00", bg = "#262626", underdotted = true, sp = "#444444" })
vim.api.nvim_set_hl(0, "DiagnosticFloatingOk", { link = "DiagnosticOk" })
vim.api.nvim_set_hl(0, "DiagnosticSignOk", { ctermfg = 10, ctermbg = 234, bold = true, fg = "#00FF00", bg = "#1C1C1C" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineOk", { underdotted = true, sp = "#00FF00" })

-- Other
vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { strikethrough = true, underdotted = true, sp = "#00FFFF" })
vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { ctermfg = 238, fg = "#444444" })

-- Highlight search results
vim.opt.hlsearch = true
vim.api.nvim_set_hl(0, "Search", { ctermfg = 0, fg = "NONE", bg = "NONE", ctermbg = 11, bold = true, underdashed = true, sp = "#FFFF00" })

-- Folds
vim.api.nvim_set_hl(0, "Folded", { ctermfg = 14, ctermbg = 236, underdouble = true, sp = "#008080", fg = "#00FFFF", bg = "#303030" })

-- Left margin column
vim.api.nvim_set_hl(0, "SignColumn", { ctermfg = 51, ctermbg = 234, fg = "#00FFFF", bg = "#1C1C1C" })
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = 11, ctermbg = 234, fg = "#FFFF00", bg = "#1C1C1C" })

-- Current line marker
vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 236, bg = "#303030", ctermfg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLineNr", { ctermfg = 11, ctermbg = 234, bold = true, fg = "#FFFF00", bg = "#1C1C1C" })

-- =============================================================================
-- Key mappings

-- alias for fold current cursor position for convenience
vim.keymap.set("n", "zz", "za", { silent = true })

-- Map Y to yank until EOL (standardizes Y with D and C)
vim.keymap.set("", "Y", "y$")

-- Command-line abbreviations
-- Allow saving of files as sudo when I forgot to start vim using sudo.
vim.cmd([[
    cnoreabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
]])
-- When typing help on the command line, expand to :vertical help automatically
vim.cmd([[
    cnoreabbrev help vertical help
]])

-- Clear search highlights and close quickfix/location lists with <C-L>
vim.keymap.set("", "<C-L>", ":nohl<CR>:cclose<CR>:lclose<CR><C-L>", { silent = true })

-- Clipboard interactions (System Clipboard vs Primary Selection)
vim.keymap.set("", "<Leader>y", '"+y')
vim.keymap.set("", "<Leader>p", '"+p')
vim.keymap.set("", "<Leader>Y", '"*y')
vim.keymap.set("", "<Leader>P", '"*p')

-- Ctrl-C to copy (Normal and Visual modes)
vim.keymap.set("n", "<C-C>", '"+yy')
vim.keymap.set("v", "<C-C>", '"+y')

-- Ctrl-V to paste in Insert and Command modes using register +
vim.keymap.set({ "i", "c" }, "<C-V>", "<C-r>+")

-- Select all text
vim.keymap.set("n", "<C-a>", "gg<S-v><S-g>", { silent = true })

-- Switch buffers with Alt + Left/Right
vim.keymap.set("", "<M-Left>", ":bprevious<CR>", { silent = true })
vim.keymap.set("", "<M-Right>", ":bnext<CR>", { silent = true })

-- Close buffer with Ctrl-W (Note: this overrides the default window-command prefix)
vim.keymap.set("n", "<C-W>", ":bdelete<CR>", { silent = true })

-- Highlight Inspection (The "What is this color?" tool)
local function check_highlight()
    local line = vim.fn.line(".")
    local col = vim.fn.col(".")
    local id = vim.fn.synID(line, col, 1)
    local trans_id = vim.fn.synID(line, col, 0)
    local lo_id = vim.fn.synIDtrans(id)

    print(string.format("hi<%s> trans<%s> lo<%s>",
        vim.fn.synIDattr(id, "name"),
        vim.fn.synIDattr(trans_id, "name"),
        vim.fn.synIDattr(lo_id, "name")))
end

-- Keybind and Command for Highlight Inspection
vim.keymap.set("n", "<S-F1>", check_highlight, { silent = true })
vim.api.nvim_create_user_command("CheckHighlight", check_highlight, {})
