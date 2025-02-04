local M = {}

function M.hex2rgb(hex)
    hex = hex:gsub("#", "")
    return tonumber("0x" .. hex:sub(1, 2)) / 255,
        tonumber("0x" .. hex:sub(3, 4)) / 255,
        tonumber("0x" .. hex:sub(5, 6)) / 255
end

function M.rgb2hex(r, g, b)
    return string.format("#%02X%02X%02X", math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5))
end

function M.rgb2xyz(r, g, b)
    local function gamma_correction(c)
        return (c <= 0.04045) and (c / 12.92) or ((c + 0.055) / 1.055) ^ 2.4
    end
    r, g, b = gamma_correction(r), gamma_correction(g), gamma_correction(b)
    return r * 0.4124564 + g * 0.3575761 + b * 0.1804375,
        r * 0.2126729 + g * 0.7151522 + b * 0.0721750,
        r * 0.0193339 + g * 0.1191920 + b * 0.9503041
end

function M.xyz2lab(x, y, z)
    local function f(t)
        return (t > 0.008856) and (t ^ (1 / 3)) or ((7.787 * t) + (16 / 116))
    end
    local xn, yn, zn = 0.95047, 1.00000, 1.08883
    return (116 * f(y / yn)) - 16,
        500 * (f(x / xn) - f(y / yn)),
        200 * (f(y / yn) - f(z / zn))
end

function M.lab2lch(l, a, b)
    local c = math.sqrt(a * a + b * b)
    local h = math.deg(math.atan(b / a))
    if h < 0 then h = h + 360 end
    return l, c, h
end

function M.lch2lab(l, c, h)
    local hr = math.rad(h)
    return l, c * math.cos(hr), c * math.sin(hr)
end

function M.lab2xyz(l, a, b)
    local function f_inv(t)
        return (t > 0.206893) and (t ^ 3) or ((t - 16 / 116) / 7.787)
    end
    local xn, yn, zn = 0.95047, 1.00000, 1.08883
    return f_inv((l + 16) / 116 + a / 500) * xn,
        f_inv((l + 16) / 116) * yn,
        f_inv((l + 16) / 116 - b / 200) * zn
end

function M.xyz2rgb(x, y, z)
    local r = x * 3.2406 + y * -1.5372 + z * -0.4986
    local g = x * -0.9689 + y * 1.8758 + z * 0.0415
    local b = x * 0.0557 + y * -0.2040 + z * 1.0570
    local function gamma_correct(c)
        return (c <= 0.0031308) and (12.92 * c) or (1.055 * (c ^ (1 / 2.4)) - 0.055)
    end
    return gamma_correct(r), gamma_correct(g), gamma_correct(b)
end

-- Convert HEX to LCH
function M.hex2lch(hex)
    local r, g, b = M.hex2rgb(hex)
    local x, y, z = M.rgb2xyz(r, g, b)
    return M.lab2lch(M.xyz2lab(x, y, z))
end

-- Convert LCH to HEX
function M.lch2hex(l, c, h)
    local x, y, z = M.lab2xyz(M.lch2lab(l, c, h))
    local r, g, b = M.xyz2rgb(x, y, z)
    return M.rgb2hex(r, g, b)
end

return M
