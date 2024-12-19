local BufData = {
	buf = -1,
	win = -1,
}

local function CreateWindow(PreviusBuf)
	local width = math.floor(vim.o.columns * .8)
	local height = math.floor(vim.o.lines * .8)

	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local CREATE_NEW_BUF = not PreviusBuf or not vim.api.nvim_buf_is_valid(PreviusBuf)
	local buf = CREATE_NEW_BUF and vim.api.nvim_create_buf(false, true) or PreviusBuf

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded"
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

local ToggleTerminal = function()
	local CREATE_BUFFER = not vim.api.nvim_win_is_valid(BufData.win)
	if CREATE_BUFFER then
		BufData = CreateWindow(BufData.buf)

		local SETUP_TERMINAL = vim.bo[BufData.buf].buftype ~= "terminal"
		if SETUP_TERMINAL then
			vim.cmd.terminal()
		end

		return
	end

	vim.api.nvim_win_hide(BufData.win)
end

vim.api.nvim_create_user_command("Floaterminal", ToggleTerminal, {})
vim.keymap.set({"n", "t"}, "<leader>tt", ToggleTerminal, {})
