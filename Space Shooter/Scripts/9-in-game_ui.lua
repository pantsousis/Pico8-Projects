-- in-game ui --
heart_spr_nums = {14, 15}
hearts={}
heart_lose_sfx_num=2

function in_game_ui_update_main()

end

function draw_in_game_ui()
    draw_score()
    draw_hearts()
end

function draw_score()
    print("score: " .. score, 1, 1, 7)
end

function draw_hearts()
    for i=1, #hearts do
        local heart = hearts[i]
        spr(heart.spr_num, heart.x, heart.y)
    end
end

function create_heart(pos_x, pos_y)
    return {
        x=pos_x,
        y=pos_y,
        spr_num=heart_spr_nums[1],
        lost=false,

        lose = function(self)
            self.spr_num=heart_spr_nums[2]
            self.lost=true
        end
    }
end

function lose_player_heart()
    for i=1, #hearts do
        local heart = hearts[i]
        if not heart.lost then
            heart:lose()
			sfx(heart_lose_sfx_num)
            break
        end
    end
end