local wez = require('wezterm')

local M = {}

function M.apply_to_config(config)
  config.hyperlink_rules = wez.default_hyperlink_rules()

  -- Jira issue keys, e.g. DEF-1234.
  table.insert(config.hyperlink_rules, {
    regex = [[\bDEF-(\d{3,})\b]],
    format = 'https://cloudlinux.atlassian.net/browse/DEF-$1',
  })
end

return M
