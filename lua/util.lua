local M = {}

-- help filename-modifiers

function M.cwd()
	return vim.fn.getcwd()
end

function M.projectName()
	return vim.fn.fnamemodify(M.cwd(), ":t")
end

function M.absoluteFilePath()
	return vim.api.nvim_buf_get_name(0)
end

function M.relativeFilePath()
	return vim.fn.fnamemodify(M.absoluteFilePath(), ":.")
end

function M.relativeFilePathExcludeFilename()
	return vim.fn.fnamemodify(M.absoluteFilePath(), ":h")
end

function M.filename()
	return vim.fn.fnamemodify(M.absoluteFilePath(), ":t")
end

function M.filenameExcludeSuffix()
	return vim.fn.fnamemodify(M.absoluteFilePath(), ":t:r")
end

function M.toggleQuickfix()
	local id = vim.fn.getqflist({ winid = 1 }).winid
	if id > 0 then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

return M
