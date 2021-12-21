local M = {}

local COLOR_GREEN = vmath.vector4(0, 1, 0.6, 1)
local COLOR_ORANGE = vmath.vector4(1, 0.85, 0.18, 1)
local COLOR_RED = vmath.vector4(0.95, 0.18, 0.18, 1)

local frame_time = 0
local frame_acc = 0
local frame_count = 0
local text_node = nil

local function set_fps_text(fps)
    local c = COLOR_GREEN
    if fps and fps < 25 then
        c = COLOR_RED
    elseif fps and fps < 50 then
        c = COLOR_ORANGE
    end

    local t = fps and string.format("%d", fps) or ""

    gui.set_text(text_node, t)
    gui.set_color(text_node, c)
end

local function update_fps(dt)
    frame_acc = frame_acc + dt
    frame_count = frame_count + 1
    if frame_acc >= 0.5 then
        local fps = math.floor(frame_count / frame_acc)
        frame_count = 0
        frame_acc = 0

        set_fps_text(fps)
    end
    gui.set_enabled(text_node, true)
end

function M.init(node)
    frame_time = socket.gettime()
    text_node = node

    set_fps_text()
end

function M.update(dt)
    local t = socket.gettime()
    local frame_dt = t - frame_time
    frame_time = t

    update_fps(frame_dt)
end

return M