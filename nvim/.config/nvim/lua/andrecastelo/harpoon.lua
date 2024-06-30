local mark = require("harpoon.mark")
local action_state = require("telescope.actions.state")

M = {}

M.mark_file = function(tb)
    local picker = action_state.get_current_picker(tb)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection >= 1 then
        require("telescope.pickers").on_close_prompt(tb)
        -- pcall(vim.api.nvim_set_current_win, picker.original_win_id)
        pcall(vim.api.nvim_win_set_cursor, 0, picker.original_win_id)
        for i, entry in ipairs(multi_selection) do
            local filename

            if entry.path or entry.filename then
                filename = entry.path or entry.filename
                mark.add_file(filename)
            end
        end
    end
end

return M
