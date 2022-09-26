local hop = require("hop")
local hop_hint = require("hop.hint")
local wk = require("which-key")

vim.keymap.set("", "f", function()
  hop.hint_char1({ direction = hop_hint.HintDirection.AFTER_CURSOR, current_line_only = true })
end)

vim.keymap.set("", "F", function()
  hop.hint_char1({ direction = hop_hint.HintDirection.BEFORE_CURSOR, current_line_only = true })
end)

vim.keymap.set("", "t", function()
  hop.hint_char1({ direction = hop_hint.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end)

vim.keymap.set("", "T", function()
  hop.hint_char1({ direction = hop_hint.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end)

wk.register({
  -- Hop
  s = { ":HopChar2MW<cr>", "Hop by two chars" },
  S = { ":HopWordMW<cr>", "Hop words" },
  ["?"] = { ":HopPatternMW<cr>", "Hop pattern" },
}, { silent = true, noremap = true })

hop.setup({ keys = "etovxqpdygfblzhckisuran" })
