return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},
}
