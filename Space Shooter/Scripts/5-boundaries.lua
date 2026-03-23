-- boundaries --
function handle_world_boundary_collisions()
	player_world_boundary_collision()
	bullet_world_boundary_collision()
	rock_world_boundary_collision()
end

function player_world_boundary_collision()
	if position_x >= (b_x2 - spr_size_x) then
		position_x=b_x2-spr_size_x
	end
	
	if position_x <= b_x1 then
		position_x=b_x1
	end
	
	if position_y <= b_y1 then
		position_y=b_y1
	end
	
	if position_y >= (b_y2 - spr_size_y) then
		position_y=b_y2-spr_size_y
	end

end

function draw_boundaries()
	for x=b_x1,b_x2 do
		spr(5, x, b_y1)
	end
	
	for x=b_x1,b_x2 do
		spr(5, x, b_y2)
	end
	
	for y=b_y1,b_y2 do
		spr(5, b_x1, y)
	end
	
	for y=b_y1,b_y2 do
		spr(5, b_x2, y)
	end
end

function bullet_world_boundary_collision()
	for i=1,#bullets do
		if bullets[i].y < b_y1-8 then
			bullets[i].deleted = true
		end
	end
end

function rock_world_boundary_collision()
	for i=1,#rocks do
		if rocks[i].y > b_y2 then
			rocks[i]:collide_with_y2_world_boundary()
		end
	end
end