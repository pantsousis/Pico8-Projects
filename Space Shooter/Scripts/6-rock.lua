-- rocks --
rock_num=0
rocks={}
rock_spr_num=8
rock_spr_size_x=8
rock_spr_size_y=8
rock_spawn_rate=40
rock_speed=0.5

function rock_update_main()
	move_rocks()
	spawn_random_rock()
end

function create_rock(pos_x, pos_y)
	return {
		x=pos_x,
		y=pos_y,
		
		move = function(self, pos_x, pos_y)
			self.x=pos_x
			self.y=pos_y
		end
	}
end

function draw_rocks()
	if rock_num >= 1 then
		for i=1,rock_num do
			spr(rock_spr_num, rocks[i].x, rocks[i].y)
		end
	end
end

function spawn_random_rock()
	if (tick_counter%rock_spawn_rate)==0 then
		pos_x=rnd(b_x2-rock_spr_size_x)
		pos_y=b_y1-8
		rock_num+=1
		rocks[rock_num]=create_rock(pos_x, pos_y)
	end	
end

function move_rocks()
	if rock_num>=1 then
		for i=1,rock_num do
			pos_x=rocks[i].x
			pos_y=rocks[i].y+rock_speed
			rocks[i]:move(pos_x,pos_y)
		end
	end
end