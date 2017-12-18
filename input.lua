local Input = {}

Input.keystates = {}
Input.oneshots = {} -- contains delays as values
Input.repeatable = {}


local function clear()
    Input.keystates = {}
    Input.oneshots = {}
    Input.repeatable = {}
end


local function set_oneshot(key)
    Input.oneshots[key] = true
end
Input.set_oneshot = set_oneshot


local function set_repeatable(key, delay)
    Input.repeatable[key] = delay
    Input.set_oneshot(key)
end
Input.set_repeatable = set_repeatable


local function get(key)
    if Input.keystates[key] ~= nil then
        return Input.keystates[key].state
    else
        return false
    end
end
Input.get = get


local function press(key)
    Input.keystates[key] = {
        state = true,
        timer = 0
    }
end
Input.press = press


local function release(key)
    Input.keystates[key] = nil
end
Input.release = release


local function update_timer(key, dt)
    Input.keystates[key].timer = Input.keystates[key].timer + dt

    if Input.oneshots[key] ~= nil then
        Input.keystates[key].state = false
    end

    if Input.repeatable[key] ~= nil and
        Input.keystates[key].timer >= Input.repeatable[key] then
        Input.keystates[key].state = true
    end
end


local function update_timers(dt)
    for k, v in pairs(Input.keystates) do
        update_timer(k, dt)
    end
end
Input.update_timers = update_timers


return Input