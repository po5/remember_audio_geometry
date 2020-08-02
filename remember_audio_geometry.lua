local utils = require 'mp.utils'
local last_dir = ""

mp.observe_property("current-window-scale", "number", function(_, scale)
    if scale == nil then return end
    if not is_audio_file() then return end
    if mp.get_property_bool("fullscreen", true) then return end
    width, height = mp.get_osd_size()
    if (width or 0) < 1 then return end
    mp.set_property("geometry", width .. "x" .. height)
end)

mp.add_hook("on_load", 10, function ()
    local dir, filename = utils.split_path(mp.get_property("stream-open-filename", ""))
    if dir ~= last_dir and last_dir ~= "" then
        mp.set_property("geometry", "50%:50%")
    end
    last_dir = dir
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
