-- Использовать файл для хранения истории отмены дейстий
vim.opt.undofile = true

-- Отображать номера строк относительно текущей строки
vim.opt.number = true
vim.opt.relativenumber = false

-- Отображать строки сверху и снизу от курсора при скролле
vim.opt.scrolloff = 7

-- Разбивать длинные строки по словам, а не в середине слова
vim.opt.linebreak = true


-- Поиск --
-- Игнорировать регистр букв при поиске
vim.opt.ignorecase = true

-- Если есть прописная буква, то отключать игнор регистра
vim.opt.smartcase = true


-- Табы --
-- Использовать 4 пробела для табуляции
vim.opt.tabstop = 4

-- Использовать 4 пробела для табуляции при добавлении
vim.opt.softtabstop = 4

-- Использовать 4 пробела при регулирвании отступа с >> <<
vim.opt.shiftwidth = 4

-- В режиме вставки заменять символ табуляции на пробелы
vim.opt.expandtab = true

-- Отображать невидимые символы
vim.opt.list = true
vim.opt.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

-- Языки для проверки правописания (не работает с vim.opt.spelllang)
vim.opt.spelllang = {"ru", "en_us"}

-- При горизонтальном сплите помещать окно снизу
vim.opt.splitbelow = true

-- При вертикальном сплите помещать окно справа
vim.opt.splitright = true

-- Не автокомментировать новые линии при переходе на новую строку
vim.cmd("autocmd BufEnter * set fo-=c fo-=r fo-=o")

-- Русская раскладка
vim.opt.keymap = "russian-jcukenwin"
vim.opt.iminsert = 0
vim.opt.imsearch = 0

-- Системный буфер обмена
vim.opt.clipboard = "unnamedplus"

-- Шрифт для GUI
vim.opt.guifont = { "Hack Nerd Font Mono", ":h12" }

-- Обновлять буфер при фокусе (нужно для отображения изменений в GUI, если файл был изменен в другом приложении)
vim.cmd("autocmd FocusGained * checktime")

-- Отключить свап-файл
vim.opt.swapfile = false

-- Keymaps --
vim.g.mapleader = " "

-- Навигация по сплитам
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>", { silent = true })

-- Смена раскладки
vim.keymap.set({"i", "c"}, "<C-l>", "<C-^>", {silent = true })

-- Переключить проверку орфографии
vim.keymap.set("n", "<leader>s", ":set invspell<CR>", {silent = true })


-- Plugins --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "ellisonleao/gruvbox.nvim", priority = 1000,
    config = function()
      -- setup must be called before loading the colorscheme
      -- Default options:
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = true,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
    end },

  { "EdenEast/nightfox.nvim", lazy = false, priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = true, -- Disable setting background
          terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false, -- Non focused panes set to alternative background
          module_default = true, -- Default enable value for modules
          colorblind = {
            enable = false, -- Enable colorblind support
            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
            severity = {
              protan = 0, -- Severity [0,1] for protan (red)
              deutan = 0, -- Severity [0,1] for deutan (green)
              tritan = 0, -- Severity [0,1] for tritan (blue)
            },
          },
          styles = {
            -- Style to be applied to different syntax groups
            comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = {
            -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })
    end },

  { "nvim-treesitter/nvim-treesitter", enabled = true,
    config = function()
      require 'nvim-treesitter.install'.compilers = { "gcc" }
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "python", "json", "markdown", "markdown_inline", "rust", "bash", "sql", "go", "php"},

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = { },
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
              local max_filesize = 900 * 1024 -- 900 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end },

  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup{
          defaults = {
            mappings = {
              i = {
                    ["<C-l>"] = false
              },
            }
          }
        }
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        vim.keymap.set("n", "<leader>fn", ":cd ~/notes | Telescope find_files<CR>", { silent = true})
    end },

  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',
    config = function()
        require('telescope').load_extension('fzf')
    end },

  { "terrortylor/nvim-comment",
    config = function()
        require("nvim_comment").setup({
          -- Linters prefer comment and line to have a space in between markers
          marker_padding = true,
          -- should comment out empty or whitespace only lines
          comment_empty = true,
          -- trim empty comment whitespace
          comment_empty_trim_whitespace = true,
          -- Should key mappings be created
          create_mappings = true,
          -- Normal mode mapping left hand side
          line_mapping = "gcc",
          -- Visual/Operator mapping left hand side
          operator_mapping = "gc",
          -- text object mapping, comment chunk,,
          comment_chunk_text_object = "ic",
          -- Hook function to call before commenting takes place
          hook = nil,
        })
    end },

  { "lervag/wiki.vim",
    config = function()
      vim.g.wiki_root = '~/notes'
    end },

  { "dhruvasagar/vim-table-mode" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
})


-- Colors
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme gruvbox")

