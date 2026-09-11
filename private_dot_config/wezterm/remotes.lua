local M = {}

function M.apply_to_config(config)
  config.ssh_domains = {
    {
      name = 'cl.vm',
      remote_address = '10.192.112.15',
      username = 'root',
      connect_automatically = true,
    }
  }
  config.unix_domains = {}
end

return M
