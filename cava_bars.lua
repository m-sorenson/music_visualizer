require 'cairo'
require 'math'
require 'io'

local input = io.open("/tmp/audio", "r")
io.input(input)

function conky_main()
  local new_text = io.read("*l")

  if new_text ~= nil then
    if conky_window == nil then
      return
    end
    local cs = cairo_xlib_surface_create(conky_window.display,
                                        conky_window.drawable,
                                        conky_window.visual,
                                        conky_window.width,
                                        conky_window.height)
    local cr = cairo_create(cs)

    -- settings
    local bar_red=0.13
    local bar_green=.586
    local bar_blue=.95
    local bar_alpha=.7

    local shadow_red=.1
    local shadow_green=.1
    local shadow_blue=.1
    local shadow_alpha=.4

    local line_width=5

    local x_offset = 135
    for height in string.gmatch(new_text, "%d+") do
      local top_left_x = x_offset
      local top_left_y = 550 - (height / 2)
      local rec_width = 50
      local rec_height = height

      cairo_rectangle(cr,top_left_x + 10,top_left_y + 10,rec_width,rec_height)
      cairo_set_source_rgba(cr, shadow_red, shadow_green, shadow_blue, shadow_alpha)
      cairo_fill(cr)
      cairo_rectangle(cr, top_left_x, top_left_y, rec_width, rec_height)
      cairo_set_source_rgba(cr, bar_red, bar_green, bar_blue, bar_alpha)
      cairo_fill(cr)

      x_offset = x_offset + 75
    end
    cairo_restore(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
  end
end
