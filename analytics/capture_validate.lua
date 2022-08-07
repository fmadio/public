#!/opt/fmadio/bin/fmadiolua
--
-- validates the currently active capture data 
--
-- assumed to run on the fmadio capture device
--


function trace(Message, ...)
	os.trace(os.date("[%Y%m%d_%H%M%S] ").. string.format(Message, unpack({...})))
end


trace("Start Validation\n");

local Cmd = ""

-- cat the currently active capture
Cmd = " sudo /opt/fmadio/bin/stream_cat --chunked "


-- run it on a specific capture
if (#ARGV  > 0) then
	for a,b in pairs(ARGV) do
		trace("Offline mode %s\n", b)
		Cmd = Cmd .. " "..b.."" 
	end
end

-- run capinfos 
Cmd = Cmd .. " | /opt/fmadio/bin/capinfos2 -v "

local TimeStart = 0
local TimeStop  = 0

trace("Cmd [%s]\n", Cmd)
local f = io.popen(Cmd, "r")
for l in f:lines() do

	trace("stream_cat:%s\n", l)

	local s = l:split("[%s()]+")

	if (l:find("^Time First") ~= nil) then
		
		--for i,j in ipairs(s) do print(i,j) end
		--Time First     : 20220728_025959 17:59:59.487.131.396 (1658944799.487131396)
		--1       Time
		--2       First
		--3       :
		--4       20220728_025959
		--5       17:59:59.487.131.396
		--6       1658944799.487131396
		--7
		TimeStart = tonumber_def(s[6], 0)
	end

	if (l:find("^Time Last") ~= nil) then
		
		--for i,j in ipairs(s) do print(i,j) end
		--Time Last      : 20220728_035959 18:59:59.516.706.072 (1658948399.516706072)
		--1       Time
		--2       Last
		--3       :
		--4       20220728_035959
		--5       18:59:59.516.706.072
		--6       1658948399.516706072
		--7
		TimeStop = tonumber_def(s[6], 0)
	end
end
f:close()


dTime = TimeStop - TimeStart

trace("PCAP Info:\n");
trace("    Timestart : %f\n", TimeStart);
trace("    TimeStop  : %f\n", TimeStop)
trace("    Delta     : %f sec (%.3f Hour)\n", dTime, dTime / (60*60) ) 


local EpochNow = os.clock_ns() / 1e9
dStartNow = EpochNow - TimeStart
dStopNow  = EpochNow - TimeStop

trace("delta frrom epoch now:\n");
trace("    Start     :%f (%.3fHour)\n", dStartNow, dStartNow/(60*60))
trace("    Stop      :%f (%.3fHour)\n", dStopNow, dStopNow/(60*60) )


-- validate sane epoch 
local IsStatus = "OK"

local EpochMin  = 1420074000 -- 2015/1/1 
local EpochMax  = 1893459600 -- 2030/1/1 

if (TimeStart < EpochMin) then 
	trace("Invalid TimeStart under\n")
	IsStatus = "FALSE"
end
if (TimeStart > EpochMax) then  
	trace("Invalid TimeStart over\n")
	IsStatus = "FALSE"
end

if (TimeStop < EpochMin) then 
	trace("Invalid TimeStop under\n")
	IsStatus = "FALSE"
end
if (TimeStop > EpochMax) then  
	trace("Invalid TimeStop over\n")
	IsStatus = "FALSE"
end

if (math.abs(dStartNow) > 48*60*60) then
	trace("timestamp start > 2 days old \n")
	IsStatus = "FALSE"
end

if (math.abs(dStopNow) > 48*60*60) then
	trace("timestamp stop > 2 days old \n")
	IsStatus = "FALSE"
end

if (IsStatus ~= "OK") then

	trace("  _____       .__.__             .___ \n")
	trace("_/ ____\\____  |__|  |   ____   __| _/ \n")
	trace("\\   __\\\\__  \\ |  |  | _/ __ \\ / __ |  \n")
	trace(" |  |   / __ \\|  |  |_\\  ___// /_/ |  \n")
	trace(" |__|  (____  /__|____/\\___  >____ |  \n")
	trace("            \\/             \\/     \\/  \n")
end
trace("Result: %s\n", IsStatus)
