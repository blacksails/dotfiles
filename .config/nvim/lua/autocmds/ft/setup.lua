local M = {}

function M.setup(grp)
    require("autocmds.ft.go").setup(grp)
    require("autocmds.ft.javascript").setup(grp)
    require("autocmds.ft.yaml").setup(grp)
end

return M
