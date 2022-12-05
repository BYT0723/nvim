require("lint").linters_by_ft = {
	c = {
		"cpplint",
		"codespell",
	},
	cpp = {
		"cpplint",
		"codespell",
	},
	go = {
		"golangcilint",
		"codespell",
	},
	javascript = {
		"codespell",
	},
	typescript = {
		"codespell",
	},
	proto = {
		-- "buf",
		"codespell",
	},
	markdown = {
		"codespell",
	},
	vimscript = {
		"vint",
		"codespell",
	},
}

require("lint").linters.buf = {
	cmd = "buf",
	append_fname = true,
	args = { "lint" },
	stream = "stdout",
	ignore_exitcode = true,
	parser = function(output, bufnr)
		local diagnostics = {}
		if output ~= "" then
			local curfile = vim.api.nvim_buf_get_name(bufnr)
			for s in string.gmatch(output, "([^\n]+)") do
				local isError = string.match(s, "error") ~= nil
				local sv = isError and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN
				local regx = isError and "([^:]+):(%d+):(%d+):(.+)" or "([^:]+):(%d+):(%d+):(.+)"
				local file, lnum, col, message = string.match(s, regx)
				if curfile == file then
					table.insert(diagnostics, {
						lnum = lnum,
						col = col,
						severity = sv,
						source = "Buf Lint",
						message = message,
					})
				end
			end
		end
		return diagnostics
	end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
