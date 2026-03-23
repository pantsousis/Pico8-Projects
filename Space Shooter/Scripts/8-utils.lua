-- utils --
function get_sprite_pos(sprite_num)
    -- sprite sheet is 128×128 pixels
    -- Each sprite is 8×8 pixels
    -- Sprites are arranged in rows of 16
    local sprites_per_row = 16
    local sprite_size = 8
    
    local sprite_row = flr(sprite_num / sprites_per_row)
    local sprite_col = sprite_num % sprites_per_row
    local x = sprite_col * sprite_size
    local y = sprite_row * sprite_size

    return {x = x, y = y}
end

function get_total_sprite_number()
  local count = 0

  for sy=0,15 do
    for sx=0,15 do
      if sprite_has_pixels(sx*8, sy*8) then
        count += 1
      end
    end
  end

  return count
end

function sprite_has_pixels(x0, y0)
  for y=0,7 do
    for x=0,7 do
      if sget(x0+x, y0+y) != 0 then
        return true
      end
    end
  end
  return false
end

function clear_deleted(t)
    local new_list ={}
    for i=1,#t do
        if not t[i].deleted then
            new_list[#new_list+1] = t[i]
        end
    end
    return new_list
end