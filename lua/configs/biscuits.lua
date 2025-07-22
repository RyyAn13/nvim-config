require('nvim-biscuits').setup({
	cursor_line_only = true,
	max_length = 70,
	prefix_string = "  "
})

local ColorName = "lightblue"
vim.api.nvim_set_hl(0, "BiscuitColor", { ctermfg = ColorName, fg = ColorName, blend = 30 })
