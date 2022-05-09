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

-- rakesh - helper setup function

_G.cheovim_profile_setup = function(selected_profile, profile_path)
    -- helper function to join paths
    local path_sep = vim.loop.os_uname().version:match "Windows" and "\\" or "/"
    function _G.join_paths(...)
      local result = table.concat({ ... }, path_sep)
      return result
    end
    -- no need to delete packer_compiled.lua, since config path will be from current cheovim config.
    -- vim.fn.delete(vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua")
    -- make sure profile_path is in runtimepath for modules to work (ex doom-nvim)
    vim.opt.rtp:append(profile_path)
    -- remove original data/site and data/site/after
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site"))
    vim.opt.rtp:remove(join_paths(vim.fn.stdpath "data", "site", "after"))
    -- these will not work since cheovim will override default config path
    -- default config path needs to be in rtp for cheovim to work correctly.
    -- vim.opt.rtp:remove(vim.fn.stdpath "config")
    -- vim.opt.rtp:remove(join_paths(vim.fn.stdpath "config", "after"))

    -- Clone the current stdpath function definition into an unused func
    vim.fn._stdpath_setup = vim.fn.stdpath
    vim._call_setup = vim.call
    -- query original data path and append selected_profile in the path for new stdpath("data")
    local data_path = join_paths(vim.fn._stdpath_setup("data"), selected_profile)
    vim.opt.rtp:prepend(join_paths(data_path, "site"))
    vim.opt.rtp:append(join_paths(data_path, "site", "after"))
    vim.cmd [[let &packpath = &runtimepath]]
    -- vim.cmd(("echom \"%s\""):format(data_path))

    -- Override vim.fn.stdpath to manipulate the data returned by it. Yes, I know, changing core functions
    -- is really bad practice in any codebase, however this is our only way to make things like doom-nvim etc. work
    vim.fn.stdpath = function(what)
        if what:lower() == "data" then
            return data_path
        elseif what:lower() == "cache" then
            return join_paths(data_path, ".cache")
        elseif what:lower() == "config" then
            return profile_path
        end
        return vim.fn._stdpath_setup(what)
    end
    vim.call = function(...)
      local n = select('#', ...)
      if n == 2 then
        local name = select(1, ...)
        if name:lower() == 'stdpath' then
            local option = select(2, ...)
            if option:lower() == "data" then
                -- vim.cmd(("echom \"%s\""):format(data_path))
                return data_path
            elseif option:lower() == "cache" then
                return join_paths(data_path, ".cache")
            elseif option:lower() == "config" then
                return profile_path
            end
        end
      end
      return vim._call_setup(...)
    end
end

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
    rakesh_mth = { "~/.config/nvim-config/rakesh-mth", {
          plugins = "packer",
          preconfigure = "packer:start",
        }
    },
    svim = { "~/.config/nvim-config/svim", {
          plugins = "packer",
          preconfigure = "packer:start",
        }
    },
    LunarVim = { "~/.config/nvim-config/LunarVim", {
            plugins = "packer",
            setup = function()
              -- cheovim_profile_setup("LunarVim")
            end,
            preconfigure = "lunarvim"
        }
    },
    DoomNvim = { "~/.config/nvim-config/doom-nvim", {
            plugins = "packer",
            setup = function()
              -- cheovim_profile_setup("DoomNvim")
            end,
            preconfigure = "doom-nvim"
        }
    }
}

-- return <name_of_config>, <list_of_profiles>
-- return "rakesh_mth", profiles
-- return "lunar_nvim", profiles
-- return "doom_nvim", profiles

local default_profile = 'LunarVim'
local selected_profile = load_profile or default_profile
cheovim_profile_setup(selected_profile, vim.fn.expand(profiles[selected_profile][1]))
return selected_profile, profiles

