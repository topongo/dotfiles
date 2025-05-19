return {
  'chomosuke/typst-preview.nvim',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
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
