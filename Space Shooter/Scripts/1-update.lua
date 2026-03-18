-- update --
tick_counter=0

function _update()
	tick_counter+=1
	collisions_update_main()
	player_update_main()
	bullet_update_main()
	rock_update_main()
	
	handle_world_boundary_collisions()
end