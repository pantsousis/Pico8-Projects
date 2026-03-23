-- draw --
function _draw()
	cls()
	-- draw_boundaries()
	draw_in_game_ui()
	draw_bullets()
	draw_player()
	draw_rocks()
	draw_rock_despawn_animations()
	-- print(position_x .. " - " .. position_y)
	-- print("collisions:")
	-- print(#bullets .. "x" .. #rocks .. "=" .. #bullets*#rocks)
	-- for	i=1, #rocks do
	-- 	print("rock: " .. i .. ": " .. rocks[i].health)
	-- end
end