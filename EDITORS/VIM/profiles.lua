--[[
     /  /\         /__/\         /  /\         /  /\          ___        ___          /__/\
    /  /:/         \  \:\       /  /:/_       /  /::\        /__/\      /  /\        |  |::\
   /  /:/           \__\:\     /  /:/ /\     /  /:/\:\       \  \:\    /  /:/        |  |:|:\
  /  /:/  ___   ___ /  /::\   /  /:/ /:/_   /  /:/  \:\       \  \:\  /__/::\      __|__|:|\:\
 /__/:/  /  /\ /__/\  /:/\:\ /__/:/ /:/ /\ /__/:/ \__\:\  ___  \__\:\ \__\/\:\__  /__/::::| \:\
 \  \:\ /  /:/ \  \:\/:/__\/ \  \:\/:/ /:/ \  \:\ /  /:/ /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/
  \  \:\  /:/   \  \::/       \  \::/ /:/   \  \:\  /:/  \  \:\|  |:|     \__\::/  \  \:\
   \  \:\/:/     \  \:\        \  \:\/:/     \  \:\/:/    \  \:\__|:|     /__/:/    \  \:\
    \  \::/       \  \:\        \  \::/       \  \::/      \__\::::/      \__\/      \  \:\
     \__\/         \__\/         \__\/         \__\/           ~~~~                   \__\/

	A config switcher written in Lua by NTBBloodbath and Vhyrro.
--]]

-- Defines the profiles you want to use
local profiles = {
	--[[
	Here's an example:

		<name_of_config> = { <path_to_config>, {
				plugins = "packer", -- Where to install plugins under site/pack
				preconfigure = "packer:opt" -- Whether or not to preconfigure a plugin manager for you
			}
		}

	More in-depth information can be found in cheovim's README on GitHub.
	--]]
	rakesh_mth = { "~/workspaces/rakesh-mth/dotfiles/EDITORS/VIM/", {
			plugins = "packer",
			preconfigure = "nil",
		}
	},
    lunar_nvim = { "~/.config/nvim-config/LunarVim", {
            plugins = "packer",
            preconfigure = "lunarvim"
        }
    },
    doom_nvim = { "~/.config/nvim-config/doom-nvim", {
            plugins = "packer",
            setup = function()
                vim.opt.rtp:append(vim.fn.expand("~") .. "/.config/nvim-config/doom-nvim")
                -- vim.fn.delete(vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua")
            end,
            preconfigure = "doom-nvim"
        }
    }
}

-- return <name_of_config>, <list_of_profiles>
-- return "rakesh_mth", profiles
-- return "lunar_nvim", profiles
-- return "doom_nvim", profiles

local default_profile = 'lunar_nvim'

return load_profile or default_profile, profiles

