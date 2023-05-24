local function proc_file_exists()
  local f = io.open("/proc/version")
  if f then f:close() end
  return f ~= nil
end

local function is_wsl()
  if not proc_file_exists() then return false end
  for line in io.lines("/proc/version") do
    if string.match(line, "microsoft") then
      return true
    end
  end
  return false
end

if not is_wsl() then
  return
end

vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ['+'] = "clip.exe",
    ['*'] = "clip.exe",
  },
  paste = {
    ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
