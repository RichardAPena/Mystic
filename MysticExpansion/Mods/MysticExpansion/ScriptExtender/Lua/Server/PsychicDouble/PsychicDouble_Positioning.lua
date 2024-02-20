
function PsychicDouble_FindValidPosition(x, y, z, searchRadius, entity)
	local tx, ty, tz = Osi.FindValidPosition(x, y, z, searchRadius, entity, 1) -- avoid hazards
	if not tz then
		tx, ty, tz = Osi.FindValidPosition(x, y, z, searchRadius, entity, 0) -- allow hazards
	end
	return tx, ty, tz
end

function PsychicDouble_FindClampedMovePosition(entity, targetX, targetY, targetZ, maxDistance, searchRadius, originEntity)
	originEntity = originEntity or entity

	local cx, cy, cz = Osi.GetPosition(originEntity)
	local distance = Osi.GetDistanceToPosition(originEntity, targetX, targetY, targetZ)
	print("FCP: maxDistance: " .. maxDistance)

	if distance <= maxDistance then
		print("FCP: ok")
		return targetX, targetY, targetZ, distance, distance
	end

	local dx = targetX - cx
	local dy = targetY - cy
	local dz = targetZ - cz

	local len = math.sqrt(dx*dx + dy*dy + dz*dz)
	local scale = maxDistance / len

	local tx = cx + dx * scale
	local ty = cy + dy * scale
	local tz = cz + dz * scale

	local x, y, z = PsychicDouble_FindValidPosition(tx, ty, tz, searchRadius, entity)

	if z then
		local newDistance = Osi.GetDistanceToPosition(originEntity, x, y, z)
		print("FCP: newDistance: " .. newDistance)
		return x, y, z, newDistance, distance
	else
		print("FCP: no position found")
		return tx, ty, tz, nil, distance
	end
end

function PsychicDouble_FindOutOfSightPosition(entity, avoidHazards)
	avoidHazards = avoidHazards or 1

	local stepSize = 1000
	local searchRadius = 800
	local cx, cy, cz = Osi.GetPosition(entity)

	for dx = -2, 2 do
		for dz = -2, 2 do
			if dx ~= 0 and dz ~= 0 then
				local x, y, z = Osi.FindValidPosition(cx + dx * searchRadius, cy, cz + dz * searchRadius, stepSize, entity, avoidHazards)
				if z then
					return x, y, z
				end
			end
		end
	end

	return Osi.FindValidPosition(0, 0, 0, searchRadius, entity, avoidHazards)
end
