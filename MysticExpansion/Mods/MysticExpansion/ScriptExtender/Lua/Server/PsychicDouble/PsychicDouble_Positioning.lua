
function PsychicDouble_FindValidPosition(x, y, z, searchRadius, entity)
	local tx, ty, tz = Osi.FindValidPosition(x, y, z, searchRadius, entity, 1) -- avoid hazards
	if not tz then
		tx, ty, tz = Osi.FindValidPosition(x, y, z, searchRadius, entity, 0) -- allow hazards
	end
	return tx, ty, tz
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
