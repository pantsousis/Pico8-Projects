-- rocks --
rocks={}
rock_spr_nums={8, 9, 10}
rock_spr_size_x=8
rock_spr_size_y=8
rock_spawn_rate=40
rock_speed=1
-- despawning
total_health=5
rock_despawn_sfx_num=1
rock_despawn={}
rock_despawn_spr_nums={11, 12, 13}
despawn_animation_speed=7

function rock_update_main()
	remove_rock_despawn_animations()
	remove_rocks()
	move_rocks()
	update_rock_despawn_animations()
	spawn_random_rock()
end

function create_rock(pos_x, pos_y)
	return {
		x=pos_x,
		y=pos_y,
		deleted=false,
		health=total_health,
		spr_num=rock_spr_nums[1],

		move = function(self, pos_x, pos_y)
			self.x=pos_x
			self.y=pos_y
		end,

		take_damage = function(self, damage)
			self.health-=damage
			local health_percentage = self.health / total_health
			if health_percentage > 0.33 and health_percentage <= 0.66 then
				self.spr_num=rock_spr_nums[2]
			end
			if health_percentage <= 0.33 then
				self.spr_num=rock_spr_nums[3]
			end
			if self.health <=0 then
				score+=1
				self:delete()
			end
		end,

		delete = function(self)
			self.deleted=true
			if self.health <= 0 then
				sfx(rock_despawn_sfx_num)
				rock_despawn[#rock_despawn+1] = create_rock_despawn_animation(self.x, self.y)
			end
		end,

		collide_with_y2_world_boundary = function(self)
			self:delete()
			lose_player_heart()
		end
	}
end

function create_rock_despawn_animation(pos_x, pos_y)
	return {
		x=pos_x,
		y=pos_y,
		frame=0,
		spr_num=rock_despawn_spr_nums[1],
		animation_speed=despawn_animation_speed,
		deleted=false,

		update = function(self)
			self.frame+=1
			if self.frame >= self.animation_speed then
				self.spr_num=rock_despawn_spr_nums[2]
			end
			if self.frame >= self.animation_speed * 2 then
				self.spr_num=rock_despawn_spr_nums[3]
			end
			if self.frame >= self.animation_speed * 3 then
				self.deleted=true
			end
			self.x=pos_x
			self.y=pos_y
		end
	}
end

function draw_rocks()
	if #rocks >= 1 then
		for i=1,#rocks do
			local rock=rocks[i]
			if not rock.deleted then
				spr(rock.spr_num, rock.x, rock.y)
			end
		end
	end
end

function spawn_random_rock()
	if (tick_counter%rock_spawn_rate)==0 then
		pos_x=rnd(b_x2-rock_spr_size_x)
		pos_y=b_y1-8
		rocks[#rocks+1]=create_rock(pos_x, pos_y)
	end	
end

function move_rocks()
	if #rocks>=1 then
		for i=1,#rocks do
			pos_x=rocks[i].x
			pos_y=rocks[i].y+rock_speed
			rocks[i]:move(pos_x,pos_y)
		end
	end
end

function update_rock_despawn_animations()
	if #rock_despawn >= 1 then
		for i=1,#rock_despawn do
			local animation=rock_despawn[i]
			animation:update()
		end
	end
end

function remove_rocks()
	rocks=clear_deleted(rocks)
end

function remove_rock_despawn_animations()
	rock_despawn=clear_deleted(rock_despawn)
end

function draw_rock_despawn_animations()
	if #rock_despawn >= 1 then
		for i=1,#rock_despawn do
			local animation=rock_despawn[i]
			animation:update()
			spr(animation.spr_num, animation.x, animation.y)
		end
	end
end