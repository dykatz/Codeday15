function table.find(t, val)
	for k, v in pairs(t) do
		if v == val then
			return k
		end
	end
end

function table.contains(t, val)
	for _, v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end
