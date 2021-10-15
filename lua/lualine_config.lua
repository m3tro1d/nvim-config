require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'everforest',
    component_separators = {'|', '|'},
    section_separators = {},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'FugitiveHead'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  extensions = { 'quickfix', 'fugitive', 'nerdtree' },
})
