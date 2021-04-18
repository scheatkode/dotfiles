" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/alice/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/alice/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/alice/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/alice/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/alice/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/alice/.local/share/nvim/site/pack/packer/opt/goyo.vim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/gruvbox.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lazygit.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/lazygit.nvim"
  },
  ["lens.vim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/lens.vim"
  },
  ["limelight.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/alice/.local/share/nvim/site/pack/packer/opt/limelight.vim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/lush.nvim"
  },
  ["neoscroll.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-colorizer.lua"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/alice/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["nvim-whichkey-setup.lua"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/nvim-whichkey-setup.lua"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/alice/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-operator-user"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/vim-operator-user"
  },
  ["vim-sandwich"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/vim-sandwich"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-startuptime"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/vim-startuptime"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/vim-which-key"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/alice/.local/share/nvim/site/pack/packer/start/vista.vim"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
