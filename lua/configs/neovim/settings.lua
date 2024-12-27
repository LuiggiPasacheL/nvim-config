vim.o.splitright       = true
vim.opt.splitbelow     = true

vim.opt.nu             = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes"
vim.opt.mouse          = 'a'
vim.opt.background     = "dark"
vim.opt.showmode       = false

vim.opt.fillchars      = { fold = " " }
vim.opt.foldmethod     = "indent"
vim.opt.foldenable     = true
vim.opt.foldlevel      = 99

-- On LspAttach enable autoformatting
-- local lspAttachFormat = vim.api.nvim_create_augroup('lsp-attach-format', {})
-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = lspAttachFormat,
--     callback = function(args)
--         local client_id = args.data.client_id
--         local client = vim.lsp.get_client_by_id(client_id)
--         local bufnr = args.buf
--
--         if not client.server_capabilities.documentFormattingProvider then
--             return
--         end
--
--         if client.name == 'tsserver' then
--             return
--         end
--
--         vim.api.nvim_create_autocmd('BufWritePre', {
--             group = lspAttachFormat,
--             buffer = bufnr,
--             callback = function()
--                 vim.lsp.buf.format {
--                     async = false,
--                     filter = function(c)
--                         return c.id == client.id
--                     end,
--                 }
--             end,
--         })
--     end,
-- })

-- Enable treesitter highlight after 100ms vimEnter
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local function f()
            vim.cmd [[TSEnable highlight]]
        end
        vim.defer_fn(f, 100)
    end
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local autosave_buffer = function(output_bufnr, pattern, command)
    vim.api.nvim_create_autocmd("BufWritePost", {
        group = vim.api.nvim_create_augroup("AutoRunOnSave", { clear = true }),
        pattern = pattern,
        callback = function()
            local append_data = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
                end
            end

            vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {})
            vim.fn.jobstart(command, {
                stdout_buffered = true,
                on_stdout = append_data,
                on_stderr = append_data,
            })
        end
    })
end

vim.api.nvim_create_user_command("AutoRunOnSave", function()
    print("AutoRunOnSave starts now...")
    local bufnr = vim.fn.input "Bufnr: "
    local pattern = vim.fn.input "pattern: "
    local command = vim.split(vim.fn.input "command: ", " ")
    autosave_buffer(tonumber(bufnr), pattern, command)
end, {})

vim.g.copilot_assume_mapped = true -- Tab to accept completion
