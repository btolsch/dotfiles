do
	local grep_crap = "ip addr | sed -n 's/^[0-9]:\\s\\(.*\\): <\\([a-zA-Z]*\\),.*>.*$/\\1 \\2/p' | sed '/LOOPBACK/d' | cut -d ' ' -f 1"
	function conky_if_list(index)
		local f = io.popen(grep_crap)
		local s = f:read("*a")
		f:close()
		local words = {}
		for word in s:gmatch("%w+") do table.insert(words, word) end
		return words[tonumber(index)]
	end

	function conky_addr(index)
		local f = io.popen(grep_crap)
		local s = f:read("*a")
		f:close()
		local words = {}
		for word in s:gmatch("%w+") do table.insert(words, word) end
		return conky_parse("${addr " .. words[tonumber(index)] .. "}")
	end

	function conky_if_up(index)
		local f = io.popen(grep_crap)
		local s = f:read("*a")
		f:close()
		local words = {}
		for word in s:gmatch("%w+") do table.insert(words, word) end
		if conky_parse("${if_up " .. words[tonumber(index)] .. "}") then
			return '1'
		else
			return ''
		end
	end
end
