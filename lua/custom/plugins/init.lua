-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'rest-nvim/rest.nvim',
    -- luarocks/hererocks build (disabled globally in init.lua) would normally
    -- install nvim-nio, mimetypes, xml2lua and fidget.nvim for us. Since it's
    -- disabled, we provide nvim-nio/fidget.nvim as regular plugins below, and
    -- shim xml2lua/mimetypes (plain-Lua rocks with no `lua/` subdir) onto
    -- package.path via their `init` hooks.
    config = function()
      require('rest-nvim').setup {
        request = {
          skip_ssl_verification = true, -- Set to true to skip SSL verification
        },
        -- Add any other rest.nvim specific options here
        -- For example:
        -- result_split_horizontal = false,
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/nvim-nio',
      'j-hui/fidget.nvim',
      {
        'manoelcampos/xml2lua',
        init = function(plugin)
          package.path = plugin.dir .. '/?.lua;' .. package.path
        end,
      },
      {
        'lunarmodules/lua-mimetypes',
        init = function(plugin)
          package.path = plugin.dir .. '/?.lua;' .. package.path
        end,
      },
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, 'http')
      end,
    },
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    'nanozuki/tabby.nvim',
    ---@type TabbyConfig
    opts = {
      -- configs...
    },
  },
  {
    'nanotee/sqls.nvim',
    commit = '2fef377c5bdfc08bc3359a5803e57bdd847468bd',
    event = 'FileType',
    ft = 'sql', -- Load only for SQL file types
    cmd = {
      'SqlsExecuteQuery',
      'SqlsShowConnections',
      'SqlsSwitchConnection',
      'SqlsShowSchemas',
      'SqlsShowDatabases',
    },
  },
  {
    'benoror/gpg.nvim',
  },
  {
    'nickjvandyke/opencode.nvim',
    version = '*', -- Latest stable release
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type for details
      }

      vim.o.autoread = true -- Required for `vim.g.opencode_opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        require('opencode').ask '@this: '
      end, { desc = 'Ask OpenCode…' })
      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        require('opencode').select()
      end, { desc = 'Select OpenCode…' })

      vim.keymap.set({ 'n', 'x' }, 'go', function()
        return require('opencode').operator '@this '
      end, { desc = 'Append range to OpenCode', expr = true })
      vim.keymap.set('n', 'goo', function()
        return require('opencode').operator '@this ' .. '_'
      end, { desc = 'Append line to OpenCode', expr = true })

      vim.keymap.set('n', '<S-C-u>', function()
        require('opencode').command 'session.half.page.up'
      end, { desc = 'Scroll OpenCode up' })
      vim.keymap.set('n', '<S-C-d>', function()
        require('opencode').command 'session.half.page.down'
      end, { desc = 'Scroll OpenCode down' })
    end,
  },
}
