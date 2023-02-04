local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- some plugins here
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use 'nvim-lua/popup.nvim' -- An implementation of the Popup API from vim in Neovim
    use 'nvim-lua/plenary.nvim' -- Useful lua functions used by lots of plugins
    use 'akinsho/toggleterm.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'joaomsa/telescope-orgmode.nvim'

    -- Thank you tpope
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'

    -- visual aids
    use 'akinsho/bufferline.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'vim-airline/vim-airline'
    use 'navarasu/onedark.nvim'
    use 'lukas-reineke/indent-blankline.nvim'

    -- debugger
    use 'mfussenegger/nvim-dap'

    -- use 'preservim/tagbar'
    use 'ryanoasis/vim-devicons'
    use {'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
}
    use {'nvim-orgmode/orgmode',
        run = ":TSUpdate org"
}
    -- use 'telescope-orgmode-nvim'

    -- typing aides
    use 'windwp/nvim-autopairs'

    -- Neovim management
    use 'moll/vim-bbye'
    use 'chrisbra/SudoEdit.vim'

    -- git
    use 'lewis6991/gitsigns.nvim'

    -- completions
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'
    -- add more completions plugins under here
    use 'folke/which-key.nvim'

    -- LSP
    use "williamboman/mason.nvim" -- simple to use language server installer
    use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
    use "neovim/nvim-lspconfig" -- enable LSP
    --Linting
    use "jose-elias-alvarez/null-ls.nvim"

    -- snippets
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use 'ledger/vim-ledger'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
