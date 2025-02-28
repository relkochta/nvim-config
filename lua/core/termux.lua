return {
    is_termux = function()
        if (vim.fn.getenv("TERMUX_VERSION") ~= "" and
            vim.fn.isdirectory("/data/data/com.termux/files/usr") == 1) then
            return true
        end

        return false
    end,
} 
