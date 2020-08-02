mp.observe_property("current-window-scale", "number", function(_, scale)
    if scale == nil then return end
    if not is_audio_file() then return end
    if mp.get_property_bool("fullscreen", true) then return end
    width, height = mp.get_osd_size()
    if (width or 0) < 1 then return end
    mp.set_property("geometry", width .. "x" .. height)
end)

-- https://github.com/CogentRedTester/mpv-coverart/blob/master/coverart.lua
function is_audio_file()
    if mp.get_property("track-list/0/type") == "audio" then
        return true
    elseif mp.get_property("track-list/0/albumart") == "yes" then
        return true
    end
    return false
end