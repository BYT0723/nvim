vim.g.floaterm_wintype = "split" -- split / vsplit / float
vim.g.floaterm_width = 0.9 -- 0 ~ 1
vim.g.floaterm_height = 0.3 -- 0 ~ 1
vim.g.floaterm_autoinsert = true -- 打开终端是否自动进入insert模式
vim.g.floaterm_autoclose = 0 -- 0: Always do NOT close floaterm window
-- 1: Close window if the job exits normally, otherwise stay it with messages like [Process exited 101]
-- 2: Always close floaterm window

vim.g.floaterm_position = "botright" -- split {'leftabove', 'aboveleft', 'rightbelow', 'belowright', 'topleft', 'botright'}
-- float {'top', 'bottom', 'left', 'right', 'topleft', 'topright', 'bottomleft', 'bottomright', 'center', 'auto'(at the cursor place)}
