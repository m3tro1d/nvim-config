" Enable mouse only in normal mode
set mouse=n

" Font
if exists(':GuiFont')
  " GuiFont! Iosevka
  GuiFont! FiraCode\ NF:h11
endif

" Disable GUI popupmenu
if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif

" Disable GUI tabline
if exists(':GuiTabline')
  GuiTabline 0
endif
