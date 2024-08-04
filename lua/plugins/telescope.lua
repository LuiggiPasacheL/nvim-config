return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                file_ignore_patterns = {
                    "node_modules",
                    "venv",
                    "virtualenv"
                },
            }
        })

        -- Telescope
        vim.keymap.set('n', "<C-p>", "<CMD>Telescope git_files<cr>")
        vim.keymap.set('n', "<C-f>", "<CMD>Telescope find_files<cr>")
        vim.keymap.set('n', "<C-g>", "<CMD>Telescope live_grep<cr>")
        vim.keymap.set('n', "<C-A-o>", "<CMD>Telescope treesitter<cr>")
        vim.keymap.set('n', "<leader><leader>", "<CMD>Telescope buffers<cr>")
        vim.keymap.set('n', "<leader>o", "<CMD>Telescope treesitter<cr>")
        vim.keymap.set('n', "<leader>t", "<CMD>TodoTelescope<cr>")
        vim.keymap.set('n', "<leader>cc", "<CMD>Telescope colorscheme<cr>")
        vim.keymap.set("n", "<leader>dt", "<CMD>Telescope diagnostics<cr>")
    end,
    cond = Not_vscode()
}
