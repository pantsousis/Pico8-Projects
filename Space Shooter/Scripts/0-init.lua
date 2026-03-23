-- init --
function _init()
 -- buttons defs --
	btn_left=0
	btn_right=1
	btn_up=2
	btn_down=3
	btn_z=4
	btn_x=5
	
	-- boundaries --
	b_x1=0
	b_x2=128
	b_y1=0
	b_y2=128

	-- bitmasks --
	bitmasks=initialize_bitmasks()

	-- in-game ui --
	in_game_ui_init_main()
end

function initialize_bitmasks()
	local bitmasks_local={}
	for i=0,get_total_sprite_number()-1 do
		bitmasks_local[i]=get_bitmask(i)
	end
	return bitmasks_local
end

function in_game_ui_init_main()
    local pos_x_init=b_x2-player_health*8-player_health
    local pos_y=b_y2-9
    for i=1, player_health do
        hearts[i] = create_heart(pos_x_init + (i-1)*8 + (i-1), pos_y)
    end
end