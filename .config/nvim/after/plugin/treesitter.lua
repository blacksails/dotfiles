require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'go', 'gomod', 'gosum', 'yaml' },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
      enable = true
  }
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

parser_config.gotmpl = {
  install_info = {
    url = "https://github.com/ngalaiko/tree-sitter-go-template",
    files = {"src/parser.c"},
  },
  filetype = "gotmpl",
  used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
}

local queries = require('vim.treesitter.query')

queries.set("gotmpl", "injections", '(text) @yaml @combined')
