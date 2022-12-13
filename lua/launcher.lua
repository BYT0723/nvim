local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local util = require("util")

local lf = "~/.config/nvim/lua/launcher.lua"

local runProjectCmd = {
	["/home/walter/Workspace/Study/rust/yew-demo"] = "trunk serve",
	["/home/walter/Workspace/Study/rust/rocket-demo"] = "cargo run",
	-- run project command
}

local function runFileCmd(type)
	local relativePath = util.relative_path()
	local relativePathExclueName = util.relative_path_ex_name()
	local filenameExcludeSuffix = util.filename_ex_suffix()

	local cmd = ""
	if type == "c" or type == "cpp" then
		cmd = "g++ -o ./bin/" .. filenameExcludeSuffix .. " " .. relativePath .. " && ./bin/" .. filenameExcludeSuffix
	elseif type == "rust" then
		cmd = "cargo run"
	elseif type == "go" then
		cmd = "go run " .. relativePath
	elseif type == "sh" or type == "bash" then
		cmd = "bash " .. relativePath
	elseif type == "zsh" then
		cmd = "zsh " .. relativePath
	elseif type == "javascript" or type == "typescript" then
		cmd = "node " .. relativePath
	elseif type == "html" then
		cmd = "surf " .. relativePath
		-- elseif type == "proto" then
		-- 	cmd = "protoc --proto_path=" .. relativePathExclueName .. " --go_out=plugins=grpc:" .. relativePathExclueName .. "/pb " .. relativePath
	end
	return cmd
end

local runFileTerm = Terminal:new({ cmd = "", direction = "horizontal", close_on_exit = false, auto_scroll = true })
local runProjectTerm = Terminal:new({ cmd = "", direction = "horizontal", close_on_exit = false, auto_scroll = true })
local tool = Terminal:new({ cmd = "", direction = "tab" })

function M.toolToggle(cmd)
	tool.cmd = cmd
	tool.dir = vim.fn.getcwd()
	tool:toggle()
end

-- run file
function M.runFile()
	runFileTerm.cmd = runFileCmd(vim.bo.filetype)
	runFileTerm:toggle()
end

-- run project cmd
function M.runProject()
	runProjectTerm.cmd = runProjectCmd[util.cwd()]
	if runProjectTerm.cmd == nil then
		M.editRunProjectCmd()
		runProjectCmd.cmd = runProjectCmd[util.cwd()]
		if runProjectCmd.cmd == nil then
			vim.notify("Failed to set run project command!")
			return
		end
	end
	runProjectTerm:toggle()
end

-- 编辑run project command
function M.editRunProjectCmd()
	local cmd = runProjectCmd[util.cwd()]
	vim.ui.input({ prompt = "Project [" .. util.project_name() .. "] Run ==> ", default = cmd }, function(input)
		if input == nil or input == "" then
			return
		end
		-- 写入 run project command
		-- 1. 不存在则Insert
		-- 2. 存在则Update
		if cmd == nil or cmd == "" then
			local lineNum =
				io.popen("cat " .. lf .. " | grep 'local runProjectCmd' -n | awk -F ':' '{print $1}' | head -n 1")
					:read()
			vim.cmd(string.format('!sed -i \'%sa\\\t["%s"] = "%s",\' %s', tonumber(lineNum), util.cwd(), input, lf))
		else
			vim.cmd(
				string.format(
					'!sed -i \'s/\\["%s"\\] = "%s"/\\["%s"\\] = "%s"/1\' %s',
					string.gsub(util.cwd(), "/", "\\/"),
					runProjectCmd[util.cwd()],
					string.gsub(util.cwd(), "/", "\\/"),
					input,
					lf
				)
			)
		end
	end)
	package.loaded["launcher"] = nil
	require("launcher")
end

-- 移除 run project command
function M.removeRunProjectCmd()
	local res = io.popen("sed -i '/" .. string.gsub(util.cwd(), "/", "\\/") .. "/d' " .. lf):close()
	if res then
		print("SUCCESS!")
	else
		print("FAILED!")
	end
	package.loaded["launcher"] = nil
end

-- 获取 run project command
function M.getRunProjectCmd()
	-- local cmd = io.popen("sed -n '/" .. string.gsub(util.cwd(), "/", "\\/") .. "/p' " .. lf):read()
	local cmd = runProjectCmd[util.cwd()]
	if cmd == nil then
		cmd = ""
	end
	print("Project [ " .. util.project_name() .. " ] Run ==> [ " .. cmd .. " ]")
	package.loaded["launcher"] = nil
end

return M
