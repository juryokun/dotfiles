local api = require "nvim-tree.api"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local M = {}

local view_selection = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    local filename = selection.filename or selection[1]
    local lnum = selection.lnum

    if filename then
      vim.cmd("tabedit " .. vim.fn.fnameescape(filename))
      if lnum then
        vim.api.nvim_win_set_cursor(0, { lnum, 0 })
      end
    end
  end)
  return true
end

function M.launch_live_grep(opts)
  return M.launch_telescope("live_grep", opts)
end

function M.launch_find_files(opts)
  return M.launch_telescope("find_files", opts)
end

function M.launch_telescope(func_name, opts)
  local telescope_status_ok, _ = pcall(require, "telescope")
  if not telescope_status_ok then
    return
  end

  local node = api.tree.get_node_under_cursor()
  if not node or not node.absolute_path then
    vim.notify("No valid node under cursor", vim.log.levels.WARN)
    return
  end

  local is_folder = node.fs_stat and node.fs_stat.type == "directory" or false
  local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
  if node.name == ".." and TreeExplorer ~= nil then
    basedir = TreeExplorer.cwd
  end

  opts = opts or {}
  opts.cwd = basedir
  opts.search_dirs = { basedir }
  opts.attach_mappings = view_selection
  return require("telescope.builtin")[func_name](opts)
end

return M
