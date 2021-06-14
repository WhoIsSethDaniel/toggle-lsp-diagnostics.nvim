local diagnostic = require 'vim.lsp.diagnostic'

local M = {
  settings = {
    all = true,
    underline = { default = true },
    virtual_text = { default = true },
    signs = { default = true },
    update_in_insert = { default = true }
  }
}

local SETTABLE = { 'underline', 'virtual_text', 'signs', 'update_in_insert' }

function M.init(user_settings)
  local user_settings = user_settings or {}
  for _, setting in ipairs(SETTABLE) do
    if user_settings[setting] ~= nil then
      M.settings[setting].default = user_settings[setting]
    end
    M.settings[setting].value = M.settings[setting].default
  end
  M.configure_diagnostics()
end

function M.current_settings(new_settings)
  local settings = {}
  for _, setting in pairs(SETTABLE) do
    settings[setting] = M.settings[setting].value
  end
  for setting, value in pairs(new_settings) do
    settings[setting] = value
  end
  return settings
end

function M.turn_off_diagnostics()
  M.configure_diagnostics({
    underline = false,
    virtual_text = false,
    signs = false,
    update_in_insert = false
  })
  M.settings.all = false
  M.display_status('all diagnostics are', false)
end

function M.turn_on_diagnostics()
  M.configure_diagnostics(M.current_settings({}))
  M.settings.all = true
  M.display_status('all diagnostics are', true)
end

function M.toggle_diagnostics()
  if  M.settings.all then
    M.turn_off_diagnostics()
  else
    M.turn_on_diagnostics()
  end
end

function M.toggle_diagnostic(name)
  if M.settings.all == false then
    return false
  end
  if type(M.settings[name].default) == 'boolean' then
    M.settings[name].value = not M.settings[name].value
  elseif M.settings[name].value == false then
    M.settings[name].value = M.settings[name].default
  else
    M.settings[name].value = false
  end
  M.display_status(name .. ' is', M.settings[name].value)
  M.configure_diagnostics({ [name] = M.settings[name].value })
  return M.settings[name].value
end

function M.toggle_underline()
  M.toggle_diagnostic('underline')
end
function M.toggle_signs()
  M.toggle_diagnostic('signs')
end
function M.toggle_virtual_text()
  M.toggle_diagnostic('virtual_text')
end
function M.toggle_update_in_insert()
  M.toggle_diagnostic('update_in_insert')
end

function M.configure_diagnostics(settings)
  local conf = M.current_settings(settings or {})
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, conf)
  local buffers = vim.fn.getbufinfo()
  for _, buffer in pairs(buffers) do
    local buffer_id = buffer.bufnr
    for client_id, _ in pairs(vim.lsp.buf_get_clients(buffer_id)) do
      diagnostic.display(nil, buffer_id, client_id, conf)
    end
  end
end

function M.display_status(msg, val)
  if val == false then
    print(string.format("%s off", msg))
  else
    print(string.format("%s on", msg))
  end
end

function M.dump()
  print(vim.inspect(M))
end

return M
