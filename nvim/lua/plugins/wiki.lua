vim.g.vimwiki_list = {
  {
    path = '~/Amazon WorkDocs Drive/My Documents/wiki/',
    name = 'My Wiki',
  }
}
vim.g.vimwiki_global_ext = 0

local export_path = '~/Amazon WorkDocs Drive/My Documents/generated'

local M = {}
local api = vim.api

local Job = require 'plenary.job'
local Path = require 'plenary.path'

function M.ConvertToDocx()
  -- Get the full path of the buffer.
  local bufpath = api.nvim_buf_get_name(0)
  local bufname = vim.fn.expand('%:t:r')

  Job:new({
    command = 'pandoc',
    args = { bufpath, '-o', string.format("%s.docx", bufname), '-s', '--to=docx', '--from=vimwiki' },
    cwd = Path:new(export_path):normalize(),
    -- env = { PATH = vim.env.PATH },
    on_exit = function(j, return_val)
      print(return_val)
    end,
  }):sync()

end

function M.ConvertToWiki()
  -- Get the full path of the buffer.
  local bufpath = api.nvim_buf_get_name(0)
  local bufname = vim.fn.expand('%:t:r')

  Job:new({
    command = 'pandoc',
    args = { bufpath, '-o', string.format("%s.xwiki", bufname), '-s', '--to=xwiki', '--from=vimwiki' },
    cwd = Path:new(export_path):normalize(),
    -- env = { PATH = vim.env.PATH },
    on_exit = function(j, return_val)
      print(return_val)
    end,
  }):sync()

end

return M
