require('lint').linters_by_ft = {
    go = {'golangcilint'},
    cpp = {'cpplint'}
}

vim.api.nvim_create_autocmd({ "BufReadPost", "InsertLeave", "BufWritePost" }, {
    callback = function()
        require('lint').try_lint()
    end
})
