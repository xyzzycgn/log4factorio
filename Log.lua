--- Created by xyzzycgn.
--- DateTime: 17.01.25 08:45
---


--- defines the log levels
local Log = {
    FATAL  = 8,
    ERROR  = 7,
    WARN   = 6,
    INFO   = 5,
    CONFIG = 4,
    FINE   = 3,
    FINER  = 2,
    FINEST = 1,
}

--- default log level
local DEFAULT = Log.CONFIG

--- actual active log level (severity)
local severity = DEFAULT

local MSG = {
    [Log.FINEST] = "[FINEST] ",
    [Log.FINER]  = "[FINER] ",
    [Log.FINE]   = "[FINE] ",
    [Log.CONFIG] = "[CONFIG] ",
    [Log.INFO]   = "[INFO] ",
    [Log.WARN]   = "[WARN] ",
    [Log.ERROR]  = "[ERROR] ",
    [Log.FATAL]  = "[FATAL] ",
}

---Sets the severity level for logging
---@param sev number The severity level to set
function Log.setSeverity(sev)
    severity = sev
end

---Sets the severity level from game settings
---@param setting string The name of the setting to read from settings.global
function Log.setFromSettings(setting)
    severity = Log[settings.global[setting].value] or DEFAULT
end

---Logs a message with the specified severity level
---@param msgOrFunction string|function Message to log or a function that returns the message
---@param func function Function to use for logging (e.g., game.print)
---@param sev number? Severity level (optional, defaults to DEFAULT)
function Log.log(msgOrFunction, func, sev)
    sev = sev or DEFAULT
    if (sev >= severity) then
        local msg = (type(msgOrFunction) == "function") and msgOrFunction() or msgOrFunction
        func(MSG[sev] .. (msg or "<NIL>"))
    end
end

---Logs a message using serpent.block for detailed object inspection
---@param msgOrFunction string|function Message/object to log or a function that returns it
---@param func function Function to use for logging (e.g., game.print)
---@param sev number? Severity level (optional, defaults to DEFAULT)
function Log.logBlock(msgOrFunction, func, sev)
    sev = sev or DEFAULT
    if (sev >= severity) then
        local msg = (type(msgOrFunction) == "function") and msgOrFunction() or msgOrFunction
        func(MSG[sev] .. serpent.block(msg))
    end
end

---Logs a message using serpent.line for single-line object inspection
---@param msgOrFunction string|function Message/object to log or a function that returns it
---@param func function Function to use for logging (e.g., game.print)
---@param sev number? Severity level (optional, defaults to DEFAULT)
function Log.logLine(msgOrFunction, func, sev)
    sev = sev or DEFAULT
    if (sev >= severity) then
        local msg = (type(msgOrFunction) == "function") and msgOrFunction() or msgOrFunction
        func(MSG[sev] .. serpent.line(msg))
    end
end

return Log