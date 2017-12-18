local Input = {}

Input.keystates = {}
Input.oneshots = {} -- contains delays as values
Input.repeatable = {}


function Input.clear()
  Input.keystates = {}
  Input.oneshots = {}
  Input.repeatable = {}
end


function Input.set_oneshot(key)
  Input.oneshots[key] = true
end


function Input.set_repeatable(key, delay)
  Input.repeatable[key] = delay
  Input.set_oneshot(key)
end


function Input.get(key)
  if Input.keystates[key] ~= nil then
    return Input.keystates[key].state
  else
    return false
  end
end


function Input.press(key)
  Input.keystates[key] = {
    state = true,
    timer = 0
  }
end


function Input.release(key)
  Input.keystates[key] = nil
end


function Input.update_timer(key, dt)
  Input.keystates[key].timer = Input.keystates[key].timer + dt

  if Input.oneshots[key] ~= nil then
    Input.keystates[key].state = false
  end

  if Input.repeatable[key] ~= nil and
    Input.keystates[key].timer >= Input.repeatable[key] then
    Input.keystates[key].state = true
  end
end


function Input.update_timers(dt)
  for k, v in pairs(Input.keystates) do
    update_timer(k, dt)
  end
end


return Input
