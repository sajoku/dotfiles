-- tmux-style bindings, ported from ~/.config/tmux/tmux.conf
--

local P = "ctrl+s>" -- prefix
local TERMINAL = "com.superlogical.terminal"

-- ============================================================
-- PREFIX
-- ============================================================
rex.bind(P .. "ctrl+s", "pane.send_key", { key = "ctrl+s" })

-- ============================================================
-- TABS
-- ============================================================
rex.bind(P .. "c", "client.tab.new")
rex.bind(P .. "p", "client.tab.previous")

for i = 1, 9 do
  rex.bind(P .. tostring(i), "client.tab.goto", { index = i })
end

-- ============================================================
-- PANES
-- ============================================================
rex.bind(P .. "\\", "pane.split", { direction = "right" })
rex.bind(P .. "-", "pane.split", { direction = "down" })
rex.bind(P .. "x", "pane.close")
rex.bind(P .. "z", "pane.zoom")
rex.bind(P .. "f", "pane.zoom")

rex.bind("shift+left", "pane.resize", { direction = "left", amount = 2 })
rex.bind("shift+right", "pane.resize", { direction = "right", amount = 2 })
rex.bind("shift+down", "pane.resize", { direction = "down", amount = 1 })
rex.bind("shift+up", "pane.resize", { direction = "up", amount = 1 })

-- ============================================================
-- SESSIONS
-- ============================================================
rex.bind(P .. "ctrl+j", "session.switch")


-- ============================================================
-- PROGRAMS IN A NEW TAB
-- ============================================================
-- Find a pane in this session whose foreground program is `program`
local function find_block_running(ctx, program)
  local ok, r = pcall(rex.session.list_blocks, {})
  if not ok or type(r) ~= "table" then return nil end

  for _, b in ipairs(r.blocks or r) do
    local id = b.block_id or b.id
    local ok2, p = pcall(rex.block.call, TERMINAL, "process", {
      session_id = ctx.session_id,
      block_id   = id,
    })
    if ok2 and type(p) == "table" and p.foreground and p.foreground.name == program then
      return id
    end
  end
end

-- Working directory of the pane the action was started from
local function pane_cwd(ctx)
  local ok, r = pcall(rex.block.call, TERMINAL, "pwd", {
    session_id = ctx.session_id,
    block_id   = ctx.block_id,
  })
  if not ok or not r then return nil end
  local pwd = type(r) == "table" and r.pwd or r
  if type(pwd) ~= "string" then return nil end
  -- strip a file://hostname prefix if present
  return (pwd:gsub("^file://[^/]*", ""))
end

--open a new tab. used together with shortcuts from my tmux
local function run_in_tab(name, title, command, cwd, reuse)
  rex.action {
    name  = name,
    title = title,
    run   = function(ctx, args)
      if reuse then
        local id = find_block_running(ctx, command[1])
        if id then
          rex.session.focus_block { block_id = id }
          return
        end
      end

      rex.session.new_window {
        layout = rex.layout.block {
          flavor  = "com.superlogical.terminal.shell",
          options = { command = command, cwd = cwd or pane_cwd(ctx) },
        },
      }
    end,
  }
end

run_in_tab("dotfiles_nvim", "Edit Dotfiles", { "nvim" }, os.getenv("HOME") .. "/dotfiles")
run_in_tab("lazygit", "Lazygit", { "lazygit" }, nil, true)
run_in_tab("scratch_fish", "Scratch Shell", { "/opt/homebrew/bin/fish" })
run_in_tab("btop", "btop", { "btop" }, nil, true)

rex.bind(P .. "ctrl+d", "dotfiles_nvim")
rex.bind(P .. "g", "lazygit")
rex.bind(P .. "ctrl+t", "scratch_fish")
rex.bind(P .. "h", "btop")

-- ============================================================
-- CTRL+H/J/K/L: move between Rex panes and Neovim windows
-- In nvim the key is passed through; nvim hands back to Rex at its edge.
-- ============================================================
local ctrl_bytes = { left = "\8", down = "\10", up = "\11", right = "\12" }

local function runs_vim(ctx)
  local ok, p = pcall(rex.block.call, TERMINAL, "process", {
    session_id = ctx.session_id,
    block_id   = ctx.block_id,
  })
  if not ok or type(p) ~= "table" or not p.foreground then return false end
  local name = p.foreground.name or ""
  return name == "nvim" or name == "vim"
end

rex.action {
  name  = "nav",
  title = "Navigate Pane (vim-aware)",
  args  = { direction = "string" },
  run   = function(ctx, args)
    if runs_vim(ctx) then
      rex.block.call(TERMINAL, "write", {
        session_id = ctx.session_id,
        block_id   = ctx.block_id,
        args       = { data = ctrl_bytes[args.direction] }, -- check arg name: rex api describe com.superlogical.terminal.write
      })
    else
      rex.session.focus_direction { block_id = ctx.block_id, direction = args.direction }
    end
  end,
}

for key, dir in pairs { h = "left", j = "down", k = "up", l = "right" } do
  rex.bind("ctrl+" .. key, "nav", { direction = dir })
end
