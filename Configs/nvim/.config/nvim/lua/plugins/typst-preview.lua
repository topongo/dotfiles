return {
  'chomosuke/typst-preview.nvim',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  keys = function()
    local keys = {
      { "<leader>Tpo", "<cmd>TypstPreview<cr>", desc = "Start Typst preview" },
      { "<leader>Tps", "<cmd>TypstPreviewStop<cr>", desc = "Stop Typst preview" },
      { "Tb", "di**<Esc>P", mode = "v", desc = "Make text bold" },
      { "Tt", "di``<Esc>P", mode = "v", desc = "Make text monospace" },
    }

    -- if in thesis directory, add additional keybindings
    if vim.fn.getcwd():match('uni/thesis') then
      local comp = function()
        -- run vim command to compile the thesis
        vim.cmd('!typst compile main.typ')
      end
      table.insert(keys, { "<leader>Tc", function() comp() end, desc = "Compile thesis" })
      table.insert(keys, {
        "<leader>To",
        function()
          comp()
          vim.cmd('!firefox -new-window main.pdf')
        end,
        desc = "Compile and open thesis" })
    end
    return keys
  end,
  opts = {
    open_cmd = 'firefox -new-window -P typst-preview %s',
    get_main_file = function(path_of_buffer)
      -- if path_of_buffer is main.typ, return it, else find the main.typ
      if path_of_buffer:match('main%.typ$') then
        return path_of_buffer
      end
      local dir = vim.fn.fnamemodify(path_of_buffer, ':h')
      while true do
        local main_file = dir .. '/main.typ'
        if vim.fn.filereadable(main_file) == 1 then
          return main_file
        end
        if dir == '/' then
          return path_of_buffer
        end
        dir = vim.fn.fnamemodify(dir, ':h')
      end
    end
  }, -- lazy.nvim will implicitly calls `setup {}`
}
