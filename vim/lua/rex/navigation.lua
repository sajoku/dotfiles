if vim.env.REX_SESSION then
  vim.g.tmux_navigator_no_mappings = 1 -- only if you use vim-tmux-navigator

  for key, dir in pairs { h = "left", j = "down", k = "up", l = "right" } do
    vim.keymap.set("n", "<C-" .. key .. ">", function()
      local win = vim.api.nvim_get_current_win()
      vim.cmd("wincmd " .. key)
      if vim.api.nvim_get_current_win() == win then
        vim.system({
          "rex", "api", "call", "-s", vim.env.REX_SESSION, "session.focus_direction",
          vim.json.encode({ block_id = vim.env.REX_BLOCK, direction = dir }),
        })
      end
    end)
  end
end
