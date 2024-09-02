return {
  'lervag/vimtex',
  event = 'BufRead',
  init = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.latex_view_general_viewer = 'zathura'
    vim.g.vimtex_compiler_progname = 'nvr'
    vim.g.vimtex_quickfix_mode = 0 -- suppress error reporting on save and build
    vim.g.vimtex_mappings_enabled = 0 -- Ignore mappings
    vim.g.vimtex_indent_enabled = 0 -- Auto Indent
    vim.g.tex_flavor = 'latex' -- how to read tex files
    vim.g.tex_indent_items = 0 -- turn off enumerate indent
    vim.g.tex_indent_brace = 0 -- turn off brace indent
    vim.g.vimtex_log_ignore = { -- Error suppression:
      'Underfull',
      'Overfull',
      'specifier changed to',
      'Token not allowed in a PDF string',
    }

    -- Fold settings for latex files
    vim.g.vimtex_fold_enabled = true
  end,
}
