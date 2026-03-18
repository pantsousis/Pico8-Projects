-- player movement -
position_x=(128/2-4)
position_y=128
speed=2
direction_x=0 -- 0 none, 1 right, -1 left
direction_y=0
spr_size_x=8
spr_size_y=8
function player_update_main()
	direction_x=0
	if btn(btn_right) then
		direction_x=1
		position_x+=speed
	end
	
	if btn(btn_left) then
		direction_x=-1
		position_x-=speed
	end
	
	if btn(btn_up) then
		position_y-=speed
	end
	
	if btn(btn_down) then
		position_y+=speed
	end
end

function draw_player()
	sprite=1
	if direction_x==-1 then
		sprite=3
	elseif direction_x==1 then
		sprite=4
	end
	spr(sprite, position_x, position_y)
end
