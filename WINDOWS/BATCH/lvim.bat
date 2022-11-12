REM using cheovim - choose lunar_nvim config.
start "" nvim-qt.exe -- --cmd "lua load_profile='LunarVim'"


REM using environment variable and -u option with init.lua in LunarVim
:: set LUNARVIM_RUNTIME_DIR=%USERPROFILE%\AppData\Local\nvim-data\LunarVim
:: set LUNARVIM_CACHE_DIR=%USERPROFILE%\AppData\Local\nvim-data\LunarVim\.cache
:: set LUNARVIM_CONFIG_DIR=%USERPROFILE%\.config\nvim-config\LunarVim
:: start "" nvim-qt.exe --no-ext-tabline -- -u %USERPROFILE%\.config\nvim-config\LunarVim\init.lua


REM This can be used but needs changes in the lvim.ps1 script or some more symlinks.
:: Powershell.exe -executionpolicy remotesigned -File  %USERPROFILE%\.config\nvim-config\LunarVim\utils\bin\lvim.ps1
