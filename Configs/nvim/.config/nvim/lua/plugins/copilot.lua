return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter", 
  opts = {
    panel = {
      enable = true,
      auto_refresh = false,
      keymap = {
      }
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = "<M-Right>",
        next = "<M-]>",
        previous = "<M-[>",
      },
    },
    filetypes = {
      yaml = false,
      markdown = false,
      toml = function() 
        return string.match(vim.api.nvim_buf_get_name(0), "Cargo.toml") ~= nil
      end,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
    }
  },
}
