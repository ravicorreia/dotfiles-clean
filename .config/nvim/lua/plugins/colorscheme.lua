return {
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        event = "VeryLazy",
        priority = 1000,
        opts = {},
        config = function()
            local tokyo = require("tokyonight")
            tokyo.setup({
                style = "night",
                transparent = true,
                styles = {
                    sidebars = "transparent",
                    floats = "transparent",
                },
            })
        end,
    },
    {
        "rose-pine/neovim",
        -- enable = false,
        name = "rose-pine",
        event = "VeryLazy",
        priority = 250,
        config = function()
            local rose_pine = require("rose-pine")
            rose_pine.setup({
                opt = true,
                variant = "auto", -- auto, main, moon, or dawn
                dark_variant = "main", -- main, moon, or dawn
                dim_inactive_windows = false,
                extend_background_behind_borders = true,

                enable = {
                    terminal = true,
                    legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                    migrations = true, -- Handle deprecated options automatically
                },

                styles = {
                    bold = true,
                    italic = true,
                    transparency = true,
                },

                groups = {
                    border = "muted",
                    link = "iris",
                    panel = "surface",

                    error = "love",
                    hint = "iris",
                    info = "foam",
                    note = "pine",
                    todo = "rose",
                    warn = "gold",

                    git_add = "foam",
                    git_change = "rose",
                    git_delete = "love",
                    git_dirty = "rose",
                    git_ignore = "muted",
                    git_merge = "iris",
                    git_rename = "pine",
                    git_stage = "iris",
                    git_text = "rose",
                    git_untracked = "subtle",

                    h1 = "iris",
                    h2 = "foam",
                    h3 = "rose",
                    h4 = "gold",
                    h5 = "pine",
                    h6 = "foam",
                },

                palette = {
                    -- Override the builtin palette per variant
                    main = {
                        -- gold = "#f2e9e1",
                    },
                },

                highlight_groups = {
                    -- Comment = { fg = "foam" },
                    -- VertSplit = { fg = "muted", bg = "muted" },
                },

                before_highlight = function(group, highlight, palette)
                    -- Disable all undercurls
                    -- if highlight.undercurl then
                    --     highlight.undercurl = false
                    -- end
                    --
                    -- Change palette colour
                    -- if highlight.fg == palette.pine then
                    --     highlight.fg = palette.foam
                    -- end
                end,
            })

            -- vim.cmd("colorscheme rose-pine")
            -- vim.cmd("colorscheme rose-pine-main")
            -- vim.cmd("colorscheme rose-pine-moon")
            -- vim.cmd("colorscheme rose-pine-dawn")
        end,
    },

    {
        "craftzdog/solarized-osaka.nvim",
        -- enable = false,
        -- priority = 1000,
        event = "VeryLazy",
        opts = { transparent = true },
        config = function()
            local osaka = require("solarized-osaka")
            --- @diagnostic disable-next-line: missing-fields
            osaka.setup({
                opt = true,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    -- Background styles. Can be "dark", "transparent" or "normal"

                    floats = "transparent", -- style for floating windows
                },
                sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
                day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
                hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
                dim_inactive = false, -- dims inactive windows
                lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

                --- You can override specific color groups to use other groups or a hex color
                --- function will be called with a ColorScheme table
                -- @param colors ColorScheme
                on_colors = function(colors)
                    colors.bg_statusline = "transparent"
                end,

                --- You can override specific highlights to use other groups or a hex color
                --- function will be called with a Highlights and ColorScheme table
                -- @param highlights Highlights
                -- @param colors ColorScheme
                on_highlights = function(highlights, colors) end,
            })
        end,
    },

    {
        "sainnhe/gruvbox-material",
        -- enable = false,
        event = "VeryLazy",
        config = function()
            vim.g.gruvbox_material_enable_italic = true
            vim.g.gruvbox_material_transparent_background = 2
        end,
    },

    {
        "loctvl842/monokai-pro.nvim",
        name = "monokai-pro",
        event = "VeryLazy",
        priority = 1000,
        opts = {},
        config = function()
            local monokai = require("monokai-pro")
            monokai.setup({
                transparent_background = true,
                terminal_colors = true,
                devicons = true, -- highlight the icons of `nvim-web-devicons`
                styles = {
                    comment = { italic = true },
                    keyword = { italic = true }, -- any other keyword
                    type = { italic = true }, -- (preferred) int, long, char, etc
                    storageclass = { italic = true }, -- static, register, volatile, etc
                    structure = { italic = true }, -- struct, union, enum, etc
                    parameter = { italic = true }, -- parameter pass in function
                    annotation = { italic = true },
                    tag_attribute = { italic = true }, -- attribute of tag in reactjs
                },
                filter = "ristretto", -- classic | octagon | pro | machine | ristretto | spectrum
                -- Enable this will disable filter option
                day_night = {
                    enable = false, -- turn off by default
                    day_filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
                    night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
                },
                inc_search = "background", -- underline | background
                background_clear = {
                    "float_win",
                    "toggleterm",
                    "telescope",
                    "which-key",
                    "renamer",
                    "notify",
                    "nvim-tree",
                    "neo-tree",
                    "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
                }, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
                plugins = {
                    bufferline = {
                        underline_selected = false,
                        underline_visible = false,
                    },
                    indent_blankline = {
                        context_highlight = "default", -- default | pro
                        context_start_underline = false,
                    },
                },
                ------@param c Colorscheme
                ---override = function(c) end,
                ------@param cs Colorscheme
                ------@param p ColorschemeOptions
                ------@param Config MonokaiProOptions
                ------@param hp Helper
                ---override = function(
                ---    cs: Colorscheme,
                ---    p: ColorschemeOptions,
                ---    Config: MonokaiProOptions,
                ---    hp: Helper
                ---)
                ---end,
            })
        end,
    },
}
