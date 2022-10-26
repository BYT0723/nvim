local M = {}

local util = require("util")

local lf = "~/.config/nvim/lua/launcher.lua"

-- path
local rp = util.relativeFilePath()
local rpef = util.relativeFilePathExcludeFilename()
local fns = util.filenameExcludeSuffix()

local runFileCmd = {
	["c"] = "gcc -o ./bin/" .. fns .. " " .. rp .. " && ./bin/" .. fns,
	["cpp"] = "g++ -o ./bin/" .. fns .. " " .. rp .. " && ./bin/" .. fns,
	["rust"] = "cargo run",
	["go"] = "go run " .. rp,
	["python"] = "python " .. rp,
	["sh"] = "bash " .. rp,
	["zsh"] = "zsh " .. rp,
	["javascript"] = "node " .. rp,
	["typescript"] = "node " .. rp,
	["html"] = "surf " .. rp,
	["proto"] = "protoc --proto_path=" .. rpef .. " --go_out=plugins=grpc:" .. rpef .. "/pb " .. rp,
	-- run file command
}
local runProjectCmd = {
	-- run project command
}

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
	local cmd = runFileCmd[vim.bo.filetype]
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
