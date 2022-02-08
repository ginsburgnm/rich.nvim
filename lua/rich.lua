local api = vim.api
local win, buf

local rich_path = vim.g.rich_path or "rich"
local rich_style = vim.g.rich_style or "material"
local rich_border = vim.g.rich_border
local rich_width = vim.g.rich_width

local M = {}

local function has_value(tab, val)
  for _, value in ipairs(tab) do
    if value == val:lower() then
      return true
    end
  end
  return false
end

local function validate(path, error)

  -- trim and get the full path
  path = string.gsub(path, "%s+", "")
  path = string.gsub(path, "\"", "")
  path = path == "" and "%" or path
  path = vim.fn.expand(path)
  path = vim.fn.fnamemodify(path, ":p")
  local file_exists = vim.fn.filereadable(path) == 1

  -- check if file exists
  if not file_exists then
    if error then
      api.nvim_err_writeln(string.format("file %s does not exist", path))
      return
    else
      return nil
    end
  end

  return path
end

function M.close_window()
  api.nvim_win_close(win, true)
end

-- open_window draws a custom window with the markdown contents
local function open_window(path, options)

  -- window size
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  local win_height = math.ceil(height * 0.8 - 4)
  local win_width = math.ceil(width * 0.8)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  if rich_width and rich_width < win_width then
    win_width = rich_width
  end

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = rich_border or "shadow",
  }

  -- create preview buffer and set local options
  buf = api.nvim_create_buf(false, true)
  win = api.nvim_open_win(buf, true, opts)
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_buf_set_option(buf, "filetype", "richpreview")
  api.nvim_win_set_option(win, "winblend", 0)
  api.nvim_buf_set_keymap(buf, "n", "q", ":lua require('rich').close_window()<cr>",
                          {noremap = true, silent = true})
  api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":lua require('rich').close_window()<cr>",
                          {noremap = true, silent = true})

  vim.fn.termopen(string.format("%s %s --theme %s %s", rich_path, vim.fn.shellescape(path), rich_style, options))
end

function M.rich(file)
  local args={}
  for match in (file..","):gmatch("(.-)"..",") do
    table.insert(args, match);
  end
  local file = ""
  if validate(args[1], false) ~= nil then
    file = table.remove(args, 1)
  end
  local options = table.concat(args, " ")
  local current_win = vim.fn.win_getid()
  if current_win == win then
    M.close_window()
  else
    local path = validate(file, true)
    if path == nil then
      return
    end
    open_window(path, options)
  end
end

return M
