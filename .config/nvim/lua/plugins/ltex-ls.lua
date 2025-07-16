-- Configure ltex-ls for advanced grammar and spell checking with Portuguese support
--
-- This configuration enables ltex-ls for both English (en-US) and Portuguese (pt-BR).
-- It will provide grammar checking for markdown, text, and LaTeX files.
--
-- Usage:
-- - The ltex-ls server will be installed automatically via Mason
-- - Both English and Portuguese grammar checking will be enabled simultaneously
-- - You can add custom words to be ignored in the dictionary sections below
-- - Grammar checking runs on file save by default
return {
    -- Ensure ltex-ls is installed via Mason
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, "ltex-ls")
        end,
    },

    -- Configure ltex-ls LSP settings
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                ltex = {
                    enabled = true,
                    -- Configure ltex-ls for both English and Portuguese (Brazil)
                    settings = {
                        ltex = {
                            -- Set both English and Portuguese (Brazil) as supported languages
                            language = "en-US,pt-BR",

                            -- Disable spell checking since we're already using Neovim's built-in
                            -- spell checker with both languages
                            -- disabledRules = {
                            --     ["en-US"] = { "MORFOLOGIK_RULE_EN_US" },
                            --     ["pt-BR"] = { "MORFOLOGIK_RULE_PT_BR" },
                            -- },

                            -- Define which file types to check
                            -- checkFrequency = "save",

                            -- Additional rule configurations
                            additionalRules = {
                                enablePickyRules = true,
                                -- motherTongue = "pt-BR",
                            },

                            -- Words to ignore (customize as needed)
                            dictionary = {
                                ["en-US"] = {},
                                ["pt-BR"] = {},
                            },

                            -- Add your custom Portuguese words here
                            words = {
                                ["pt-BR"] = {
                                    -- Add common technical terms or names that should be ignored by the spell checker
                                    -- For example: "Neovim", "LazyVim", etc.
                                },
                            },

                            -- Disable specific grammar rules if needed
                            -- hiddenFalsePositives = {
                            --     ["pt-BR"] = {
                            --         -- Add patterns to ignore specific false positives
                            --     },
                            -- },

                            -- Enabled file types
                            enabled = { "latex", "tex", "bib", "markdown", "text" },
                        },
                    },

                    -- Specify filetypes to enable ltex-ls
                    filetypes = { "markdown", "text", "tex", "latex", "bib" },
                },
            },
        },
    },
}
