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
	local rp = util.relative_path()
	local rpef = util.relative_path_ex_name()
	local fns = util.filename_ex_suffix()

	local cmd = ""
	if type == "c" or type == "cpp" then
		cmd = "g++ -o ./bin/" .. fns .. " " .. rp .. " && ./bin/" .. fns
	elseif type == "rust" then
		cmd = "cargo run"
	elseif type == "go" then
		cmd = "go run " .. rp
	elseif type == "sh" or type == "bash" then
		cmd = "bash " .. rp
	elseif type == "zsh" then
		cmd = "zsh " .. rp
	elseif type == "javascript" or type == "typescript" then
		cmd = "node " .. rp
	elseif type == "html" then
		cmd = "surf " .. rp
	elseif type == "proto" then
		cmd = "protoc --proto_path=" .. rpef .. " --go_out=plugins=grpc:" .. rpef .. "/pb " .. rp
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
		runProjectTerm.cmd = M.writeRunProjectCmd()
		if runProjectCmd.cmd == nil or runProjectCmd.cmd == "" then
			vim.notify("Failed to set run project command!")
			return
		end
	end
	runProjectTerm:toggle()
end

-- 添加run project command
function M.writeRunProjectCmd()
	local res = ""
	-- 读取run project command的line number
	local rn = io.popen("cat " .. lf .. " | grep 'local runProjectCmd' -n | awk -F ':' '{print $1}' | head -n 1"):read()
	vim.ui.input({ prompt = "Set Project [" .. util.project_name() .. "] Run Command：" }, function(input)
		if input == nil or input == "" then
			return
		end
		-- 写入 run project command
		vim.cmd(string.format('!sed -i \'%sa\\\t["%s"] = "%s",\' %s', tonumber(rn), util.cwd(), input, lf))
		package.loaded["launcher"] = nil
		res = input
	end)
	return res
end

-- 移除 run project command
function M.removeRunProjectCmd()
	vim.cmd("!sed -i '/" .. string.gsub(util.cwd(), "/", "\\/") .. "/d' " .. lf)
	package.loaded["launcher"] = nil
end

-- 获取 run project command
function M.getRunProjectCmd()
	vim.cmd("!sed -n '/" .. string.gsub(util.cwd(), "/", "\\/") .. "/p' " .. lf)
	package.loaded["launcher"] = nil
end

return M
