local autocmd = vim.api.nvim_create_autocmd
local bo = vim.bo

-- change tab width for some web technologies
autocmd("FileType", {
    pattern = {
        "html",
        "css",
        "scss",
        "javascript*",
        "typescript*",
        "json*",
    },
    callback = function()
        bo.tabstop = 2
        bo.shiftwidth = 2
    end,
})
