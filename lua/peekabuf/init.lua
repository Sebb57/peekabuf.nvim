local M = {}

function M.setup(opts)
    local Config = require("peekabuf.config")
    if opts then
        for k, v in pairs(vim.tbl_deep_extend("force", Config, opts)) do
            Config[k] = v
        end
    end
    if (not opts or opts.default_keybind) then
        vim.keymap.set(
            "n",
            "<leader>md",
            ":lua require('peekabuf.viewer').peekabuf(vim.api.nvim_get_current_buf())<CR>",
            { noremap = true, silent = true, desc = "Open Markdown Viewer" }
        )
        vim.keymap.set(
            "n",
            "<leader>mp",
            ":lua require('peekabuf.viewer').close()<CR>",
            { noremap = true, silent = true, desc = "Close Markdown Viewer" }
        )
    end
end

return M
