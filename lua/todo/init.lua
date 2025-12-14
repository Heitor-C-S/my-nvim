local M = {}

local state = {
  buf = -1,
  win = -1,
}

-- ----------------------------
-- Window config
-- ----------------------------
local function create_window_config(title)
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)

  width = math.min(width, 120)
  height = math.min(height, 40)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  return {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
    title = title,
    title_pos = "center",
  }
end

-- ----------------------------
-- Task counter
-- ----------------------------
local function count_tasks(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local total, done = 0, 0

  for _, line in ipairs(lines) do
    if line:match("%[[ xX]%]") then
      total = total + 1
      if line:match("%[[xX]%]") then
        done = done + 1
      end
    end
  end

  return done, total
end

local function update_title(win, buf)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end

  local done, total = count_tasks(buf)
  local title = (" Todo (%d/%d) "):format(done, total)

  vim.api.nvim_win_set_config(win, create_window_config(title))
end

-- ----------------------------
-- Checkbox toggle
-- ----------------------------
local function toggle_checkbox_or_close(win, buf)
  local row = vim.api.nvim_win_get_cursor(win)[1] - 1
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1]

  if not line then
    return
  end

  -- unchecked → checked
  if line:match("%[ %]") then
    line = line:gsub("%[ %]", "[x]", 1)
    vim.api.nvim_buf_set_lines(buf, row, row + 1, false, { line })
    update_title(win, buf)
    return
  end

  -- checked → unchecked
  if line:match("%[[xX]%]") then
    line = line:gsub("%[[xX]%]", "[ ]", 1)
    vim.api.nvim_buf_set_lines(buf, row, row + 1, false, { line })
    update_title(win, buf)
    return
  end

  -- no checkbox → close
  vim.api.nvim_win_hide(win)
end


local function insert_task_below(win, buf)
  local row = vim.api.nvim_win_get_cursor(win)[1]
  vim.api.nvim_buf_set_lines(buf, row, row, false, { "- [ ] " })
  vim.api.nvim_win_set_cursor(win, { row + 1, 6 })
end

-- ----------------------------
-- Toggle Todo window
-- ----------------------------
local function toggle_todo(opts)
  -- Close if already open
  if vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    return
  end

  -- Normalize path
  local filepath = vim.fn.expand(opts.target_file)
  filepath = vim.fs.normalize(filepath)
  filepath = vim.fn.fnamemodify(filepath, ":p")

  -- Get or create buffer
  local buf = vim.fn.bufnr(filepath)
  if buf == -1 then
    buf = vim.fn.bufadd(filepath)
  end

  if not vim.api.nvim_buf_is_loaded(buf) then
    vim.fn.bufload(buf)
  end

  local done, total = count_tasks(buf)
  local title = (" Todo (%d/%d) "):format(done, total)

  -- Open floating window
  local win = vim.api.nvim_open_win(buf, true, create_window_config(title))
  state.buf = buf
  state.win = win

  -- Buffer options
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].filetype = "markdown"
  vim.bo[buf].modifiable = true

  -- Window options
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].cursorline = false
  vim.wo[win].signcolumn = "no"
  vim.wo[win].wrap = true

  -- Transparent background (theme controlled)
  vim.api.nvim_set_option_value(
    "winhighlight",
    "Normal:Normal,FloatBorder:FloatBorder",
    { win = win }
  )

  -- Keymaps
  vim.keymap.set("n", "<Tab>", function()
    toggle_checkbox_or_close(win, buf)
  end, { buffer = buf, silent = true, nowait = true })

  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_hide(win)
  end, { buffer = buf, silent = true, nowait = true })

  
  vim.keymap.set("n", "<leader>nt", function()
    insert_task_below(win, buf)
  end, { buffer = buf, silent = true })

end

-- ----------------------------
-- Setup
-- ----------------------------
function M.setup(opts)
  opts = opts or {}
  opts.target_file = opts.target_file
    or (vim.fn.stdpath("data") .. "/todo.md")

  vim.api.nvim_create_user_command("Todo", function()
    toggle_todo(opts)
  end, {})
end

return M
