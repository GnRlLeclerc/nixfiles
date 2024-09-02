return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = { '<leader>ht', '<leader>m', '<leader>M' },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()

    -- Keybindings
    vim.keymap.set('n', '<leader>m', function()
      harpoon:list():add()
    end, { noremap = true, desc = 'Mark file with harpoon' })

    vim.keymap.set('n', '<leader>M', function()
      harpoon:list():remove()
    end, { noremap = true, desc = 'Unmark file with harpoon' })

    -- Use Telescope as a picker
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set('n', '<leader>ht', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })
  end,
}
