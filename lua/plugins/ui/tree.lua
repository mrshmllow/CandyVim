local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local git_add = function()
	local node = lib.get_node_at_cursor()
	local gs = node.git_status

	-- If the file is untracked, unstaged or partially staged, we stage it
	if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
		vim.cmd("silent !git add " .. node.absolute_path)

	-- If the file is staged, we unstage
	elseif gs == "M " or gs == "A " then
		vim.cmd("silent !git restore --staged " .. node.absolute_path)
	end

	lib.refresh_tree()
end

local function collapse_all()
	require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
	-- open as vsplit on current node
	local action = "edit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
		view.close() -- Close the tree if file was opened
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
		view.close() -- Close the tree if file was opened
	end
end

local function vsplit_preview()
	-- open as vsplit on current node
	local action = "vsplit"
	local node = lib.get_node_at_cursor()

	-- Just copy what's done normally with vsplit
	if node.link_to and not node.nodes then
		require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
	elseif node.nodes ~= nil then
		lib.expand_or_collapse(node)
	else
		require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
	end

	-- Finally refocus on tree if it was lost
	view.focus()
end

require("nvim-tree").setup({
	open_on_setup = true,
	hijack_unnamed_buffer_when_opening = true,
	hijack_cursor = true,
	create_in_closed_folder = true,
	sync_root_with_cwd = true,
	renderer = {
		root_folder_modifier = ":~",
		highlight_git = true,
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = "after",
			glyphs = {
				git = {
					unstaged = "",
					staged = "",
					deleted = "", -- Should i use ﮁ ?
					ignored = "",
					unmerged = "",
					renamed = "ﯽ",
					untracked = "",
				},
			},
		},
	},
	filters = {
		custom = {
			"^.git$",
			".candy_modules.lock",
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		debounce_delay = 50,
	},
	view = {
		mappings = {
			custom_only = false,
			list = {
				{ key = "ga", action = "git_add", action_cb = git_add },
				{ key = "l", action = "edit", action_cb = edit_or_open },
				{ key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
				{ key = "h", action = "close_node" },
				{ key = "H", action = "collapse_all", action_cb = collapse_all },
				{ key = "K", action = "toggle_file_info" },
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
})
