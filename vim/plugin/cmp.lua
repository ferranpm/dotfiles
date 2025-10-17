local cmp = require('cmp')
local cmp_buffer = require('cmp_buffer')

cmp.setup({
  -- completion = {
  --   keyword_length = 3,
  -- },

  window = {
    documentation = cmp.config.disable
  },

  mapping = cmp.mapping.preset.insert({
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),

  sources = cmp.config.sources(
  {
    { name = 'nvim_lsp' },
  },
  {
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          -- Don't complete buffers that are too large
          local buffers = {}
          for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
            local byte_size = vim.api.nvim_buf_get_offset(buffer, vim.api.nvim_buf_line_count(buffer))
            if byte_size < 1024 * 1024 then -- 1 Megabyte max
              table.insert(buffers, buffer)
            end
          end

          return buffers
        end
      }
    }
  }),

  sorting = {
    comparators = {
      function(...)
        return cmp_buffer:compare_locality(...)
      end,
    }
  }
})

