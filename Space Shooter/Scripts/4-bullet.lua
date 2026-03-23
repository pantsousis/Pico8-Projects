-- bullet --
bullet={
	x=0,
	y=0
}

is_save_bullet=true
bullet_speed=4
bullets={}
shoot_from_position=0
attack_speed=2
bullet_tick_counter=0
bullet_sound_num=00
bullet_spr_num=2

function bullet_update_main()
	update_bullet_tick_counter()
	remove_bullets()
	update_bullet_position()
	save_bullet()
end

function save_bullet()
	if btn(btn_z) and is_save_bullet then
		pos_x=0
		pos_y=position_y-6
		
		if shoot_from_position==0 then
			pos_x=position_x-3
		else
		 pos_x=position_x+2
		end
		bullets[#bullets+1]=create_bullet(pos_x, pos_y)
		is_save_bullet=false
		change_shoot_position()
	end
	
	if (bullet_tick_counter%attack_speed)==0 then
		is_save_bullet=true
	end
end

function draw_bullets()
	if #bullets >= 1 then
		for i=1,#bullets do
			if not bullets[i].deleted then
				spr(bullet_spr_num, bullets[i].x, bullets[i].y)
			end
		end
	end
end

function update_bullet_position()
	if #bullets >= 1 then
		for i=1,#bullets do
			pos_x=bullets[i].x
			pos_y=bullets[i].y-bullet_speed
			bullets[i]:move(pos_x, pos_y)
		end
	end
end

function change_shoot_position()
	if shoot_from_position==1 then
		shoot_from_position=0
	else
		shoot_from_position=1
	end
end

function update_bullet_tick_counter()
	if btn(btn_z) or bullet_tick_counter%attack_speed~=0 then
		bullet_tick_counter+=1
	else
		bullet_tick_counter=0
	end
end

function create_bullet(pos_x, pos_y)
	play_bullet_sound()
	return {
		x=pos_x,
		y=pos_y,
		deleted=false,
		spr_num=bullet_spr_num,

		move = function(self, pos_x, pos_y)
			self.x=pos_x
			self.y=pos_y
		end
	}
end

function play_bullet_sound()
	sfx(bullet_sound_number)
end

function remove_bullets()
	bullets=clear_deleted(bullets)
end