return {
    entry = function()
        local output = Command("git"):arg("status"):stderr(Command.PIPED):output()
        if output.stderr ~= "" then
            ya.notify({
                title = "lazygit",
                content = "Not in a git directory\nError: " .. output.stderr,
                level = "warn",
                timeout = 5,
            })
        else
<<<<<<< HEAD
            permit = ui.hide()
            local output, err_code = Command("lazygit"):stdin(Command.INHERIT):stdout(Command.INHERIT):stderr(Command.PIPED):spawn()
            if output and not err_code then
                output, err_code = output:wait_with_output()
            end
=======
            permit = ya.hide()
            local output, err_code = Command("lazygit"):stderr(Command.PIPED):output()
>>>>>>> parent of 430a96e (fix: replace deprecated ya.hide() with ui.hide())
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
