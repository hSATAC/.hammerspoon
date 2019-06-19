-- HANDLE SCROLLING
local oldmousepos = {}
local scrollmult = -4	-- negative multiplier makes mouse work like traditional scrollwheel
local reverse = false

mousetap = hs.eventtap.new({5}, function(e)
    oldmousepos = hs.mouse.getAbsolutePosition()
    local mods = hs.eventtap.checkKeyboardModifiers()
    if mods['cmd'] then
        local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
        local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
        if reverse then
            dx = dx * -1
            dy = dy * -1
        end
        local scroll = hs.eventtap.event.newScrollEvent({dx * scrollmult, dy * scrollmult},{},'pixel')
        scroll:post()

        -- put the mouse back
        hs.mouse.setAbsolutePosition(oldmousepos)

        return false, {}
    else
        return false, {}
    end
end)
mousetap:start()

-- HANDLE MOUSE BUTTON
mouseclick = hs.eventtap.new({25}, function(eventobj)
    -- kensington
    if eventobj:getButtonState(2) then
        hs.execute('~/bin/fp.sh', true)
        return true
    end

    if eventobj:getButtonState(3) then
        hs.execute('~/bin/fn.sh', true)
        return true
    end
    -- logitech MX master
    if eventobj:getButtonState(4) then
        hs.execute('~/bin/fp.sh', true)
        return true
    end

    return false
end)
mouseclick:start()



mouseprint = hs.eventtap.new({"all"}, function(eventobj)
    print("==================")
    print(eventobj:getRawEventData()['NSEventData'])
    print("==================")
end)
-- mouseprint:start()