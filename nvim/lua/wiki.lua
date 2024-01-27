vim.g.vimwiki_list = {
  {
    path = '~/WorkDocs/wiki/',
    name = 'My Wiki',
  }
}
vim.g.vimwiki_global_ext = 0

local export_path = '~/WorkDocs/generated'

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
    args = {
      bufpath,
      '--output', string.format("%s.docx", bufname),
      '--standalone',
      '--to=docx',
      '--from=vimwiki',
      '--number-sections',
      '--highlight-style=/Users/glimsdal/WorkDocs/syntax-highlight.theme',
      '--reference-doc=/Users/glimsdal/Amazon WorkDocs Drive/My Documents/custom-reference.docx',
    },
    cwd = Path:new(export_path):normalize(),
    -- env = { PATH = vim.env.PATH },
    on_exit = function(j, return_val)
      vim.inspect.inspect(j:result())
      print(return_val)
    end,
    on_stdout = function(_, line)
      print(line)
    end,
    on_stderr = function(_, line)
      print(line)
    end
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
