--
-- NOTE: this is run *AFTER* any HBA and RAID drivers are loaded
--       drives should have been enumerated or in the process of being enumerated
function string:split( inSplitPattern, outResults )

	if not outResults then
		outResults = { }
	end
	local theStart = 1
	local theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	while theSplitStart do
		table.insert( outResults, string.sub( self, theStart, theSplitStart-1 ) )
		theStart = theSplitEnd + 1
		theSplitStart, theSplitEnd = string.find( self, inSplitPattern, theStart )
	end

	table.insert( outResults, string.sub( self, theStart ) )
	return outResults
end

function trace(Message, ...)

	local Msg = string.format(Message, unpack({...}))
	io.write(os.date() .." : ".. Msg)
	io.stderr:write(os.date().." : ".. Msg)
end

trace("---------------------------------------------------------------\n")
trace("boot disk script\n")

-- use the first nvme disk, OS disk is always 0 
local Drive = "nvme1n1"		

-- get the disks first serial number (minus the OS disk) 
local f1 = io.popen("sudo /usr/local/sbin/smartctl -a /dev/"..Drive.." | grep Serial", "r")
local Line = f1:read("*line")
f1:close()
trace("[%s]\n", Line)

local s = Line:split("[%s]+")	
--for a,b in ipairs(s) do print(a,b) end
local LocalSerial = s[3]
trace("/dev/%s SN:%s\n", Drive, LocalSerial) 

-- get list of possible disk configs
local DiskConfig = {}
for i=0,50 do

	local L = loadfile("/mnt/store0/etc/disk_"..i..".lua")
	if (L ~= nil) then 
		local Config = L()
		trace("Loading Config "..i.."\n")
		DiskConfig[i] = Config
	end
end

-- search for disk in the config list
local ConfigID = nil
for i,Config in pairs(DiskConfig) do

	local List = {}
	for Serial,Mount in pairs(Config.CacheDisk) 	do List[Serial] = Mount end
	for Serial,Mount in pairs(Config.ParDisk)		do List[Serial] = Mount end

	for Serial,Mount in pairs(List) do
		if (Serial == LocalSerial) then
			trace("Found Config %i\n", i) 
			ConfigID = i
		end
	end
end

-- failed to find the config
if (ConfigID == nil) then
	trace("Failed to find disk config?")
	return
end

-- remove previous map
local Cmd = "rm /mnt/store0/etc/disk.lua"
trace("Cmd [%s]\n", Cmd)
os.execute(Cmd)

-- select a disk mapping
local Cmd = "ln -s /mnt/store0/etc/disk_"..ConfigID..".lua /mnt/store0/etc/disk.lua"
trace("Cmd [%s]\n", Cmd)
os.execute(Cmd)

trace("disk.boot complete\n")
trace("---------------------------------------------------------------\n")
