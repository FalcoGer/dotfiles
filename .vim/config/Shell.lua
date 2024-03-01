-- workaround for lua < 5.2
-- in lua 5.2+ both os.execute and close on a popen handle will return the exit code.
-- this is broken in lua 5.1.

function Shell(cmd)
    if cmd == nil then
        return nil, "No command"
    end

    local fileExitCode = os.tmpname()
    local fileStdout = os.tmpname()

    -- single quotes within single quotes are tricky. Backslashes in single quoted strings are not escape sequences
    -- so we end the single quoted string, then escape the single quote, and then resume the single quoted string
    -- because this is lua, we also need to escape the backslash with a double backslash, so a single backslash ends up in the shell.
    os.execute(string.format("sh -c '" .. cmd:gsub("'", "'\\''") .. "' 1>%s 2>&1 ; echo $? >%s", fileStdout, fileExitCode))

    local handleExitCode = io.open(fileExitCode, "r")
    if handleExitCode == nil then
        os.remove(fileExitCode)
        return nil, "Unable to open exit code file"
    end

    local strExitCode = handleExitCode:read("a*")
    local exitCode = tonumber(strExitCode)
    handleExitCode:close()
    os.remove(fileExitCode)

    local handleStdout = io.open(fileStdout, "r")
    if handleStdout == nil then
        os.remove(fileStdout)
        return exitCode, "Unable to open stdout file"
    end

    local stdout = handleStdout:read("a*")

    handleStdout:close()
    os.remove(fileStdout)

    if stdout == nil then
        stdout = "Output nil"
    end

    return exitCode, stdout
end
