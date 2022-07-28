#!/usr/local/bin/luajit
--
-- example pull script to extract data off the FMADIO system
--
-- 1) realtime Pull pcaps every 60sec
-- 
-- ./fmadio_pull_pcap.lua  --src http://192.168.1.100/ --dst /mnt/pcap/40v3/ --realtime 60e9
--
--

-- so sleep is native
local ffi = require "ffi"
ffi.cdef "unsigned int sleep(unsigned int seconds);"

-- location of utiltities
CURL = "/usr/local/bin/curl"
GZIP = "/usr/bin/gzip"

-- wait 10sec after slice time ends, so fmadio system has flushed everything
FMADIOFlushTime = 10e9			

-- filename prefix. e.g. hostname
FilePrefix = "fmadio100"

-- get args
local i = 1
while (i < #arg) do

	-- address of the fmadio system
	if (arg[i] == "--src") then
		FMADIOAddress = arg[i+1]	
		i = i + 1
	end

	-- path on where to write it to
	if (arg[i] == "--dst") then
		TargetPath = arg[i+1]	
		i = i + 1
	end

	-- running in realtime with splits of the specificed size
	if (arg[i] == "--realtime") then
		RealtimeUpdate = tonumber(arg[i+1])
		i = i + 1
	end

	i = i + 1
end

--chomp the last / of the URI
if (FMADIOAddress:sub(-1, -1) == "/") then
	FMADIOAddress = FMADIOAddress:sub(1, -2)
end

-- run in realtime mode
if (RealtimeUpdate ~= nil) then

	-- requries valid address
	if (FMADIOAddress == nil) then
		print("requires for example --src http://192.168.1.1/ on where to fetch data")
		return
	end

	-- requries destiation location 
	if (TargetPath == nil) then
		print("requires write path --dst /mnt/pcap/mycaptures/ on where write data to")
		return
	end

	-- validate split range 
	if (RealtimeUpdate == nil) then
		print("requires update frequency --realtime 60e9 e.g 60 seconds (in nanos)")
		return
	end

	-- min freq 10sec 
	if (RealtimeUpdate < 10e9 ) then
		print("update frequency too low")
		return
	end

	-- max freq 1day 
	if (RealtimeUpdate > 24*60*60*1e9 ) then
		print("update frequency too large")
		return
	end

	-- get current epoch on the fmadio
	local Cmd = CURL .. ' -s -k "'..FMADIOAddress..'/api/v1/system/time_current"'
	print(Cmd)
	local f = io.popen(Cmd, "r")
	local FMADIOEpoch = f:read("*line")
	f:close()

	-- local epoch vs fmadio epoch 
	local LocalTS = os.time() * 1e9
	local LocalOffset =  LocalTS - FMADIOEpoch
	print(string.format("FMADIO Epoch:%i LocalEpoch:%i (%i)", FMADIOEpoch, LocalTS, LocalOffset))

	-- calculate rounded start time
	local TS = math.floor(FMADIOEpoch / RealtimeUpdate) * RealtimeUpdate

	-- run forever 
	while true do

		-- next time slice
		local TS0 = TS 
		local TS1 = TS + RealtimeUpdate

		-- next time local epoch
		local LocalTSEnd = TS1 + LocalOffset + FMADIOFlushTime

		-- wait for end time + buffer flush time 
		while true do

			local LocalTS = os.time() * 1e9 

			local dT = LocalTSEnd - LocalTS

			print(string.format("%.3f sec", dT/1e9)) 

			if (dT < 0) then break end

			ffi.C.sleep(1)
		end

		-- calculate human readable form
		local FileName = FilePrefix .. "_"..os.date("%Y%m%d_%H%M%S", TS0/1e9)..".pcap"

		-- write as epoch seconds 
		--local FileName = FilePrefix .. "_"..string.format("%i", TS0/1e9)..".pcap"

		-- log 
		print(string.format("Slice %i - %i : %s", TS0, TS1, FileName))

		-- fetch pcap 
		local Cmd = CURL .. ' -s -k "'..FMADIOAddress..string.format('/api/v1/pcap/timerange?TSBegin=%i&TSEnd=%i', TS0, TS1)..'" > '.. TargetPath..'/'..FileName
		print(Cmd)
		os.execute(Cmd)

		-- slot done, bump the counter
		TS = TS + RealtimeUpdate
	end
end
