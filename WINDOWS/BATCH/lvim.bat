REM using cheovim - choose lunar_nvim config. Not used because some folder (after) has conflict.
REM start "" nvim-qt.exe --no-ext-tabline -- --cmd "lua load_profile='lunar_nvim'"

REM This can be used but needs changes in the lvim.ps1 script or some more symlinks.
REM Powershell.exe -executionpolicy remotesigned -File  %USERPROFILE%\.config\nvim-config\LunarVim\utils\bin\lvim.ps1

set LUNARVIM_RUNTIME_DIR=%USERPROFILE%\AppData\Local\nvim-data\LunarVim
set LUNARVIM_CACHE_DIR=%USERPROFILE%\AppData\Local\nvim-data\LunarVim\.cache
set LUNARVIM_CONFIG_DIR=%USERPROFILE%\.config\nvim-config\LunarVim
start "" nvim-qt.exe --no-ext-tabline -- -u %USERPROFILE%\.config\nvim-config\LunarVim\init.lua
