local get_cwd = ya.sync(function()
    local tab, path = cx.active, ""
    if tab.current.hovered then
        path = tostring(tab.current.hovered.url)
    end
    local pattern1 = "^(.+)//"
    local pattern2 = "^(.+)\\"
    if string.match(path, pattern1) == nil then
        return string.match(path, pattern2)
    else
        return string.match(path, pattern1)
    end
end)

return {
    entry = function()
        local cwd = get_cwd()
        local output = Command("git"):arg("status"):cwd(cwd):stderr(Command.PIPED):output()
        if output.stderr ~= "" then
            ya.notify({
                title = "lazygit",
                content = "Not in a git directory",
                level = "warn",
                timeout = 5,
            })
        else
            permit = ya.hide()
            local output, err_code = Command("lazygit"):stderr(Command.PIPED):output()
            if err_code ~= nil then
                ya.notify({
                    title = "Failed to run lazygit command",
                    content = "Status: " .. err_code,
                    level = "error",
                    timeout = 5,
                })
            elseif not output.status.success then
                ya.notify({
                    title = "lazygit in" .. cwd .. "failed, exit code " .. output.status.code,
                    content = output.stderr,
                    level = "error",
                    timeout = 5,
                })
            end
        end
    end,
}