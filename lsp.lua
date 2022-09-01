require'lspconfig'.rnix.setup{}
require'lspconfig'.sumneko_lua.setup{}

require'lspconfig'.gopls.setup{}

require'lspconfig'.vuels.setup{}

require'lspconfig'.tsserver.setup{}

require'lspconfig'.ansiblels.setup{}
require'lspconfig'.yamlls.setup{
	settings = {
		yaml = {
		  schemas = {
		    ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
		  },
		},
	}
}

require'lspconfig'.omnisharp.setup{
	cmd = {"/home/user/.vscode/extensions/ms-dotnettools.csharp/.omnisharp/1.37.16/run","--languageserver","--hostPID",tostring(vim.fn.getpid())};
	root_dir = require'lspconfig'.util.root_pattern("*.csproj","*.sln");

}

require'lspconfig'.pyright.setup{}

vim.o.completeopt = "menuone,noselect"

-- set tab to accept autocompletion

local t = function(str)
    return vim.api.nvim_replace_termcodes(str,true,true,true)
end
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i","<Tab>","v:lua.tab_complete()", {expr=true})
vim.api.nvim_set_keymap("s","<Tab>","v:lua.tab_complete()", {expr=true})


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but uniqu identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
