local M = {
  settings = {
    all = true,
    start_on = true,
  },
}

local SETTABLE = vim.tbl_keys(vim.diagnostic.config())

do
  local ok, m = pcall(require, 'vim.diagnostic')
  if ok then
    M.show = function(b, c, conf)
      for ns, _ in pairs(vim.diagnostic.get_namespaces()) do
        m.show(ns, b, nil, conf)
      end
    end
  else
    M.show = function(b, c, conf)
      require('vim.lsp.diagnostic').display(nil, b, c, conf)
    end
  end
end

function M.init(user_settings)
  local user_settings = user_settings or {}
  for _, setting in ipairs(SETTABLE) do
    M.settings[setting] = { default = true }
    if user_settings[setting] ~= nil then
      M.settings[setting].default = user_settings[setting]
    end
    M.settings[setting].value = M.settings[setting].default
  end
  if user_settings['start_on'] ~= nil and not user_settings['start_on'] then
    M.turn_off_diagnostics()
  else
    M.configure_diagnostics()
  end
end

function M.current_settings(new_settings)
  local settings = {}
  for _, setting in pairs(SETTABLE) do
    settings[setting] = M.settings[setting].value
  end
  for setting, value in pairs(new_settings or {}) do
    settings[setting] = value
  end
  return settings
end

function M.turn_off_diagnostics()
  local settings = {}
  for _, setting in ipairs(SETTABLE) do
    settings[setting] = false
  end
  M.configure_diagnostics(settings)
  M.settings.all = false
end

function M.turn_on_diagnostics_default()
  local settings = {}
  for _, setting in ipairs(SETTABLE) do
    settings[setting] = M.settings[setting].default
  end
  M.configure_diagnostics(settings)
  M.settings.all = true
  vim.api.nvim_echo({ { 'all diagnostics are at default' } }, false, {})
end

function M.turn_on_diagnostics()
  local settings = {}
  for _, setting in ipairs(SETTABLE) do
    settings[setting] = true
  end
  M.configure_diagnostics(settings)
  M.settings.all = true
end

function M.toggle_diagnostics()
  if M.settings.all then
    M.turn_off_diagnostics()
  else
    M.turn_on_diagnostics_default()
  end
  M.display_status('All diagnostics are', M.settings.all)
end

function M.toggle_diagnostic(name)
  if type(M.settings[name].default) == 'boolean' then
    M.settings[name].value = not M.settings[name].value
  elseif M.settings[name].value == false then
    M.settings[name].value = M.settings[name].default
  else
    M.settings[name].value = false
  end
  M.display_status(name .. ' is', M.settings[name].value)
  M.configure_diagnostics { [name] = M.settings[name].value }
  return M.settings[name].value
end

function M.toggle_underline()
  M.toggle_diagnostic 'underline'
end
function M.toggle_signs()
  M.toggle_diagnostic 'signs'
end
function M.toggle_virtual_text()
  M.toggle_diagnostic 'virtual_text'
end
function M.toggle_update_in_insert()
  M.toggle_diagnostic 'update_in_insert'
end

-- for nvim 0.5 - 0.6.1
local configure_diagnostics_05 = function(conf)
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, conf)
  local clients = vim.lsp.get_active_clients()
  for client_id, _ in pairs(clients) do
    local buffers = vim.lsp.get_buffers_by_client_id(client_id)
    for _, buffer_id in ipairs(buffers) do
      M.show(buffer_id, client_id, conf)
    end
  end
end

-- for nvim 0.7 and beyond (may also work with 0.6.1 but can't test :()
local configure_diagnostics_07 = function(conf)
  vim.diagnostic.config(conf)
end

function M.configure_diagnostics(settings)
  local conf = M.current_settings(settings or {})
  if vim.fn.has 'nvim-0.7' then
    configure_diagnostics_07(conf)
  else
    configure_diagnostics_05(conf)
  end
end

function M.display_status(msg, val)
  if val == false then
    vim.notify(string.format('%s off', msg), vim.log.levels.INFO)
  else
    vim.notify(string.format('%s on', msg), vim.log.levels.INFO)
  end
end

function M.dump()
  print(vim.inspect(M))
end

return M
