local Config = require("peekabuf.config")
local peekabuf = {
    buffer = {},
}

local function is_markdown(buf)
    local filepath = vim.api.nvim_buf_get_name(buf)
    if filepath == "" then
        return false
    end
    local ext = vim.fn.fnamemodify(filepath, ":e")
    return ext == "md" or ext == "markdown"
end

local function set_scrollbind(win1, win2)
    vim.api.nvim_set_option_value("scrollbind", true, { win = win1 })
    vim.api.nvim_set_option_value("scrollbind", true, { win = win2 })

    vim.api.nvim_set_option_value("cursorbind", true, { win = win1 })
    vim.api.nvim_set_option_value("cursorbind", true, { win = win2 })
end

function peekabuf.open_buffer(bufnr)
    local current_win = vim.api.nvim_get_current_win()
    if Config.vertical then
        vim.cmd("vsplit")
    else
        vim.cmd("split")
    end
    local new_win = vim.api.nvim_get_current_win()

    vim.api.nvim_win_set_buf(new_win, bufnr)
    set_scrollbind(current_win, new_win)
    peekabuf.buffer = new_win
end

function peekabuf.peekabuf(bufnr)
    if not is_markdown(bufnr) then
        vim.notify("peekabuf: not a markdown file", vim.log.levels.WARN)
        return
    end

    peekabuf.open_buffer(bufnr)
end

function peekabuf.close()
    if peekabuf.buffer and vim.api.nvim_win_is_valid(peekabuf.buffer) then
        vim.api.nvim_win_close(peekabuf.buffer, false)
        peekabuf.buffer = nil
    end
end

return peekabuf
