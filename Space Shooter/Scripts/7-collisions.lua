-- collisions --
function collisions_update_main()
	handle_bullet_rock_collision()
end

function bitmap_collision_uniform(mask1, x1, y1, mask2, x2, y2)
	if mask1 == nil or mask2 == nil then
		error("masks cannot be nil")
	end
	if (#mask1 ~= #mask2) then
		error("masks must be of the same size")
	end
	local size = #mask1
	local dx = x2 - x1
	local dy = y2 - y1

	-- check if the bounding boxes of the masks overlap
	if dx < -size or dx > size or dy < -size or dy > size then
		return false
	end

	-- move coordinates to (x1,y1)
	for y1_new = 0,7 do

		-- move coordinates to (x2,y2)
		local y1_new_new = y1_new - dy

		-- if row of mask2 overlaps with row of mask1
		if y1_new_new >= 0 and y1_new_new < size then
			local mask1_row = mask1[y1_new]
			local mask2_row = mask2[y1_new_new]

			if dx > 0 then
				mask2_row = mask2_row >> dx
			elseif dx < 0 then
				mask2_row = mask2_row << -dx
			end

			if (mask1_row & mask2_row) ~= 0 then
				return true
			end

		end
		
	end

	return false
end

function get_bitmask(sprite_num)
	local sprite_pos = get_sprite_pos(sprite_num)
	local x = sprite_pos.x
	local y = sprite_pos.y
	local bitmask = {}

	for	i=0,7 do
		local row = "0b"
		for j=0,7 do
			local pixel_color = sget(x + j, y + i)
			if pixel_color ~= 0 then
				row = row .. "1"
			else
				row = row .. "0"
			end
		end

		bitmask[i] = tonum(row)
	end

	return bitmask
end

function handle_bullet_rock_collision()
	if #bullets >= 1 and #rocks >= 1 then
		for i=1,#bullets do
			if not bullets[i].deleted then
				for j=1,#rocks do
					if not rocks[j].deleted then
						bullet=bullets[i]
						rock=rocks[j]
						if bitmap_collision_uniform(
							bitmasks[bullet.spr_num], bullet.x, bullet.y,
							bitmasks[rock.spr_num], rock.x, rock.y
						) then
							-- remove bullet and rock from their respective tables
							-- table.remove(bullets, i)
							-- table.remove(rocks, j)
							rock:take_damage(1)
							bullet.deleted=true
							break
						end
					end
				end
			end
		end
	end
end