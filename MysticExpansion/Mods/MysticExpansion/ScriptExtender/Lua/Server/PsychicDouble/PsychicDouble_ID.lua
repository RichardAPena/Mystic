function PsychicDouble_GetCurrentMysticID(owner)
	for id = 1, 4 do
		if Osi.HasActiveStatus(owner, PsychicDouble_GetMysticIDStatusName(id)) == 1 then
			return id
		end
	end
end

function PsychicDouble_RemoveMysticIDStatus(owner)
	for id = 1, 4 do
		Osi.RemoveStatus(owner, PsychicDouble_GetMysticIDStatusName(id))

		local clone = PsychicDouble_GetActiveCloneForMystic(owner)
		if clone then
			Osi.RemoveStatus(owner, PsychicDouble_GetCloneIDStatusName(id))
		end
	end
end

function PsychicDouble_TryAssignMysticID(owner)
	local id = PsychicDouble_GetCurrentMysticID(owner)
	if id then
		print("PsychicDouble_TryAssignMysticID: already had an ID: " .. id .. "; " .. owner)
		return id
	end

	local partyMembers = Osi.DB_PartyMembers:Get(nil)
	local usedIDCounts = { 0, 0, 0, 0 }

	for k, v in pairs(partyMembers) do
		local character = v[1]
		local id = PsychicDouble_GetCurrentMysticID(character)

		if id then
			usedIDCounts[id] = usedIDCounts[id] + 1
		end
	end

	local bestID = 1
	local bestCount = 1000
	for id, count in pairs(usedIDCounts) do
		if count < bestCount then
			bestID = id
			bestCount = count
		end
	end

	print("PsychicDouble_TryAssignMysticID: assigned ID: " .. bestID .. "; " .. owner)

	Osi.ApplyStatus(owner, PsychicDouble_GetMysticIDStatusName(bestID), -1, 1)
	return bestID
end

function PsychicDouble_TryAssignMysticAndCloneID(owner, clone)
	local id = PsychicDouble_TryAssignMysticID(owner)

	if clone then
		Osi.ApplyStatus(clone, PsychicDouble_GetCloneIDStatusName(id), -1, 1)
	end
	return id
end
