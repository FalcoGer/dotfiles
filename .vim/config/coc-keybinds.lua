-- keybinds for coc, so it has descriptions

vim.keymap.set('i', '<TAB>', 'CocTab()', { expr = true, silent = true, desc = "COC - Tab complete" })
vim.keymap.set('i', '<S-TAB>', 'CocSTab()', { expr = true, silent = true, desc = "COC - Previous completion" })
vim.keymap.set('i', '<CR>', 'CocEnter()', { expr = true, silent = true, desc = "COC - Select completion/Enter" })

vim.keymap.set('i', '<C-Space>', 'coc#refresh()', { silent = true, expr = true, desc = "COC - Show autocomplete." })

-- Use `[g` and `]g` to navigate diagnostics
vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true, desc = "COC - Diagnostics prev" })
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true, desc = "COC - Diagnostics next" })
vim.keymap.set('n', '<C-Up>', '<Plug>(coc-diagnostic-prev)', { silent = true, desc = "COC - Diagnostics prev" })
vim.keymap.set('n', '<C-Down>', '<Plug>(coc-diagnostic-next)',
    { silent = true, desc = "COC - Diagnostics next" })

-- GoTo code navigation
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true, desc = "COC - Go to definition" })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true, desc = "COC - Go to type definition" })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true, desc = "COC - Go to implementation" })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true, desc = "COC - Go to references" })

-- Use K to show documentation in preview window
vim.keymap.set('n', 'K', ':call ShowDocumentation()<CR>', { silent = true, desc = "COC - Show documentation" })

-- Symbol renaming
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true, desc = "COC - Rename symbol" })

-- Formatting selected code
vim.keymap.set({ 'x', 'n' }, '<leader>f', '<Plug>(coc-format-selected)',
    { silent = true, desc = "COC - Format selected code" })
vim.keymap.set('n', '<leader>ff', '<Plug>(coc-format)', { silent = true, desc = "COC - Format entire buffer" })

-- Applying code actions to the selected code block
-- Example: `<leader>aap` for current paragraph
vim.keymap.set({ 'x', 'n' }, '<leader>a', '<Plug>(coc-codeaction-selected)',
    { silent = true, desc = "COC - Code actions on selected code" })

-- Remap keys for applying code actions at the cursor position
vim.keymap.set('n', '<C-Space>', '<Plug>(coc-codeaction-cursor)',
    { silent = true, desc = "COC - Apply code actions at the cursor position" })
vim.keymap.set('x', '<C-Space>', '<Plug>(coc-codeaction-selected)',
    { silent = true, desc = "COC - Apply code actions to selected code" })
vim.keymap.set('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)',
    { silent = true, desc = "COC - Apply code actions at the cursor position" })
vim.keymap.set('n', '<leader>ca', '<Plug>(coc-codeaction-cursor)',
    { silent = true, desc = "COC - Apply code actions at the cursor position" })

-- Remap keys for apply code actions affect whole buffer
vim.keymap.set('n', '<leader>as', '<Plug>(coc-codeaction-source)',
    { silent = true, desc = "COC - Apply code actions affecting whole buffer" })

-- Apply the most preferred quickfix action to fix diagnostic on the current line
vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)',
    { silent = true, desc = "COC - Apply quickfix action to fix diagnostic on the current line" })

-- Remap keys for applying refactor code actions
vim.keymap.set('n', '<leader>re', '<Plug>(coc-codeaction-refactor)',
    { silent = true, desc = "COC - Apply refactor code actions" })
vim.keymap.set({ 'x', 'n' }, '<leader>r', '<Plug>(coc-codeaction-refactor-selected)',
    { silent = true, desc = "COC - Apply refactor code actions" })
vim.keymap.set('x', '<S-Space>', '<Plug>(coc-codeaction-refactor-selected)',
    { silent = true, desc = "COC - Apply refactor code actions" })
vim.keymap.set('n', '<S-Space>', '<Plug>(coc-codeaction-refactor)',
    { silent = true, desc = "COC - Apply refactor code actions" })

-- Run the Code Lens action on the current line
vim.keymap.set('n', '<leader>cl', '<Plug>(coc-codelens-action)',
    { silent = true, desc = "COC - Run Code Lens action on the current line" })

-- Map function and class text objects
vim.keymap.set({ 'x', 'o' }, 'if', '<Plug>(coc-funcobj-i)',
    { silent = true, desc = "COC - Map function and class text objects" })
vim.keymap.set({ 'x', 'o' }, 'af', '<Plug>(coc-funcobj-a)',
    { silent = true, desc = "COC - Map function and class text objects" })
vim.keymap.set({ 'x', 'o' }, 'ic', '<Plug>(coc-classobj-i)',
    { silent = true, desc = "COC - Map function and class text objects" })
vim.keymap.set({ 'x', 'o' }, 'ac', '<Plug>(coc-classobj-a)',
    { silent = true, desc = "COC - Map function and class text objects" })

-- Remap <C-f> and <C-b> to scroll float windows/popups
if vim.fn.has('nvim-0.4.0') or vim.fn.has('patch-8.2.0750') then
    vim.keymap.set({ 'n', 'v' }, '<C-f>', "coc#float#has_scroll() ? coc#float#scroll(1) : '<C-f>'",
        { expr = true, silent = true, nowait = true, desc = "COC - Scroll float windows forward" })
    vim.keymap.set('i', '<C-f>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(1)\\<cr>" : "\\<Right>"',
        { silent = true, expr = true, nowait = true, desc = "COC - Scroll forward through floating window" })
    vim.keymap.set({ 'n', 'v' }, '<C-b>', "coc#float#has_scroll() ? coc#float#scroll(0) : '<C-b>'",
        { expr = true, silent = true, nowait = true, desc = "COC - Scroll float windows backward" })
    vim.keymap.set('i', '<C-b>', 'coc#float#has_scroll() ? "\\<c-r>=coc#float#scroll(0)\\<cr>" : "\\<Left>"',
        { silent = true, expr = true, nowait = true, desc = "COC - Scroll backwards through floating window." })
end

-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
vim.keymap.set({ 'n', 'x' }, '<C-s>', '<Plug>(coc-range-select)',
    { silent = true, desc = "COC - Use CTRL-S for selections ranges" })

-- Mappings for CocList
vim.keymap.set('n', '<space>l', ':<C-u>CocList<CR>',
    { silent = true, nowait = true, desc = "COC - Show CocList" })
vim.keymap.set('n', '<space>a', ':<C-u>CocList diagnostics<CR>',
    { silent = true, nowait = true, desc = "COC - Show all diagnostics" })
vim.keymap.set('n', '<space>e', ':<C-u>CocList extensions<CR>',
    { silent = true, nowait = true, desc = "COC - Manage extensions" })
vim.keymap.set('n', '<space>c', ':<C-u>CocList commands<CR>',
    { silent = true, nowait = true, desc = "COC - Show commands" })
vim.keymap.set('n', '<space>o', ':<C-u>CocList outline<CR>',
    { silent = true, nowait = true, desc = "COC - Find symbol of current document" })
vim.keymap.set('n', '<space>s', ':<C-u>CocList -I symbols<CR>',
    { silent = true, nowait = true, desc = "COC - Search workspace symbols" })
vim.keymap.set('n', '<space>j', ':<C-u>CocNext<CR>',
    { silent = true, nowait = true, desc = "COC - Do default action for next item" })
vim.keymap.set('n', '<space>k', ':<C-u>CocPrev<CR>',
    { silent = true, nowait = true, desc = "COC - Do default action for previous item" })
vim.keymap.set('n', '<space>p', ':<C-u>CocListResume<CR>',
    { silent = true, nowait = true, desc = "COC - Resume latest coc list" })
vim.keymap.set('n', '<space>y', ':<C-u>CocList -A yank<CR>',
    { silent = true, nowait = true, desc = "COC - Yank List" })
vim.keymap.set('n', '<C-y>', ':<C-u>CocList -A yank<CR>',
    { silent = true, nowait = true, desc = "COC - Yank List" })
vim.keymap.set('n', '<space>g', ':<C-u>CocList gchunks<CR>',
    { silent = true, nowait = true, desc = "COC - git list" })
