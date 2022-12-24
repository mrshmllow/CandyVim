--   /$$$$$$                            /$$           /$$    /$$ /$$$$$$ /$$      /$$
--  /$$__  $$                          | $$          | $$   | $$|_  $$_/| $$$    /$$$
-- | $$  \__/  /$$$$$$  /$$$$$$$   /$$$$$$$ /$$   /$$| $$   | $$  | $$  | $$$$  /$$$$
-- | $$       |____  $$| $$__  $$ /$$__  $$| $$  | $$|  $$ / $$/  | $$  | $$ $$/$$ $$
-- | $$        /$$$$$$$| $$  \ $$| $$  | $$| $$  | $$ \  $$ $$/   | $$  | $$  $$$| $$
-- | $$    $$ /$$__  $$| $$  | $$| $$  | $$| $$  | $$  \  $$$/    | $$  | $$\  $ | $$
-- |  $$$$$$/|  $$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$$   \  $/    /$$$$$$| $$ \/  | $$
--  \______/  \_______/|__/  |__/ \_______/ \____  $$    \_/    |______/|__/     |__/
--                                          /$$  | $$
--                                         |  $$$$$$/
--                                          \______/

-- Welcome to your CandyVim configuration!

-- HINT: This file is reloaded when you save it
-- You might need to reload CandyVim to see some changes

-- Special commands can be found by using your leader key
cvim.leader = "space"

-- Enable or disable light mode
-- You can change on the fly with `:set background=light`, or by editing this file
cvim.darkmode = true

-- Languages and packs you want to work with.
-- Language packs add formatting, auto complete, and code actions
-- Most are disabled by default, so review what languages are available and choose ones that you use
-- HINT: Type `gcc` to toggle comments
cvim.language_packs = {
	"lua",

	-- "rust",
	-- "python",
	-- "bash",

	-- Contains basic web support. HTML, CSS, and JS/TS
	-- "web",

	-- Contains extra support for web technologies
	-- TailwindCSS, Prisma, Vue, Svelte, Eslint, and prettier
	-- "web-extra",

	-- Contains Java and Kotlin
	-- "java",

  -- Contains Godot game engine support
  -- "godot"
}

-- Here you can disable modules that might bother you
-- HINT: Type `gcc` to toggle comments
cvim.enabled_modules = {
	-- Highlight hex codes and LSP colours like this - #f38ba8 #eba0ac #fab387
	-- Useful for TailwindCSS classes
	"colour",

	-- Add snippets
	"luasnip",

	-- Adds git signs
	"git_signs",

	-- Enable code context at the top of the window
	"sticky_context",

	-- Enable "TODO" highlights
	-- You can also search for them in your project with `<leader>fD`
	"todo",

	-- Add easy hopping. Try right now by pressing `s`.
	-- Also replaces other keymaps like `f` and `t`
	"hop",
}
