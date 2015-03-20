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
		if words[tonumber(index)] and conky_parse("${if_up " .. words[tonumber(index)] .. "}") then
			return ''
		else
			return '1'
		end
	end

	function conky_downspeed(index)
		local f = io.popen(grep_crap)
		local s = f:read("*a")
		f:close()
		local words = {}
		for word in s:gmatch("%w+") do table.insert(words, word) end
		return conky_parse("${downspeed " .. words[tonumber(index)] .. "}")
	end

	function conky_upspeed(index)
		local f = io.popen(grep_crap)
		local s = f:read("*a")
		f:close()
		local words = {}
		for word in s:gmatch("%w+") do table.insert(words, word) end
		return conky_parse("${upspeed " .. words[tonumber(index)] .. "}")
	end

	function conky_dbstatus(i)
		local f = io.popen("/home/btolsch/bin/dropbox.py status")
		local s = f:read("*a")
		f:close()
		return string.sub(s, 1, string.find(s, "\n") - 1):gsub('"', "'")
	end
end
