CREATE TABLE fmadio.syslog (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `message` 		String 				DEFAULT NULL,			-- message
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.temperature (
  `t` 							DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 						String 				DEFAULT NULL,			-- hostname
  `facility` 					String 				DEFAULT NULL,			-- facility 
  `facility-num` 				String 				DEFAULT NULL,			-- facility number
  `severity` 					String 				DEFAULT NULL,			-- serverity
  `severity-num` 				String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 					String 				DEFAULT NULL,			-- syslog tag
  `module` 						String 				DEFAULT NULL,			-- module
  `subsystem` 					String 				DEFAULT NULL,			-- subsystem
  `timestamp` 					DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `Temperature_CPU0` 			Decimal32(3) 		DEFAULT NULL,			-- temperature cpu0
  `Temperature_CPU1` 			Decimal32(3) 		DEFAULT NULL,			-- temperature cpu1
  `Temperature_PCH` 			Decimal32(3) 		DEFAULT NULL,			-- temperature pch
  `Temperature_NIC` 			Decimal32(3) 		DEFAULT NULL,			-- temperature nic
  `Temperature_AirIn` 			Decimal32(3) 		DEFAULT NULL,			-- temperature air in
  `Temperature_AirOut` 			Decimal32(3) 		DEFAULT NULL,			-- temperature air out
  `Temperature_PER` 			Decimal32(3)		DEFAULT NULL,			-- temperature per
  `Temperature_SYS` 			Decimal32(3) 		DEFAULT NULL,			-- temperature system
  `Temperature_Transceiver0` 	Decimal32(3) 		DEFAULT NULL,			-- temperature transceiver 0
  `Temperature_Transceiver1` 	Decimal32(3) 		DEFAULT NULL,			-- temperature transceiver 1
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;


CREATE TABLE fmadio.ptp (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 		String 				DEFAULT NULL,			-- subsystem
  `timestamp` 		DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `TimeFPGA` 		Int64 				DEFAULT NULL,			-- epoch nanosec time on the host system. diciplined by ntp, ptpv2, or free run 
  `TimeSYS` 		Int64 				DEFAULT NULL,			-- epoch nanosec time on the fpga clock
  `GMOffset` 		Float32 			DEFAULT NULL,			-- grand master offset
  `GMSync` 			Bool 				DEFAULT NULL,			-- grand master sync enable/disable
  `GMMaster` 		String 				DEFAULT NULL,			-- grand master
  `SysOffset` 		Float32 			DEFAULT NULL,			-- system time offset
  `SysSync` 		Bool 				DEFAULT NULL,			-- system sync
  `iSysOffset` 		Float32 			DEFAULT NULL,			-- 
  `iSysSync` 		Bool 				DEFAULT NULL,			-- 
  `NTPOffset` 		Float32 			DEFAULT NULL,			-- ntp offset
  `NTPSync` 		Bool 				DEFAULT NULL,			-- ntp sync
  `NTPMaster` 		String 				DEFAULT NULL,			-- ntp server
  `GMUpTime` 		Float32 			DEFAULT NULL,			-- grand master uptime
  `SysUptime` 		Float32 			DEFAULT NULL,			-- system uptime
  `iSysUptime` 		Float32 			DEFAULT NULL,			-- 
  `PPSUptime` 		Float32 			DEFAULT NULL,			-- pps uptime
  `NTPUptime` 		Float32 			DEFAULT NULL,			-- ntp uptime
  `PPSPeriod` 		Float32	 			DEFAULT NULL,			-- pps period
  `PPSOffset` 		Int64 				DEFAULT NULL,			-- pps offset
  `PPSdPhase` 		Int64 				DEFAULT NULL,			-- pps phase
  `PPSdZero` 		Int64 				DEFAULT NULL,			-- pps zero
  `PPSCnt` 			Int64 				DEFAULT NULL,			-- pps count
  `Clk156Period` 	Float32 			DEFAULT NULL,			-- clock 156 period
  `Clk156Offset` 	Float32 			DEFAULT NULL,			-- clock 156 offset
  `Clk250Period` 	Float32 			DEFAULT NULL,			-- clock 250 period
  `Clk250Offset` 	Float32 			DEFAULT NULL,			-- clock 250 offset
  `Clk322Period` 	Float32 			DEFAULT NULL,			-- clock 322 period
  `Clk322Offset` 	Float32 			DEFAULT NULL,			-- clock 322 offset
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.other (
  `t` 					DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 				String 				DEFAULT NULL,			-- hostname
  `facility` 			String 				DEFAULT NULL,			-- facility 
  `facility-num` 		String 				DEFAULT NULL,			-- facility number
  `severity` 			String 				DEFAULT NULL,			-- serverity
  `severity-num` 		String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 			String 				DEFAULT NULL,			-- syslog tag
  `module` 				String 				DEFAULT NULL,			-- module
  `subsystem` 			String 				DEFAULT NULL,			-- subsystem
  `timestamp` 			DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `UptimeHour` 			Decimal32(3) 		DEFAULT NULL,			-- uptime hour
  `MemFree` 			Decimal64(3) 		DEFAULT NULL,			-- memory free
  `MemErrorECC` 		Decimal64(3) 		DEFAULT NULL,			-- memory ecc error
  `WritebackB` 			Decimal64(3) 		DEFAULT NULL,			-- write back GB (byte)
  `WritebackPct` 		Float32 			DEFAULT NULL,			-- writeback pct of the SSD cache filled unwritten
  `WritebackDropB` 		Decimal64(3) 		DEFAULT NULL,			-- write back drop GB (byte) since last counter reset
  `WritebackDroTotalB` 	Decimal64(3) 		DEFAULT NULL,			-- write back drop GB (byte) total droped regardless of counter reset
  `CPULoad` 			Decimal32(3) 		DEFAULT NULL,			-- CPU load
  `SerialNo` 			String 				DEFAULT NULL,			-- serial number
  `PortConfig` 			String 				DEFAULT NULL,			-- power config
  `Version` 			String 				DEFAULT NULL,			-- version
  `CacheSize` 			Float32 			DEFAULT NULL,			-- total size of the cache 
  `StoreSize` 			Float32 			DEFAULT NULL,			-- total size of the writeback storage 
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.power (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 		String 				DEFAULT NULL,			-- subsystem
  `timestamp` 		DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `PSU0_Status` 	Bool 				DEFAULT NULL,			-- power supply 0 enable true/false
  `PSU1_Status` 	Bool 				DEFAULT NULL,			-- power supply 1 enable true/false
  `PSU_PowerWatt` 	Decimal32(3) 		DEFAULT NULL,			-- power usage (watt)
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.capture (
  `t` 					DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 				String 				DEFAULT NULL,			-- hostname
  `facility` 			String 				DEFAULT NULL,			-- facility 
  `facility-num` 		String 				DEFAULT NULL,			-- facility number
  `severity` 			String 				DEFAULT NULL,			-- serverity
  `severity-num` 		String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 			String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 			String 				DEFAULT NULL,			-- subsystem
  `timestamp` 			DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `CaptureEnb` 			Bool 				DEFAULT NULL,			-- capture enable true/false
  `CapturePkt` 			Decimal128(0) 		DEFAULT NULL,			-- capture total packet
  `CaptureByte` 		Decimal128(0) 		DEFAULT NULL,			-- capture total byte
  `CaptureDrop` 		Decimal128(0) 		DEFAULT NULL,			-- capture total drop
  `CaptureFCSError` 		Decimal128(0) 		DEFAULT NULL,			-- capture FCS error
  `CaptureRateGbps` 		Float32(6) 		DEFAULT NULL,			-- capture speed gbps (bit)
  `CaptureRateMpps` 	Float32(6) 		DEFAULT NULL,  			-- capture packet speed mpps (packet)
  `CaptureName` 		String 				DEFAULT NULL,			-- capture name
  `CapturePort0_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 0 byte
  `CapturePort0_Pkt` 	Decimal128(0) 		DEFAULT NULL,			-- capture 0 packet
  `CapturePort1_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 1 byte
  `CapturePort1_Pkt` 	Decimal128(0) 		DEFAULT NULL,  			-- capture 1 packet
  `CapturePort2_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 2 byte
  `CapturePort2_Pkt` 	Decimal128(0) 		DEFAULT NULL,			-- capture 2 packet
  `CapturePort3_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 3 byte
  `CapturePort3_Pkt` 	Decimal128(0) 		DEFAULT NULL,			-- capture 3 packet
  `CapturePort4_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 4 byte
  `CapturePort4_Pkt` 	Decimal128(0) 		DEFAULT NULL,			-- capture 4 packet
  `CapturePort5_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 5 byte
  `CapturePort5_Pkt` 	Decimal128(0) 		DEFAULT NULL,			-- capture 5 packet
  `CapturePort6_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 6 byte
  `CapturePort6_Pkt` 	Decimal128(0) 		DEFAULT NULL,			-- capture 6 packet
  `CapturePort7_Byte` 	Decimal128(0) 		DEFAULT NULL,			-- capture 7 byte
  `CapturePort7_Pkt` 	Decimal128(0) 		DEFAULT NULL,			-- capture 7 packet
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;


CREATE TABLE fmadio.io (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 		String 				DEFAULT NULL,			-- subsystem
  `timestamp` 		DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `DiskRdGbps` 		Decimal64(3) 		DEFAULT NULL,			-- disk read gbps (bit)
  `DiskWrGbps` 		Decimal64(3) 		DEFAULT NULL,			-- disk write gbps (bit)
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;


CREATE TABLE fmadio.link (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 		String 				DEFAULT NULL,			-- subsystem
  `timestamp` 		DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `cap0_link` 		Bool 				DEFAULT NULL,			-- capture 0 link up true/false
  `cap1_link` 		Bool 				DEFAULT NULL,			-- capture 1 link up true/false
  `cap2_link` 		Bool 				DEFAULT NULL,			-- capture 2 link up true/false
  `cap3_link` 		Bool 				DEFAULT NULL,			-- capture 3 link up true/false
  `cap4_link` 		Bool 				DEFAULT NULL,			-- capture 4 link up true/false
  `cap5_link` 		Bool 				DEFAULT NULL,			-- capture 5 link up true/false
  `cap6_link` 		Bool 				DEFAULT NULL,			-- capture 6 link up true/false
  `cap7_link` 		Bool 				DEFAULT NULL,			-- capture 7 link up true/false
  `man0_link` 		Bool 				DEFAULT NULL,			-- man0 link up true/false
  `man10_link` 		Bool 				DEFAULT NULL,			-- man10 link up true/false
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.fan (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 		String 				DEFAULT NULL,			-- subsystem
  `timestamp` 		DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `Fan_SYS0` 		Decimal32(3) 		DEFAULT NULL,			-- fan0 speed
  `Fan_SYS1` 		Decimal32(3) 		DEFAULT NULL,			-- fan1 speed
  `Fan_SYS2` 		Decimal32(3) 		DEFAULT NULL,			-- fan2 speed
  `Fan_SYS3` 		Decimal32(3) 		DEFAULT NULL,			-- fan3 speed
  `Fan_SYS4` 		Decimal32(3) 		DEFAULT NULL,			-- fan4 speed
  `Fan_SYS5` 		Decimal32(3) 		DEFAULT NULL,			-- fan5 speed
  `Fan_SYS6` 		Decimal32(3) 		DEFAULT NULL,			-- fan6 speed
  `Fan_SYS7` 		Decimal32(3) 		DEFAULT NULL,			-- fan7 speed
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.disk (
  `t` 						DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 					String 				DEFAULT NULL,			-- hostname
  `facility` 				String 				DEFAULT NULL,			-- facility 
  `facility-num` 			String 				DEFAULT NULL,			-- facility number
  `severity` 				String 				DEFAULT NULL,			-- serverity
  `severity-num` 			String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 				String 				DEFAULT NULL,			-- syslog tag
  `module` 					String 				DEFAULT NULL,			-- module
  `subsystem` 				String 				DEFAULT NULL,			-- subsystem
  `timestamp` 				DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `FreeGB_System` 			Decimal64(3) 		DEFAULT NULL,			-- disk space free on system
  `FreeGB_Store0` 			Decimal64(3) 		DEFAULT NULL,			-- disk space free on store0
  `FreeGB_Store1` 			Decimal64(3) 		DEFAULT NULL,			-- disk space free on store1
  `FreeGB_Remote0` 			Decimal64(3) 		DEFAULT NULL,			-- disk space free on remote0
  `FreeGB_Remote1` 			Decimal64(3) 		DEFAULT NULL,			-- disk space free on remote1
  `DiskPresent_os0` 		Bool 				DEFAULT NULL,			-- disk present os0
  `DiskPresent_ssd0` 		Bool 				DEFAULT NULL,			-- disk present ssd0
  `DiskPresent_ssd1` 		Bool 				DEFAULT NULL,			-- disk present ssd1
  `DiskPresent_ssd2` 		Bool 				DEFAULT NULL,			-- disk present ssd2
  `DiskPresent_ssd3` 		Bool 				DEFAULT NULL,			-- disk present ssd3
  `DiskPresent_ssd4` 		Bool 				DEFAULT NULL,			-- disk present ssd4
  `DiskPresent_ssd5` 		Bool 				DEFAULT NULL,			-- disk present ssd5
  `DiskPresent_ssd6` 		Bool 				DEFAULT NULL,			-- disk present ssd6
  `DiskPresent_ssd7` 		Bool 				DEFAULT NULL,			-- disk present ssd7
  `DiskPresent_ssd8` 		Bool 				DEFAULT NULL,			-- disk present ssd8
  `DiskPresent_ssd9` 		Bool 				DEFAULT NULL,			-- disk present ssd9
  `DiskPresent_ssd10` 		Bool 				DEFAULT NULL,			-- disk present ssd10
  `DiskPresent_ssd11` 		Bool 				DEFAULT NULL,			-- disk present ssd11
  `DiskPresent_ssd12` 		Bool 				DEFAULT NULL,			-- disk present ssd12
  `DiskPresent_ssd13` 		Bool 				DEFAULT NULL,			-- disk present ssd13
  `DiskPresent_ssd14` 		Bool 				DEFAULT NULL,			-- disk present ssd14
  `DiskPresent_ssd15` 		Bool 				DEFAULT NULL,			-- disk present ssd15
  `DiskPresent_ssd16` 		Bool 				DEFAULT NULL,			-- disk present ssd16
  `DiskPresent_ssd17` 		Bool 				DEFAULT NULL,			-- disk present ssd17
  `DiskPresent_ssd18` 		Bool 				DEFAULT NULL,			-- disk present ssd18
  `DiskPresent_ssd19` 		Bool 				DEFAULT NULL,			-- disk present ssd19
  `DiskPresent_ssd20` 		Bool 				DEFAULT NULL,			-- disk present ssd20
  `DiskPresent_ssd21` 		Bool 				DEFAULT NULL,			-- disk present ssd21
  `DiskPresent_ssd22` 		Bool 				DEFAULT NULL,			-- disk present ssd22
  `DiskPresent_ssd23` 		Bool 				DEFAULT NULL,			-- disk present ssd23
  `DiskPresent_ssd24` 		Bool 				DEFAULT NULL,			-- disk present ssd24
  `DiskPresent_ssd25` 		Bool 				DEFAULT NULL,			-- disk present ssd25
  `DiskPresent_ssd26` 		Bool 				DEFAULT NULL,			-- disk present ssd26
  `DiskPresent_ssd27` 		Bool 				DEFAULT NULL,			-- disk present ssd27
  `DiskPresent_ssd28` 		Bool 				DEFAULT NULL,			-- disk present ssd28
  `DiskPresent_ssd29` 		Bool 				DEFAULT NULL,			-- disk present ssd29
  `DiskPresent_ssd30` 		Bool 				DEFAULT NULL,			-- disk present ssd30
  `DiskPresent_ssd31` 		Bool 				DEFAULT NULL,			-- disk present ssd31
  `DiskPresent_hdd0` 		Bool 				DEFAULT NULL,			-- disk present hdd0
  `DiskPresent_hdd1` 		Bool 				DEFAULT NULL,			-- disk present hdd1
  `DiskPresent_hdd2` 		Bool 				DEFAULT NULL,			-- disk present hdd2
  `DiskPresent_hdd3` 		Bool 				DEFAULT NULL,			-- disk present hdd3
  `DiskPresent_hdd4` 		Bool 				DEFAULT NULL,			-- disk present hdd4
  `DiskPresent_hdd5` 		Bool 				DEFAULT NULL,			-- disk present hdd5
  `DiskPresent_hdd6` 		Bool 				DEFAULT NULL,			-- disk present hdd6
  `DiskPresent_hdd7` 		Bool 				DEFAULT NULL,			-- disk present hdd7
  `DiskPresent_hdd8` 		Bool 				DEFAULT NULL,			-- disk present hdd8
  `DiskPresent_hdd9` 		Bool 				DEFAULT NULL,			-- disk present hdd9
  `DiskPresent_hdd10` 		Bool 				DEFAULT NULL,			-- disk present hdd10
  `DiskPresent_hdd11` 		Bool 				DEFAULT NULL,			-- disk present hdd11
  `DiskPresent_hdd12` 		Bool 				DEFAULT NULL,			-- disk present hdd12
  `DiskPresent_hdd13` 		Bool 				DEFAULT NULL,			-- disk present hdd13
  `DiskPresent_hdd14` 		Bool 				DEFAULT NULL,			-- disk present hdd14
  `DiskPresent_hdd15` 		Bool 				DEFAULT NULL,			-- disk present hdd15
  `DiskPresent_hdd16` 		Bool 				DEFAULT NULL,			-- disk present hdd16
  `DiskPresent_hdd17` 		Bool 				DEFAULT NULL,			-- disk present hdd17
  `DiskPresent_hdd18` 		Bool 				DEFAULT NULL,			-- disk present hdd18
  `DiskPresent_hdd19` 		Bool 				DEFAULT NULL,			-- disk present hdd19
  `DiskPresent_hdd20` 		Bool 				DEFAULT NULL,			-- disk present hdd20
  `DiskPresent_hdd21` 		Bool 				DEFAULT NULL,			-- disk present hdd21
  `DiskPresent_hdd22` 		Bool 				DEFAULT NULL,			-- disk present hdd22
  `DiskPresent_hdd23` 		Bool 				DEFAULT NULL,			-- disk present hdd23
  `DiskPresent_hdd24` 		Bool 				DEFAULT NULL,			-- disk present hdd24
  `DiskPresent_hdd25` 		Bool 				DEFAULT NULL,			-- disk present hdd25
  `DiskPresent_hdd26` 		Bool 				DEFAULT NULL,			-- disk present hdd26
  `DiskPresent_hdd27` 		Bool 				DEFAULT NULL,			-- disk present hdd27
  `DiskPresent_hdd28` 		Bool 				DEFAULT NULL,			-- disk present hdd28
  `DiskPresent_hdd29` 		Bool 				DEFAULT NULL,  			-- disk present hdd29
  `DiskPresent_hdd30` 		Bool 				DEFAULT NULL,			-- disk present hdd30
  `DiskPresent_hdd31` 		Bool 				DEFAULT NULL,			-- disk present hdd31
  `DiskPresent_scr0` 		Bool 				DEFAULT NULL,			-- disk present scr0
  `DiskPresent_scr1` 		Bool 				DEFAULT NULL,			-- disk present scr1
  `DiskPresent_scr2` 		Bool 				DEFAULT NULL,			-- disk present scr2
  `DiskPresent_scr3` 		Bool 				DEFAULT NULL,			-- disk present scr3
  `DiskPresent_scr4` 		Bool 				DEFAULT NULL,			-- disk present scr4
  `DiskPresent_scr5` 		Bool 				DEFAULT NULL,			-- disk present scr5
  `DiskPresent_scr6` 		Bool 				DEFAULT NULL,			-- disk present scr6
  `DiskPresent_scr7` 		Bool 				DEFAULT NULL,			-- disk present scr7
  `DiskPresent_par0` 		Bool 				DEFAULT NULL,			-- disk present par0
  `DiskPresent_par1` 		Bool 				DEFAULT NULL,			-- disk present par1
  `DiskTemperature_os0` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature os0
  `DiskTemperature_ssd0` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd0
  `DiskTemperature_ssd1` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd1
  `DiskTemperature_ssd2` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd2
  `DiskTemperature_ssd3` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd3
  `DiskTemperature_ssd4` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd4
  `DiskTemperature_ssd5` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd5
  `DiskTemperature_ssd6` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd6
  `DiskTemperature_ssd7` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd7
  `DiskTemperature_ssd8` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd8
  `DiskTemperature_ssd9` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd9
  `DiskTemperature_ssd10` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd10
  `DiskTemperature_ssd11` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd11
  `DiskTemperature_ssd12` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd12
  `DiskTemperature_ssd13` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd13
  `DiskTemperature_ssd14` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd14
  `DiskTemperature_ssd15` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd15
  `DiskTemperature_ssd16` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd16
  `DiskTemperature_ssd17` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd17
  `DiskTemperature_ssd18` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd18
  `DiskTemperature_ssd19` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd19
  `DiskTemperature_ssd20` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd20
  `DiskTemperature_ssd21` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd21
  `DiskTemperature_ssd22` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd22
  `DiskTemperature_ssd23` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd23
  `DiskTemperature_ssd24` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd24
  `DiskTemperature_ssd25` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd25
  `DiskTemperature_ssd26` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd26
  `DiskTemperature_ssd27` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd27
  `DiskTemperature_ssd28` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd28
  `DiskTemperature_ssd29` 	Decimal32(3) 		DEFAULT NULL,  			-- disk temperature ssd29
  `DiskTemperature_ssd30` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd30
  `DiskTemperature_ssd31` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature ssd31
  `DiskTemperature_hdd0` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd0
  `DiskTemperature_hdd1` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd1
  `DiskTemperature_hdd2` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd2
  `DiskTemperature_hdd3` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd3
  `DiskTemperature_hdd4` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd4
  `DiskTemperature_hdd5` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd5
  `DiskTemperature_hdd6` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd6
  `DiskTemperature_hdd7` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd7
  `DiskTemperature_hdd8` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd8
  `DiskTemperature_hdd9` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd9
  `DiskTemperature_hdd10` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd10
  `DiskTemperature_hdd11` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd11
  `DiskTemperature_hdd12` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd12
  `DiskTemperature_hdd13` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd13
  `DiskTemperature_hdd14` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd14
  `DiskTemperature_hdd15` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd15
  `DiskTemperature_hdd16` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd16
  `DiskTemperature_hdd17` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd17
  `DiskTemperature_hdd18` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd18
  `DiskTemperature_hdd19` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd19
  `DiskTemperature_hdd20` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd20
  `DiskTemperature_hdd21` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd21
  `DiskTemperature_hdd22` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd22
  `DiskTemperature_hdd23` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd23
  `DiskTemperature_hdd24` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd24
  `DiskTemperature_hdd25` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd25
  `DiskTemperature_hdd26` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd26
  `DiskTemperature_hdd27` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd27
  `DiskTemperature_hdd28` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd28
  `DiskTemperature_hdd29` 	Decimal32(3) 		DEFAULT NULL,  			-- disk temperature hdd29
  `DiskTemperature_hdd30` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd30
  `DiskTemperature_hdd31` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature hdd31
  `DiskTemperature_scr0` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr0
  `DiskTemperature_scr1` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr1
  `DiskTemperature_scr2` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr2
  `DiskTemperature_scr3` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr3
  `DiskTemperature_scr4` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr4
  `DiskTemperature_scr5` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr5
  `DiskTemperature_scr6` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr6
  `DiskTemperature_scr7` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature scr7
  `DiskTemperature_par0` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature par0
  `DiskTemperature_par1` 	Decimal32(3) 		DEFAULT NULL,			-- disk temperature par1
  `DiskSMART_os0` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error os0
  `DiskSMART_ssd0` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd0
  `DiskSMART_ssd1` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd1
  `DiskSMART_ssd2` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd2
  `DiskSMART_ssd3` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd3
  `DiskSMART_ssd4` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd4
  `DiskSMART_ssd5` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd5
  `DiskSMART_ssd6` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd6
  `DiskSMART_ssd7` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd7
  `DiskSMART_ssd8` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd8
  `DiskSMART_ssd9` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd9
  `DiskSMART_ssd10` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd10
  `DiskSMART_ssd11` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd11
  `DiskSMART_ssd12` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd12
  `DiskSMART_ssd13` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd13
  `DiskSMART_ssd14` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd14
  `DiskSMART_ssd15` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd15
  `DiskSMART_ssd16` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd16
  `DiskSMART_ssd17` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd17
  `DiskSMART_ssd18` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd18
  `DiskSMART_ssd19` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd19
  `DiskSMART_ssd20` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd20
  `DiskSMART_ssd21` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd21
  `DiskSMART_ssd22` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd22
  `DiskSMART_ssd23` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd23
  `DiskSMART_ssd24` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd24
  `DiskSMART_ssd25` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd25
  `DiskSMART_ssd26` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd26
  `DiskSMART_ssd27` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd27
  `DiskSMART_ssd28` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd28
  `DiskSMART_ssd29` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd29
  `DiskSMART_ssd30` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd30
  `DiskSMART_ssd31` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error ssd31
  `DiskSMART_hdd0` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd0
  `DiskSMART_hdd1` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd1
  `DiskSMART_hdd2` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd2
  `DiskSMART_hdd3` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd3
  `DiskSMART_hdd4` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd4
  `DiskSMART_hdd5` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd5
  `DiskSMART_hdd6` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd6
  `DiskSMART_hdd7` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd7
  `DiskSMART_hdd8` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd8
  `DiskSMART_hdd9` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd9
  `DiskSMART_hdd10` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd10
  `DiskSMART_hdd11` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd11
  `DiskSMART_hdd12` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd12
  `DiskSMART_hdd13` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd13
  `DiskSMART_hdd14` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd14
  `DiskSMART_hdd15` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd15
  `DiskSMART_hdd16` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd16
  `DiskSMART_hdd17` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd17
  `DiskSMART_hdd18` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd18
  `DiskSMART_hdd19` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd19
  `DiskSMART_hdd20` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd20
  `DiskSMART_hdd21` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd21
  `DiskSMART_hdd22` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd22
  `DiskSMART_hdd23` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd23
  `DiskSMART_hdd24` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd24
  `DiskSMART_hdd25` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd25
  `DiskSMART_hdd26` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd26
  `DiskSMART_hdd27` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd27
  `DiskSMART_hdd28` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd28
  `DiskSMART_hdd29` 		Decimal32(3) 		DEFAULT NULL,  			-- disk smart error hdd29
  `DiskSMART_hdd30` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd30
  `DiskSMART_hdd31` 		Decimal32(3) 		DEFAULT NULL,			-- disk smart error hdd31
  `DiskSMART_scr0` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr0
  `DiskSMART_scr1` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr1
  `DiskSMART_scr2` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr2
  `DiskSMART_scr3` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr3
  `DiskSMART_scr4` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr4
  `DiskSMART_scr5` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr5
  `DiskSMART_scr6` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr6
  `DiskSMART_scr7` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error scr7
  `DiskSMART_par0` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error par0
  `DiskSMART_par1` 			Decimal32(3) 		DEFAULT NULL,			-- disk smart error par1
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;



CREATE TABLE fmadio.cat (
  `t` 						DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 					String 				DEFAULT NULL,			-- hostname
  `facility` 				String 				DEFAULT NULL,			-- facility 
  `facility-num` 			String 				DEFAULT NULL,			-- facility number
  `severity` 				String 				DEFAULT NULL,			-- serverity
  `severity-num` 			String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 				String 				DEFAULT NULL,			-- syslog tag
  `module` 					String 				DEFAULT NULL,			-- module
  `subsystem` 				String 				DEFAULT NULL,			-- subsystem
  `timestamp` 				DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `cat_0_Enable` 			Bool 				DEFAULT NULL,			-- cat 0 enable/disable
  `cat_0_Mode` 				String 				DEFAULT NULL,			-- cat 0 mode
  `cat_0_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 0 CPU usage
  `cat_0_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 0 PCAP timestamp
  `cat_0_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 0 PCAP latency
  `cat_0_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 0 read packets
  `cat_0_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 0 read bytes
  `cat_0_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 0 total read packets
  `cat_0_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 0 total read bytes
  `cat_0_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 0 read speed gbps (bit)
  `cat_0_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 0 read packet mpps (packet)
  `cat_0_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 0 write packets
  `cat_0_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 0 write bytes
  `cat_0_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 0 total write packets
  `cat_0_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 0 total write bytes
  `cat_0_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 0 write speed gbps (bits)
  `cat_0_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 0 write packet mpps (packet)
  `cat_0_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 0 pending byte
  `cat_0_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 0 packet discard
  `cat_0_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 0 total packet discard
  `cat_0_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 0 packet slice
  `cat_0_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 0 io priority
  `cat_0_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 0 chunk id
  `cat_0_CmdLine` 			String 				DEFAULT NULL,			-- cat 0 command line
  `cat_0_StreamName` 		String 				DEFAULT NULL,			-- cat 0 stream name
  `cat_0_FilterBPF` 		String 				DEFAULT NULL,			-- cat 0 BPF filter
  `cat_0_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 0 CPU idle
  `cat_0_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 0 CPU fetch
  `cat_0_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 0 CPU process
  `cat_0_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 0 CPU send
  `cat_1_Enable` 			Bool 				DEFAULT NULL,			-- cat 1 enable/disable
  `cat_1_Mode` 				String 				DEFAULT NULL,			-- cat 1 mode
  `cat_1_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 1 CPU usage
  `cat_1_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 1 PCAP timestamp
  `cat_1_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 1 PCAP latency
  `cat_1_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 1 read packets
  `cat_1_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 1 read bytes
  `cat_1_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 1 total read packets
  `cat_1_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 1 total read bytes
  `cat_1_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 1 read speed gbps (bit)
  `cat_1_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 1 read packet mpps (packet)
  `cat_1_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 1 write packets
  `cat_1_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 1 write bytes
  `cat_1_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 1 total write packets
  `cat_1_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 1 total write bytes
  `cat_1_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 1 write speed gbps (bits)
  `cat_1_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 1 write packet mpps (packet)
  `cat_1_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 1 pending byte
  `cat_1_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 1 packet discard
  `cat_1_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 1 total packet discard
  `cat_1_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 1 packet slice
  `cat_1_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 1 io priority
  `cat_1_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 1 chunk id
  `cat_1_CmdLine` 			String 				DEFAULT NULL,			-- cat 1 command line
  `cat_1_StreamName` 		String 				DEFAULT NULL,			-- cat 1 stream name
  `cat_1_FilterBPF` 		String 				DEFAULT NULL,			-- cat 1 BPF filter
  `cat_1_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 1 CPU idle
  `cat_1_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 1 CPU fetch
  `cat_1_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 1 CPU process
  `cat_1_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 1 CPU send  
  `cat_2_Enable` 			Bool 				DEFAULT NULL,			-- cat 2 enable/disable
  `cat_2_Mode` 				String 				DEFAULT NULL,			-- cat 2 mode
  `cat_2_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 2 CPU usage
  `cat_2_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 2 PCAP timestamp
  `cat_2_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 2 PCAP latency
  `cat_2_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 2 read packets
  `cat_2_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 2 read bytes
  `cat_2_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 2 total read packets
  `cat_2_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 2 total read bytes
  `cat_2_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 2 read speed gbps (bit)
  `cat_2_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 2 read packet mpps (packet)
  `cat_2_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 2 write packets
  `cat_2_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 2 write bytes
  `cat_2_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 2 total write packets
  `cat_2_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 2 total write bytes
  `cat_2_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 2 write speed gbps (bits)
  `cat_2_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 2 write packet mpps (packet)
  `cat_2_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 2 pending byte
  `cat_2_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 2 packet discard
  `cat_2_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 2 total packet discard
  `cat_2_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 2 packet slice
  `cat_2_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 2 io priority
  `cat_2_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 2 chunk id
  `cat_2_CmdLine` 			String 				DEFAULT NULL,			-- cat 2 command line
  `cat_2_StreamName` 		String 				DEFAULT NULL,			-- cat 2 stream name
  `cat_2_FilterBPF` 		String 				DEFAULT NULL,			-- cat 2 BPF filter
  `cat_2_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 2 CPU idle
  `cat_2_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 2 CPU fetch
  `cat_2_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 2 CPU process
  `cat_2_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 2 CPU send  
  `cat_3_Enable` 			Bool 				DEFAULT NULL,			-- cat 3 enable/disable
  `cat_3_Mode` 				String 				DEFAULT NULL,			-- cat 3 mode
  `cat_3_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 3 CPU usage
  `cat_3_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 3 PCAP timestamp
  `cat_3_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 3 PCAP latency
  `cat_3_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 3 read packets
  `cat_3_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 3 read bytes
  `cat_3_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 3 total read packets
  `cat_3_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 3 total read bytes
  `cat_3_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 3 read speed gbps (bit)
  `cat_3_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 3 read packet mpps (packet)
  `cat_3_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 3 write packets
  `cat_3_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 3 write bytes
  `cat_3_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 3 total write packets
  `cat_3_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 3 total write bytes
  `cat_3_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 3 write speed gbps (bits)
  `cat_3_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 3 write packet mpps (packet)
  `cat_3_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 3 pending byte
  `cat_3_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 3 packet discard
  `cat_3_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 3 total packet discard
  `cat_3_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 3 packet slice
  `cat_3_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 3 io priority
  `cat_3_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 3 chunk id
  `cat_3_CmdLine` 			String 				DEFAULT NULL,			-- cat 3 command line
  `cat_3_StreamName` 		String 				DEFAULT NULL,			-- cat 3 stream name
  `cat_3_FilterBPF` 		String 				DEFAULT NULL,			-- cat 3 BPF filter
  `cat_3_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 3 CPU idle
  `cat_3_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 3 CPU fetch
  `cat_3_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 3 CPU process
  `cat_3_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 3 CPU send
  `cat_4_Enable` 			Bool 				DEFAULT NULL,			-- cat 4 enable/disable
  `cat_4_Mode` 				String 				DEFAULT NULL,			-- cat 4 mode
  `cat_4_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 4 CPU usage
  `cat_4_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 4 PCAP timestamp
  `cat_4_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 4 PCAP latency
  `cat_4_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 4 read packets
  `cat_4_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 4 read bytes
  `cat_4_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 4 total read packets
  `cat_4_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 4 total read bytes
  `cat_4_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 4 read speed gbps (bit)
  `cat_4_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 4 read packet mpps (packet)
  `cat_4_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 4 write packets
  `cat_4_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 4 write bytes
  `cat_4_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 4 total write packets
  `cat_4_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 4 total write bytes
  `cat_4_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 4 write speed gbps (bits)
  `cat_4_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 4 write packet mpps (packet)
  `cat_4_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 4 pending byte
  `cat_4_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 4 packet discard
  `cat_4_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 4 total packet discard
  `cat_4_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 4 packet slice
  `cat_4_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 4 io priority
  `cat_4_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 4 chunk id
  `cat_4_CmdLine` 			String 				DEFAULT NULL,			-- cat 4 command line
  `cat_4_StreamName` 		String 				DEFAULT NULL,			-- cat 4 stream name
  `cat_4_FilterBPF` 		String 				DEFAULT NULL,			-- cat 4 BPF filter
  `cat_4_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 4 CPU idle
  `cat_4_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 4 CPU fetch
  `cat_4_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 4 CPU process
  `cat_4_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 4 CPU send
  `cat_5_Enable` 			Bool 				DEFAULT NULL,			-- cat 5 enable/disable
  `cat_5_Mode` 				String 				DEFAULT NULL,			-- cat 5 mode
  `cat_5_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 5 CPU usage
  `cat_5_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 5 PCAP timestamp
  `cat_5_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 5 PCAP latency
  `cat_5_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 5 read packets
  `cat_5_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 5 read bytes
  `cat_5_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 5 total read packets
  `cat_5_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 5 total read bytes
  `cat_5_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 5 read speed gbps (bit)
  `cat_5_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 5 read packet mpps (packet)
  `cat_5_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 5 write packets
  `cat_5_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 5 write bytes
  `cat_5_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 5 total write packets
  `cat_5_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 5 total write bytes
  `cat_5_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 5 write speed gbps (bits)
  `cat_5_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 5 write packet mpps (packet)
  `cat_5_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 5 pending byte
  `cat_5_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 5 packet discard
  `cat_5_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 5 total packet discard
  `cat_5_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 5 packet slice
  `cat_5_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 5 io priority
  `cat_5_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 5 chunk id
  `cat_5_CmdLine` 			String 				DEFAULT NULL,			-- cat 5 command line
  `cat_5_StreamName` 		String 				DEFAULT NULL,			-- cat 5 stream name
  `cat_5_FilterBPF` 		String 				DEFAULT NULL,			-- cat 5 BPF filter
  `cat_5_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 5 CPU idle
  `cat_5_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 5 CPU fetch
  `cat_5_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 5 CPU process
  `cat_5_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 5 CPU send
  `cat_6_Enable` 			Bool 				DEFAULT NULL,			-- cat 6 enable/disable
  `cat_6_Mode` 				String 				DEFAULT NULL,			-- cat 6 mode
  `cat_6_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 6 CPU usage
  `cat_6_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 6 PCAP timestamp
  `cat_6_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 6 PCAP latency
  `cat_6_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 6 read packets
  `cat_6_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 6 read bytes
  `cat_6_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 6 total read packets
  `cat_6_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 6 total read bytes
  `cat_6_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 6 read speed gbps (bit)
  `cat_6_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 6 read packet mpps (packet)
  `cat_6_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 6 write packets
  `cat_6_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 6 write bytes
  `cat_6_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 6 total write packets
  `cat_6_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 6 total write bytes
  `cat_6_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 6 write speed gbps (bits)
  `cat_6_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 6 write packet mpps (packet)
  `cat_6_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 6 pending byte
  `cat_6_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 6 packet discard
  `cat_6_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 6 total packet discard
  `cat_6_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 6 packet slice
  `cat_6_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 6 io priority
  `cat_6_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 6 chunk id
  `cat_6_CmdLine` 			String 				DEFAULT NULL,			-- cat 6 command line
  `cat_6_StreamName` 		String 				DEFAULT NULL,			-- cat 6 stream name
  `cat_6_FilterBPF` 		String 				DEFAULT NULL,			-- cat 6 BPF filter
  `cat_6_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 6 CPU idle
  `cat_6_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 6 CPU fetch
  `cat_6_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 6 CPU process
  `cat_6_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 6 CPU send
  `cat_7_Enable` 			Bool 				DEFAULT NULL,			-- cat 7 enable/disable
  `cat_7_Mode` 				String 				DEFAULT NULL,			-- cat 7 mode
  `cat_7_CPUMain` 			Decimal32(3) 		DEFAULT NULL,			-- cat 7 CPU usage
  `cat_7_TSPCAP` 			UInt64 				DEFAULT NULL,			-- cat 7 PCAP timestamp
  `cat_7_PCAPLatency` 		Decimal32(3) 		DEFAULT NULL,			-- cat 7 PCAP latency
  `cat_7_ReadPkt` 			UInt64 				DEFAULT NULL,			-- cat 7 read packets
  `cat_7_ReadByte` 			UInt64 				DEFAULT NULL,			-- cat 7 read bytes
  `cat_7_ReadTotalPkt` 		UInt64 				DEFAULT NULL,			-- cat 7 total read packets
  `cat_7_ReadTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 7 total read bytes
  `cat_7_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 7 read speed gbps (bit)
  `cat_7_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat 7 read packet mpps (packet)
  `cat_7_WritePkt` 			UInt64 				DEFAULT NULL,			-- cat 7 write packets
  `cat_7_WriteByte` 		UInt64 				DEFAULT NULL,			-- cat 7 write bytes
  `cat_7_WriteTotalPkt` 	UInt64 				DEFAULT NULL,			-- cat 7 total write packets
  `cat_7_WriteTotalByte` 	UInt64 				DEFAULT NULL,			-- cat 7 total write bytes
  `cat_7_WriteGbps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 7 write speed gbps (bits)
  `cat_7_WriteMpps` 		Decimal32(6) 		DEFAULT NULL,			-- cat 7 write packet mpps (packet)
  `cat_7_PendingByte` 		UInt64 				DEFAULT NULL,			-- cat 7 pending byte
  `cat_7_PktDiscard` 		UInt64 				DEFAULT NULL,			-- cat 7 packet discard
  `cat_7_PktDiscardTotal` 	UInt64 				DEFAULT NULL,			-- cat 7 total packet discard
  `cat_7_PktSlice` 			UInt64 				DEFAULT NULL,			-- cat 7 packet slice
  `cat_7_IOPriority` 		UInt32 				DEFAULT NULL,			-- cat 7 io priority
  `cat_7_ChunkID` 			UInt32 				DEFAULT NULL,			-- cat 7 chunk id
  `cat_7_CmdLine` 			String 				DEFAULT NULL,			-- cat 7 command line
  `cat_7_StreamName` 		String 				DEFAULT NULL,			-- cat 7 stream name
  `cat_7_FilterBPF` 		String 				DEFAULT NULL,			-- cat 7 BPF filter
  `cat_7_CPUIdle` 			Decimal32(4) 		DEFAULT NULL,			-- cat 7 CPU idle
  `cat_7_CPUFetch` 			Decimal32(4) 		DEFAULT NULL,			-- cat 7 CPU fetch
  `cat_7_CPUProcess` 		Decimal32(4) 		DEFAULT NULL,			-- cat 7 CPU process
  `cat_7_CPUSend` 			Decimal32(4) 		DEFAULT NULL,			-- cat 7 CPU send  
  `cat_EnableCnt` 			Decimal32(3) 		DEFAULT NULL,			-- cat total enable count
  `cat_ReadPkt` 			Decimal64(3) 		DEFAULT NULL,			-- cat read packets
  `cat_ReadByte` 			Decimal64(3) 		DEFAULT NULL,			-- cat read bytes
  `cat_ReadTotalPkt` 		Decimal64(3) 		DEFAULT NULL,			-- cat total read packet
  `cat_ReadTotalByte` 		Decimal64(3) 		DEFAULT NULL,			-- cat total read byte
  `cat_ReadGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat read speed gbps (bit)
  `cat_ReadMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat read packet mpps (packet)
  `cat_WritePkt` 			Decimal64(3) 		DEFAULT NULL,			-- cat write packet
  `cat_WriteByte` 			Decimal64(3) 		DEFAULT NULL,			-- cat write byte
  `cat_WriteTotalPkt` 		Decimal64(3) 		DEFAULT NULL,			-- cat total write packet
  `cat_WriteTotalByte` 		Decimal64(3) 		DEFAULT NULL,			-- cat total write byte
  `cat_WriteGbps` 			Decimal32(6) 		DEFAULT NULL,			-- cat write speed gbps (bit)
  `cat_WriteMpps` 			Decimal32(6) 		DEFAULT NULL,			-- cat write packet mpps (packet)
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;



CREATE TABLE fmadio.voip (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 		String 				DEFAULT NULL,			-- subsystem
  `timestamp` 		DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `event` 			String 				DEFAULT NULL,  			-- voip event
  `callid` 			String 				DEFAULT NULL,  			-- voip caller id
  `from` 			String 				DEFAULT NULL,  			-- voip from
  `ipdst` 			String 				DEFAULT NULL,  			-- voip ip destination
  `ipsrc` 			String 				DEFAULT NULL,  			-- voip ip source
  `location` 		String 				DEFAULT NULL,  			-- voip location
  `portdst` 		UInt16 				DEFAULT NULL,  			-- voip port destination
  `portsrc` 		UInt16 				DEFAULT NULL,  			-- voip port source
  `to` 				String 				DEFAULT NULL,  			-- voip to
  `verb` 			String 				DEFAULT NULL,  			-- voip verb
  `bps` 			UInt64 				DEFAULT NULL,  			-- voip bit per secound (bit)
  `pps` 			UInt64 				DEFAULT NULL,  			-- voip packet per secound (packet)
  `totalByte` 		UInt64 				DEFAULT NULL  			-- voip total byte (byte)
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;


CREATE TABLE fmadio.pcap2json_stat (
  `t` 					DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 				String 				DEFAULT NULL,			-- hostname
  `facility` 			String 				DEFAULT NULL,			-- facility 
  `facility-num` 		String 				DEFAULT NULL,			-- facility number
  `severity` 			String 				DEFAULT NULL,			-- serverity
  `severity-num` 		String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 			String 				DEFAULT NULL,			-- syslog tag
  `module` 				String 				DEFAULT NULL,			-- module
  `subsystem` 			String 				DEFAULT NULL,			-- subsystem
  `timestamp` 			DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `IsUp_Backend` 		Bool 				DEFAULT NULL,			-- pcap2json backend up true/false
  `IsUp_stream_cat` 	Bool 				DEFAULT NULL,			-- pcap2json stream cat up true/false
  `IsUp_Frontend` 		Bool 				DEFAULT NULL,			-- pcap2json frontend up true/false
  `FE1_Gbps` 			Float32	 			DEFAULT NULL,			-- pcap2json frontend speed gbps (bit)
  `FE1_Klps` 			Float32		 		DEFAULT NULL,			-- pcap2json frontend Kline per secound 
  `PCAPPendingByte` 	UInt64 				DEFAULT NULL,			-- pcap2json PCAP pending byte
  `BE_LagSec` 			UInt32 				DEFAULT NULL,			-- pcap2json backend lag (secound)
  `BE_dT` 				Decimal32(6) 		DEFAULT NULL,			-- pcap2json
  `BE_dGB` 				Decimal32(6) 		DEFAULT NULL,			-- pcap2json
  `BE_FlowPerSnapshot` 	UInt32 				DEFAULT NULL,			-- pcap2json backend flow per snapshot
  `BE_Gbps` 			Float32		 		DEFAULT NULL,			-- pcap2json backend speed gbps (bit)
  `BE_Mpps` 			Float32		 		DEFAULT NULL,			-- pcap2json backend speed packet 
  `ES_PushCnt` 			UInt64 				DEFAULT NULL,			-- pcap2json elastic push count
  `ES_Error` 			UInt32 				DEFAULT NULL,			-- pcap2json elastic error count
  `ES_DocCnt` 			UInt64 				DEFAULT NULL,			-- pcap2json elastic document count
  `ES_DocsPerSecK` 		Decimal64(3) 		DEFAULT NULL,			-- pcap2json elastic document per secound
  `Watchdog_Error` 		String 				DEFAULT NULL,			-- pcap2json watchdog error
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.push_pcap (
  `t` 					DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 				String 				DEFAULT NULL,			-- hostname
  `facility` 			String 				DEFAULT NULL,			-- facility 
  `facility-num` 		String 				DEFAULT NULL,			-- facility number
  `severity` 			String 				DEFAULT NULL,			-- serverity
  `severity-num` 		String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 			String 				DEFAULT NULL,			-- syslog tag
  `module` 				String 				DEFAULT NULL,			-- module
  `subsystem` 			String 				DEFAULT NULL,			-- subsystem
  `timestamp` 			DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `Process` 			String 				DEFAULT NULL,			-- push_pcap process
  `IsUp` 				Bool 				DEFAULT NULL,			-- push_pcap up true/false
  `Splits` 				UInt16 				DEFAULT NULL,			-- push_pcap splits
  `TotalByte` 			UInt64 				DEFAULT NULL,			-- push_pcap total byte
  `TotalPkt` 			UInt64 				DEFAULT NULL,			-- push_pcap total packet
  `TransferMbps` 		Float32 			DEFAULT NULL,			-- push_pcap transfer speed mbps (bit)
  `PCAPTS` 				Int64 				DEFAULT NULL,			-- push_pcap PCAP timestamp
  `FilterBPF` 			String 				DEFAULT NULL,			-- push_pcap filter BPF
  `FilterFrame` 		String 				DEFAULT NULL,			-- push_pcap filter name
  `Target` 				String 				DEFAULT NULL,			-- push_pcap target
  `filename` 			String 				DEFAULT NULL,			-- push_pcap_split filename
  `Byte` 				UInt64 				DEFAULT NULL,			-- push_pcap_split byte
  `Pkt` 				UInt64 				DEFAULT NULL,			-- push_pcap_split packet
  `TimeWall` 			Float32	 			DEFAULT NULL,			-- push_pcap_split time wall (in seconds)
  `TimePCAP` 			Float32 			DEFAULT NULL,			-- push_pcap_split time pcap (in seconds)
  `TimeBoundary` 		Float32 			DEFAULT NULL,			-- push_pcap_split time boundary (in seconds)
  `PCAPBoundaryTSStart`	Float32 			DEFAULT NULL,			-- push_pcap_split start of the time boundary (in nano)
  `PCAPBoundaryTSEnd`	Float32 			DEFAULT NULL,			-- push_pcap_split end of the time boundary (in nano)
  `PCAPTSStart`			Float32 			DEFAULT NULL,			-- push_pcap_split ts of the first pcap in the split (in nano)
  `PCAPTSEnd`			Float32 			DEFAULT NULL,			-- push_pcap_split ts of the last pcap in the split (in nano)

)

ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;

CREATE TABLE fmadio.indexer (
  `t` 				DateTime NOT NULL 	DEFAULT now(),			-- local system timestamp
  `host` 			String 				DEFAULT NULL,			-- hostname
  `facility` 		String 				DEFAULT NULL,			-- facility 
  `facility-num` 	String 				DEFAULT NULL,			-- facility number
  `severity` 		String 				DEFAULT NULL,			-- serverity
  `severity-num` 	String 				DEFAULT NULL,			-- serverity number
  `syslogtag` 		String 				DEFAULT NULL,			-- syslog tag
  `module` 			String 				DEFAULT NULL,			-- module
  `subsystem` 		String 				DEFAULT NULL,			-- subsystem
  `timestamp` 		DateTime 			DEFAULT NULL,			-- message timestamp GMT time
  `IsUpCat` 		Bool 				DEFAULT NULL,			-- indexer cat is up true/false
  `IsUpIndex` 		Bool 				DEFAULT NULL,			-- indexer index is up true/false
  `TotalIndex` 		UInt64 				DEFAULT NULL,			-- indexer total index
  `TotalByte` 		UInt64 				DEFAULT NULL,			-- indexer total byte
  `TransferMbps` 	Decimal64(6) 		DEFAULT NULL,			-- indexer transger mbps (bit)
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;


CREATE TABLE fmadio.push_pcap_split (
  `t` 					DateTime NOT NULL 	DEFAULT now(),		-- local system timestamp
  `host` 				String 				DEFAULT NULL,		-- hostname
  `facility` 			String 				DEFAULT NULL,		-- facility 
  `facility-num` 		String 				DEFAULT NULL,		-- facility number
  `severity` 			String 				DEFAULT NULL,		-- serverity
  `severity-num` 		String 				DEFAULT NULL,		-- serverity number
  `syslogtag` 			String 				DEFAULT NULL,		-- syslog tag
  `module` 				String 				DEFAULT NULL,		-- module
  `subsystem` 			String 				DEFAULT NULL,		-- subsystem
  `timestamp` 			DateTime 			DEFAULT NULL,		-- message timestamp GMT time
  `filename` 			String 				DEFAULT NULL,		-- push_pcap_split filename
  `Bytes` 				UInt64 				DEFAULT NULL,		-- push_pcap_split byte
  `Pkt` 				UInt64 				DEFAULT NULL,		-- push_pcap_split packet
  `TimeWall` 			Float32	 			DEFAULT NULL,		-- push_pcap_split time wall (in seconds)
  `TimePCAP` 			Float32 			DEFAULT NULL,		-- push_pcap_split time pcap (in seconds)
  `TimeBoundary` 		Float32 			DEFAULT NULL,		-- push_pcap_split time boundary (in seconds)
  `PCAPBoundaryTSStart`	Float32 			DEFAULT NULL,		-- push_pcap_split start of the time boundary (in nano)
  `PCAPBoundaryTSEnd`	Float32 			DEFAULT NULL,		-- push_pcap_split end of the time boundary (in nano)
  `PCAPTSStart`			Float32 			DEFAULT NULL,		-- push_pcap_split ts of the first pcap in the split (in nano)
  `PCAPTSEnd`			Float32 			DEFAULT NULL,		-- push_pcap_split ts of the last pcap in the split (in nano)
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;


CREATE TABLE fmadio.alert (
  `t`                   DateTime NOT NULL               DEFAULT now(),                  -- local system timestamp
  `host`                String                          DEFAULT NULL,                   -- hostname
  `facility`            String                          DEFAULT NULL,                   -- facility
  `facility-num`        String                          DEFAULT NULL,                   -- facility number
  `severity`            String                          DEFAULT NULL,                   -- serverity
  `severity-num`        String                          DEFAULT NULL,                   -- serverity number
  `syslogtag`           String                          DEFAULT NULL,                   -- syslog tag
  `module`              String                          DEFAULT NULL,                   -- module
  `subsystem`           String                          DEFAULT NULL,                   -- subsystem
  `timestamp`           DateTime                        DEFAULT NULL,                   -- message timestamp GMT time
  `Subject`             String                          DEFAULT NULL,                   -- alert subject
  `Message`             String                          DEFAULT NULL,                   -- alert message
  `PSU0`                Bool                            DEFAULT NULL,                   -- psu0 status
  `PSU1`                Bool                            DEFAULT NULL,                   -- psu1 status
)
ENGINE = MergeTree
PARTITION BY toStartOfDay(`t`)
ORDER BY t;
