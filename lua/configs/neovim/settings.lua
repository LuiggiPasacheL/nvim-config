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

-- On LspAttach enable autoformatting
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp-attach-format', { clear = true }),
    callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        if not client.server_capabilities.documentFormattingProvider then
            return
        end

        if client.name == 'tsserver' then
            return
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
            group = 'lsp-attach-format',
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format {
                    async = false,
                    filter = function(c)
                        return c.id == client.id
                    end,
                }
            end,
        })
    end,
})



vim.g.copilot_assume_mapped = true -- Tab to accept completion
