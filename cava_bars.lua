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
    local fill_red=0.15
    local fill_green=.47
    local fill_blue=.67
    local fill_alpha=1
    local line_red=.35
    local line_green=.16
    local line_blue=.81
    local line_alpha=.8

    local line_width=5

    local x_offset = 135
    for height in string.gmatch(new_text, "%d+") do
      local top_left_x = x_offset
      local top_left_y = 500 - (height / 2)
      local rec_width = 50
      local rec_height = height
      -- cairo_set_line_width (cr,line_width)
      cairo_rectangle (cr,top_left_x + 10,top_left_y + 10,rec_width,rec_height)
      cairo_set_source_rgba (cr,line_red,line_green,line_blue,line_alpha)
      cairo_fill (cr)
      cairo_rectangle (cr,top_left_x,top_left_y,rec_width,rec_height)
      cairo_set_source_rgba (cr,fill_red,fill_green,fill_blue,fill_alpha)
      cairo_fill (cr)
      -- cairo_set_source_rgba (cr,line_red,line_green,line_blue,line_alpha)
      -- cairo_stroke (cr)

      x_offset = x_offset + 75
    end
    cairo_restore(cr)

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
  end
end
