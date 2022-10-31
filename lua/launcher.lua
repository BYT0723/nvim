local M = {}

local util = require("util")

local lf = "~/.config/nvim/lua/launcher.lua"

local runProjectCmd = {
	-- run project command
}

local function runFileCmd(type)
	local rp = util.relativeFilePath()
	local rpef = util.relativeFilePathExcludeFilename()
	local fns = util.filenameExcludeSuffix()

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

local Terminal = require("toggleterm.terminal").Terminal

function NewTerm(cmd)
	return Terminal:new({
		cmd = cmd,
		direction = "horizontal", -- vertical / horizontal / tab / float
		close_on_exit = false,
		auto_scroll = true,
	})
end

function M.runFile()
	local cmd = runFileCmd(vim.bo.filetype)
	NewTerm(cmd):toggle()
end

function M.runProject()
	local cmd = runProjectCmd[util.cwd()]
	if cmd == nil then
		cmd = M.writeRunProjectCmd()
	end
	NewTerm(cmd):toggle()
end

function M.writeRunProjectCmd()
	local res = ""
	-- 读取run project command的line number
	local rn = io.popen("cat " .. lf .. " | grep 'local runProjectCmd' -n | awk -F ':' '{print $1}' | head -n 1"):read()
	vim.ui.input({ prompt = "Set Project [" .. util.projectName() .. "] Run Command：" }, function(input)
		if input == nil or input == "" then
			vim.cmd("silent echom 'set run project command failed !'")
			return
		end
		-- 写入 run project command
		vim.cmd(string.format('!sed -i \'%sa\\\t["%s"] = "%s",\' %s', tonumber(rn), util.cwd(), input, lf))
		package.loaded["launcher"] = nil
		res = input
	end)
	return res
end

function M.removeRunProjectCmd()
	-- 移除 run project command
	vim.cmd("!sed -i '/" .. string.gsub(util.cwd(), "/", "\\/") .. "/d' " .. lf)
	package.loaded["launcher"] = nil
end

function M.getRunProjectCmd()
	-- 获取 run project command
	vim.cmd("!sed -n '/" .. string.gsub(util.cwd(), "/", "\\/") .. "/p' " .. lf)
	package.loaded["launcher"] = nil
end

return M
