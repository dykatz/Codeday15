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

function math.sign(x)
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	else
		return 0
	end
end
