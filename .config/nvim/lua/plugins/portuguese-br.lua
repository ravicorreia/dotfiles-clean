-- Portuguese (Brazil) language support
return {
    -- Add both English and Portuguese spell checking to Neovim
    {
        "LazyVim/LazyVim",
        opts = function()
            -- Set up Portuguese (Brazil) dictionary
            vim.opt.spelllang:append("pt_br")

            -- Create an autocmd to download pt_br spell files if they don't exist
            local pt_br_spl = vim.fn.expand("~/.local/share/nvim/site/spell/pt_br.utf-8.spl")
            local pt_br_sug = vim.fn.expand("~/.local/share/nvim/site/spell/pt_br.utf-8.sug")

            if vim.fn.filereadable(pt_br_spl) == 0 or vim.fn.filereadable(pt_br_sug) == 0 then
                vim.api.nvim_create_autocmd("VimEnter", {
                    callback = function()
                        vim.cmd([[silent! set spelllang+=pt_br]])
                    end,
                    once = true,
                })
            end

            -- By default, Neovim doesn't enable spell checking automatically
            -- I can enable both languages simultaneously with:
            -- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
            --     pattern = { "*.md", "*.txt", "*.tex" },
            --     callback = function()
            --         -- Enable spell checking for these file types with both languages
            --         vim.opt_local.spell = true
            --     end,
            -- })

            -- Add a keybinding to toggle spell checking on/off
            -- vim.keymap.set("n", "<leader>ts", function()
            --     vim.opt_local.spell = not vim.opt_local.spell
            --     if vim.opt_local.spell then
            --         vim.notify("Spell checking enabled (en + pt_br)")
            --     else
            --         vim.notify("Spell checking disabled")
            --     end
            -- end, { desc = "Toggle spell checking (en + pt_br)" })

            -- Add a keybinding to show spell suggestions for word under cursor
            vim.keymap.set({ desc = "Show spelling suggestions" }, "z=", "n")

            -- Add word to both English and Portuguese dictionaries
            -- vim.keymap.set("n", "zg", function()
            --     local original_spelllang = vim.opt_local.spelllang:get()
            --     vim.opt_local.spelllang = { "en", "pt_br" }
            --     vim.schedule(function()
            --         vim.cmd("normal! 1zg")
            --         vim.cmd("normal! 2zg")
            --         vim.opt_local.spelllang = original_spelllang
            --         vim.notify("Word added to en and pt_br dictionaries")
            --     end)
            -- end, { desc = "Add word to en & pt_br dictionaries" })

            -- Remove word from both English and Portuguese dictionaries
            -- vim.keymap.set("n", "zw", function()
            --     local original_spelllang = vim.opt_local.spelllang:get()
            --     vim.opt_local.spelllang = { "en", "pt_br" }
            --     vim.schedule(function()
            --         vim.cmd("normal! 1zw")
            --         vim.cmd("normal! 2zw")
            --         vim.opt_local.spelllang = original_spelllang
            --         vim.notify("Word removed from en and pt_br dictionaries")
            --     end)
            -- end, { desc = "Remove word from en & pt_br dictionaries" })

            -- Add a keybinding to cycle between languages (en -> pt_br -> both)
            -- vim.keymap.set("n", "<leader>tl", function()
            --     local current_lang = vim.opt_local.spelllang:get()
            --     if #current_lang == 1 and current_lang[1] == "en" then
            --         -- Switch to Portuguese only
            --         vim.opt_local.spelllang = "pt_br"
            --         vim.notify("Spell language: Portuguese (Brazil)")
            --     elseif #current_lang == 1 and current_lang[1] == "pt_br" then
            --         -- Switch to both languages
            --         vim.opt_local.spelllang = { "en", "pt_br" }
            --         vim.notify("Spell language: English + Portuguese (Brazil)")
            --     else
            --         -- Switch to English only
            --         vim.opt_local.spelllang = "en"
            --         vim.notify("Spell language: English")
            --     end
            -- end, { desc = "Cycle spell language (en/pt_br/both)" })
        end,
    },

    -- Ensure treesitter supports any Portuguese-specific file types if needed
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                -- There's no specific pt-BR treesitter parser,
                -- but we can make sure all text-related parsers are available
                vim.list_extend(opts.ensure_installed, {
                    "markdown",
                    "markdown_inline",
                    "regex",
                })
            end
        end,
    },
}
