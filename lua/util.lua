local M = {}

-- help filename-modifiers

function M.cwd()
	return vim.fn.getcwd()
end

function M.project_name()
	return vim.fn.fnamemodify(M.cwd(), ":t")
end

function M.absolute_path()
	return vim.api.nvim_buf_get_name(0)
end

function M.relative_path()
	return vim.fn.fnamemodify(M.absolute_path(), ":.")
end

function M.relative_path_ex_name()
	return vim.fn.fnamemodify(M.absolute_path(), ":h")
end

function M.filename()
	return vim.fn.fnamemodify(M.absolute_path(), ":t")
end

function M.filename_ex_suffix()
	return vim.fn.fnamemodify(M.absolute_path(), ":t:r")
end

function M.toggle_quickfix()
	local id = vim.fn.getqflist({ winid = 1 }).winid
	if id > 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

function M.source_luafile()
	local path = vim.fn.fnamemodify(M.relative_path(), ":r")
	local res = string.sub(path, string.find(path, "/") + 1, string.len(path))
	package.loaded[res] = nil
	require(res)
end

return M
