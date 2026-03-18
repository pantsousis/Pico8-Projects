-- draw --
function _draw()
	cls()
	-- draw_boundaries()
	draw_bullets()
	draw_player()
	draw_rocks()
	-- print(position_x .. " - " .. position_y)
	print(#bullets)
end