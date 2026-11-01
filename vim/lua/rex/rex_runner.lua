-- Vimux / vim-tmux-runner replacement for Rex.
-- Talks to Rex through the `rex` CLI (rex split / send / send-key / api call).
--
if not vim.env.REX_SESSION then return end

local M = {
  runner = nil,    -- block id of the runner pane
  last_cmd = nil,  -- last command sent with :RexRun
  split = "right", -- right | left | above | below
  ratio = 40,      -- runner size in percent
}

-- ------------------------------------------------------------
-- helpers
-- ------------------------------------------------------------
local function rex(args)
  local r = vim.system(vim.list_extend({ "rex" }, args), { text = true }):wait()
  return r.code == 0, vim.trim(r.stdout or ""), vim.trim(r.stderr or "")
end

local function api(method, params)
  return rex({ "api", "call", "-s", vim.env.REX_SESSION, method, vim.json.encode(params) })
end

local function runner_alive()
  return M.runner ~= nil and (rex({ "block", "inspect", "-b", M.runner }))
end

local function open()
  if runner_alive() then return true end
  local ok, out, err = rex({
    "split", "--json",
    "--split=" .. M.split, "--ratio", tostring(M.ratio),
    "--cwd", vim.fn.getcwd(),
    "--focus=false",
  })
  if not ok then
    vim.notify("rex split failed: " .. err, vim.log.levels.ERROR)
    return false
  end
  M.runner = vim.json.decode(out).block_ids[1]
  return true
end

local function send_text(text)
  if not open() then return end
  rex({ "send", "-b", M.runner, text })
  rex({ "send-key", "-b", M.runner, "enter" })
end

local function key(k)
  if runner_alive() then rex({ "send-key", "-b", M.runner, k }) end
end

-- ------------------------------------------------------------
-- vimux-style
-- ------------------------------------------------------------
function M.run(cmd)
  M.last_cmd = cmd
  send_text(cmd)
end

function M.prompt()
  vim.ui.input({ prompt = "Command? ", default = M.last_cmd }, function(cmd)
    if cmd and cmd ~= "" then M.run(cmd) end
  end)
end

function M.run_last()
  if M.last_cmd then M.run(M.last_cmd) else M.prompt() end
end

function M.interrupt() key("ctrl+c") end

function M.clear() key("ctrl+l") end

function M.close()
  if not runner_alive() then
    M.runner = nil
    return
  end
  key("ctrl+c")
  send_text("exit")
  M.runner = nil
end

-- Jump into the runner (like VimuxInspectRunner / VtrFocusRunner)
function M.focus()
  if runner_alive() then api("session.focus_block", { block_id = M.runner }) end
end

function M.zoom()
  if runner_alive() then api("session.zoom_block", { block_id = M.runner }) end
end

-- ------------------------------------------------------------
-- vim-tmux-runner-style
-- ------------------------------------------------------------
-- Send lines (current line, or a visual range) to the runner, e.g. a REPL
function M.send_lines(line1, line2)
  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
  send_text(table.concat(lines, "\n"))
end

-- Run the current file, based on filetype
local runners = {
  python = "python3 %s",
  ruby = "ruby %s",
  sh = "bash %s",
  fish = "fish %s",
  javascript = "node %s",
  lua = "lua %s",
}

function M.send_file()
  local fmt = runners[vim.bo.filetype]
  if not fmt then
    vim.notify("No runner for filetype " .. vim.bo.filetype, vim.log.levels.WARN)
    return
  end
  vim.cmd("silent write")
  M.run(fmt:format(vim.fn.shellescape(vim.fn.expand("%:p"))))
end

-- Use an existing pane as the runner. In that pane: echo $REX_BLOCK
function M.attach(block_id)
  M.runner = block_id
  if not runner_alive() then
    vim.notify("No Rex block " .. block_id, vim.log.levels.ERROR)
    M.runner = nil
  end
end

-- ------------------------------------------------------------
-- commands
-- ------------------------------------------------------------
local cmd = vim.api.nvim_create_user_command

cmd("RexRun", function(o)
  if o.args == "" then M.prompt() else M.run(o.args) end
end, { nargs = "*", complete = "shellcmd" })
cmd("RexPrompt", M.prompt, {})
cmd("RexRunLast", M.run_last, {})
cmd("RexOpen", open, {})
cmd("RexClose", M.close, {})
cmd("RexInterrupt", M.interrupt, {})
cmd("RexClear", M.clear, {})
cmd("RexFocus", M.focus, {})
cmd("RexZoom", M.zoom, {})
cmd("RexSendLines", function(o) M.send_lines(o.line1, o.line2) end, { range = true })
cmd("RexSendFile", M.send_file, {})
cmd("RexAttach", function(o) M.attach(o.args) end, { nargs = 1 })

-- Old names, so existing mappings keep working inside Rex
local aliases = {
  VimuxRunCommand = "RexRun",
  VimuxPromptCommand = "RexPrompt",
  VimuxRunLastCommand = "RexRunLast",
  VimuxOpenRunner = "RexOpen",
  VimuxCloseRunner = "RexClose",
  VimuxInterruptRunner = "RexInterrupt",
  VimuxClearTerminalScreen = "RexClear",
  VimuxInspectRunner = "RexFocus",
  VimuxZoomRunner = "RexZoom",
  VtrOpenRunner = "RexOpen",
  VtrKillRunner = "RexClose",
  VtrFocusRunner = "RexFocus",
  VtrSendLinesToRunner = "RexSendLines",
  VtrSendFile = "RexSendFile",
  VtrAttachToPane = "RexAttach",
  VtrSendCommandToRunner = "RexRun",
  VtrSendCtrlC = "RexInterrupt",
  VtrClearRunner = "RexClear",
}
for old, new in pairs(aliases) do
  cmd(old, function(o)
    local range = (new == "RexSendLines" and o.range > 0) and (o.line1 .. "," .. o.line2) or ""
    vim.cmd(range .. new .. (o.args ~= "" and (" " .. o.args) or ""))
  end, { nargs = "*", range = true, force = true })
end

return M
