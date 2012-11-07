<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="XLXN_6" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="nMR" />
        <signal name="MTSTOFF" />
        <signal name="AUTOEN" />
        <signal name="EECOPY" />
        <signal name="BENDI" />
        <signal name="RAMEDC" />
        <signal name="BWID" />
        <signal name="Address(15:0)" />
        <signal name="BTYPE" />
        <signal name="WPOL" />
        <signal name="FAST_CLOCK" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13(7:0)" />
        <signal name="XLXN_14(7:0)" />
        <signal name="XLXN_15(7:0)" />
        <signal name="XLXN_16(7:0)" />
        <signal name="XLXN_17(15:0)" />
        <signal name="ALE" />
        <signal name="nWR" />
        <signal name="nRD" />
        <signal name="nIOM" />
        <signal name="IDATA(7:0)" />
        <signal name="HWAIT" />
        <signal name="nCE" />
        <signal name="nWE" />
        <signal name="nOE" />
        <signal name="DATA_CHIP(7:0)" />
        <signal name="HOLT_ADDR(15:0)" />
        <signal name="XLXN_19" />
        <signal name="XLXN_20" />
        <port polarity="Output" name="nMR" />
        <port polarity="Output" name="MTSTOFF" />
        <port polarity="Output" name="AUTOEN" />
        <port polarity="Output" name="EECOPY" />
        <port polarity="Output" name="BENDI" />
        <port polarity="Output" name="RAMEDC" />
        <port polarity="Output" name="BWID" />
        <port polarity="Input" name="Address(15:0)" />
        <port polarity="Output" name="BTYPE" />
        <port polarity="Output" name="WPOL" />
        <port polarity="Input" name="FAST_CLOCK" />
        <port polarity="Input" name="ALE" />
        <port polarity="Input" name="nWR" />
        <port polarity="Input" name="nRD" />
        <port polarity="Input" name="nIOM" />
        <port polarity="Output" name="IDATA(7:0)" />
        <port polarity="Input" name="HWAIT" />
        <port polarity="Output" name="nCE" />
        <port polarity="Output" name="nWE" />
        <port polarity="Output" name="nOE" />
        <port polarity="BiDirectional" name="DATA_CHIP(7:0)" />
        <port polarity="Output" name="HOLT_ADDR(15:0)" />
        <blockdef name="holt_initializer">
            <timestamp>2012-11-7T1:11:3</timestamp>
            <line x2="384" y1="480" y2="480" x1="320" />
            <line x2="384" y1="416" y2="416" x1="320" />
            <line x2="384" y1="288" y2="288" x1="320" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <line x2="0" y1="160" y2="160" x1="64" />
            <line x2="0" y1="224" y2="224" x1="64" />
            <line x2="384" y1="-544" y2="-544" x1="320" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="256" x="64" y="-576" height="1088" />
        </blockdef>
        <blockdef name="holt_mem_trans">
            <timestamp>2012-11-7T0:13:55</timestamp>
            <line x2="576" y1="736" y2="736" x1="512" />
            <line x2="576" y1="800" y2="800" x1="512" />
            <rect width="64" x="0" y="596" height="24" />
            <line x2="0" y1="608" y2="608" x1="64" />
            <rect width="64" x="0" y="660" height="24" />
            <line x2="0" y1="672" y2="672" x1="64" />
            <rect width="64" x="512" y="596" height="24" />
            <line x2="576" y1="608" y2="608" x1="512" />
            <rect width="64" x="512" y="660" height="24" />
            <line x2="576" y1="672" y2="672" x1="512" />
            <line x2="0" y1="480" y2="480" x1="64" />
            <line x2="0" y1="544" y2="544" x1="64" />
            <line x2="0" y1="224" y2="224" x1="64" />
            <line x2="0" y1="288" y2="288" x1="64" />
            <line x2="576" y1="160" y2="160" x1="512" />
            <line x2="576" y1="224" y2="224" x1="512" />
            <line x2="576" y1="288" y2="288" x1="512" />
            <rect width="64" x="512" y="404" height="24" />
            <line x2="576" y1="416" y2="416" x1="512" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="512" y="-44" height="24" />
            <line x2="576" y1="-32" y2="-32" x1="512" />
            <rect width="448" x="64" y="-64" height="896" />
        </blockdef>
        <blockdef name="MS1553_master">
            <timestamp>2012-11-7T0:10:50</timestamp>
            <line x2="0" y1="544" y2="544" x1="64" />
            <line x2="0" y1="608" y2="608" x1="64" />
            <line x2="0" y1="224" y2="224" x1="64" />
            <line x2="0" y1="288" y2="288" x1="64" />
            <line x2="0" y1="352" y2="352" x1="64" />
            <rect width="64" x="0" y="404" height="24" />
            <line x2="0" y1="416" y2="416" x1="64" />
            <rect width="64" x="0" y="468" height="24" />
            <line x2="0" y1="480" y2="480" x1="64" />
            <line x2="608" y1="224" y2="224" x1="544" />
            <rect width="64" x="544" y="276" height="24" />
            <line x2="608" y1="288" y2="288" x1="544" />
            <rect width="64" x="544" y="340" height="24" />
            <line x2="608" y1="352" y2="352" x1="544" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="608" y1="32" y2="32" x1="544" />
            <rect width="64" x="544" y="148" height="24" />
            <line x2="608" y1="160" y2="160" x1="544" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="608" y1="-416" y2="-416" x1="544" />
            <line x2="608" y1="-352" y2="-352" x1="544" />
            <line x2="608" y1="-288" y2="-288" x1="544" />
            <line x2="608" y1="-224" y2="-224" x1="544" />
            <rect width="64" x="544" y="-172" height="24" />
            <line x2="608" y1="-160" y2="-160" x1="544" />
            <rect width="480" x="64" y="-448" height="1088" />
        </blockdef>
        <blockdef name="MS1553_Reset_Pulse_Gen">
            <timestamp>2012-11-5T20:42:56</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <block symbolname="holt_initializer" name="XLXI_2">
            <blockpin signalname="XLXN_2" name="RESET" />
            <blockpin signalname="XLXN_6" name="IS_BIG_ENDIAN" />
            <blockpin signalname="XLXN_7" name="MEM_TEST_EN" />
            <blockpin signalname="XLXN_8" name="RAM_ERR_CORR_EN" />
            <blockpin signalname="nMR" name="nMR" />
            <blockpin signalname="MTSTOFF" name="MTSTOFF" />
            <blockpin signalname="AUTOEN" name="AUTOEN" />
            <blockpin signalname="EECOPY" name="EECOPY" />
            <blockpin signalname="BENDI" name="BENDI" />
            <blockpin signalname="RAMEDC" name="RAMEDC" />
            <blockpin signalname="BWID" name="BWID" />
            <blockpin signalname="BTYPE" name="BTYPE" />
            <blockpin signalname="WPOL" name="WPOL" />
        </block>
        <block symbolname="holt_mem_trans" name="XLXI_3">
            <blockpin signalname="XLXN_11" name="nRD" />
            <blockpin signalname="XLXN_12" name="nWR" />
            <blockpin signalname="FAST_CLOCK" name="clock" />
            <blockpin signalname="HWAIT" name="HWAIT" />
            <blockpin signalname="XLXN_17(15:0)" name="ADDRESS_IN(15:0)" />
            <blockpin signalname="XLXN_13(7:0)" name="DATA_IN_0(7:0)" />
            <blockpin signalname="XLXN_14(7:0)" name="DATA_IN_1(7:0)" />
            <blockpin signalname="DATA_CHIP(7:0)" name="DATA(7:0)" />
            <blockpin signalname="nOE" name="nOE" />
            <blockpin signalname="nWE" name="nWE" />
            <blockpin signalname="nCE" name="nCE" />
            <blockpin signalname="HOLT_ADDR(15:0)" name="ADDRESS_OUT(15:0)" />
            <blockpin signalname="XLXN_15(7:0)" name="DATA_RETURN_0(7:0)" />
            <blockpin signalname="XLXN_16(7:0)" name="DATA_RETURN_1(7:0)" />
            <blockpin signalname="XLXN_19" name="DATA_VALID_0" />
            <blockpin signalname="XLXN_20" name="DATA_VALID_1" />
        </block>
        <block symbolname="MS1553_master" name="XLXI_4">
            <blockpin signalname="ALE" name="ALE" />
            <blockpin signalname="nWR" name="nWR" />
            <blockpin signalname="nRD" name="nRD" />
            <blockpin signalname="nIOM" name="nIOM" />
            <blockpin signalname="FAST_CLOCK" name="CLOCK" />
            <blockpin signalname="Address(15:0)" name="ADDRESS(15:0)" />
            <blockpin signalname="XLXN_15(7:0)" name="DATA_IN_0(7:0)" />
            <blockpin signalname="XLXN_16(7:0)" name="DATA_IN_1(7:0)" />
            <blockpin signalname="XLXN_11" name="nREAD" />
            <blockpin signalname="XLXN_12" name="nWRITE" />
            <blockpin signalname="XLXN_1" name="RESET_IC" />
            <blockpin signalname="XLXN_6" name="IS_BIG_ENDIAN" />
            <blockpin signalname="XLXN_7" name="MEM_TEST_EN" />
            <blockpin signalname="XLXN_8" name="RAM_ERROR_CORR_EN" />
            <blockpin signalname="XLXN_17(15:0)" name="ADDRESS_TO_CHIP(15:0)" />
            <blockpin signalname="XLXN_13(7:0)" name="DATA_OUT_0(7:0)" />
            <blockpin signalname="XLXN_14(7:0)" name="DATA_OUT_1(7:0)" />
            <blockpin signalname="IDATA(7:0)" name="IDATA(7:0)" />
            <blockpin signalname="XLXN_19" name="DATA_VALID_0" />
            <blockpin signalname="XLXN_20" name="DATA_VALID_1" />
        </block>
        <block symbolname="MS1553_Reset_Pulse_Gen" name="XLXI_5">
            <blockpin signalname="XLXN_1" name="ResetGo" />
            <blockpin signalname="FAST_CLOCK" name="clock" />
            <blockpin signalname="XLXN_2" name="ResetOut" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2944" y="656" name="XLXI_2" orien="R0">
        </instance>
        <branch name="XLXN_2">
            <wire x2="2192" y1="592" y2="592" x1="2176" />
            <wire x2="2928" y1="592" y2="592" x1="2192" />
            <wire x2="2928" y1="592" y2="688" x1="2928" />
            <wire x2="2944" y1="688" y2="688" x1="2928" />
        </branch>
        <branch name="XLXN_6">
            <wire x2="912" y1="752" y2="752" x1="896" />
            <wire x2="2928" y1="752" y2="752" x1="912" />
            <wire x2="2944" y1="752" y2="752" x1="2928" />
        </branch>
        <branch name="FAST_CLOCK">
            <wire x2="1600" y1="176" y2="176" x1="1584" />
            <wire x2="1600" y1="176" y2="656" x1="1600" />
            <wire x2="1792" y1="656" y2="656" x1="1600" />
        </branch>
        <iomarker fontsize="28" x="1584" y="176" name="FAST_CLOCK" orien="R180" />
        <branch name="nMR">
            <wire x2="3344" y1="112" y2="112" x1="3328" />
            <wire x2="3360" y1="112" y2="112" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="112" name="nMR" orien="R0" />
        <branch name="MTSTOFF">
            <wire x2="3344" y1="304" y2="304" x1="3328" />
            <wire x2="3360" y1="304" y2="304" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="304" name="MTSTOFF" orien="R0" />
        <branch name="AUTOEN">
            <wire x2="3344" y1="368" y2="368" x1="3328" />
            <wire x2="3360" y1="368" y2="368" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="368" name="AUTOEN" orien="R0" />
        <branch name="EECOPY">
            <wire x2="3344" y1="432" y2="432" x1="3328" />
            <wire x2="3360" y1="432" y2="432" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="432" name="EECOPY" orien="R0" />
        <branch name="BENDI">
            <wire x2="3344" y1="496" y2="496" x1="3328" />
            <wire x2="3360" y1="496" y2="496" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="496" name="BENDI" orien="R0" />
        <branch name="RAMEDC">
            <wire x2="3344" y1="560" y2="560" x1="3328" />
            <wire x2="3360" y1="560" y2="560" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="560" name="RAMEDC" orien="R0" />
        <branch name="BWID">
            <wire x2="3344" y1="944" y2="944" x1="3328" />
            <wire x2="3360" y1="944" y2="944" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="944" name="BWID" orien="R0" />
        <branch name="XLXN_8">
            <wire x2="912" y1="880" y2="880" x1="896" />
            <wire x2="2928" y1="880" y2="880" x1="912" />
            <wire x2="2944" y1="880" y2="880" x1="2928" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="912" y1="816" y2="816" x1="896" />
            <wire x2="2928" y1="816" y2="816" x1="912" />
            <wire x2="2944" y1="816" y2="816" x1="2928" />
        </branch>
        <branch name="FAST_CLOCK">
            <wire x2="288" y1="688" y2="688" x1="272" />
        </branch>
        <instance x="2576" y="1376" name="XLXI_3" orien="R0">
        </instance>
        <branch name="BTYPE">
            <wire x2="3344" y1="1072" y2="1072" x1="3328" />
            <wire x2="3360" y1="1072" y2="1072" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="1072" name="BTYPE" orien="R0" />
        <branch name="WPOL">
            <wire x2="3344" y1="1136" y2="1136" x1="3328" />
            <wire x2="3360" y1="1136" y2="1136" x1="3344" />
        </branch>
        <iomarker fontsize="28" x="3360" y="1136" name="WPOL" orien="R0" />
        <iomarker fontsize="28" x="240" y="816" name="Address(15:0)" orien="R180" />
        <iomarker fontsize="28" x="272" y="688" name="FAST_CLOCK" orien="R180" />
        <branch name="XLXN_11">
            <wire x2="912" y1="1136" y2="1136" x1="896" />
            <wire x2="1728" y1="1136" y2="1136" x1="912" />
            <wire x2="1728" y1="1136" y2="1856" x1="1728" />
            <wire x2="2560" y1="1856" y2="1856" x1="1728" />
            <wire x2="2576" y1="1856" y2="1856" x1="2560" />
        </branch>
        <branch name="XLXN_12">
            <wire x2="912" y1="1328" y2="1328" x1="896" />
            <wire x2="1712" y1="1328" y2="1328" x1="912" />
            <wire x2="1712" y1="1328" y2="1920" x1="1712" />
            <wire x2="2560" y1="1920" y2="1920" x1="1712" />
            <wire x2="2576" y1="1920" y2="1920" x1="2560" />
        </branch>
        <branch name="XLXN_13(7:0)">
            <wire x2="912" y1="1392" y2="1392" x1="896" />
            <wire x2="1696" y1="1392" y2="1392" x1="912" />
            <wire x2="1696" y1="1392" y2="1984" x1="1696" />
            <wire x2="2560" y1="1984" y2="1984" x1="1696" />
            <wire x2="2576" y1="1984" y2="1984" x1="2560" />
        </branch>
        <branch name="XLXN_14(7:0)">
            <wire x2="912" y1="1456" y2="1456" x1="896" />
            <wire x2="1680" y1="1456" y2="1456" x1="912" />
            <wire x2="1680" y1="1456" y2="2048" x1="1680" />
            <wire x2="2560" y1="2048" y2="2048" x1="1680" />
            <wire x2="2576" y1="2048" y2="2048" x1="2560" />
        </branch>
        <branch name="XLXN_15(7:0)">
            <wire x2="208" y1="1520" y2="2160" x1="208" />
            <wire x2="3232" y1="2160" y2="2160" x1="208" />
            <wire x2="272" y1="1520" y2="1520" x1="208" />
            <wire x2="288" y1="1520" y2="1520" x1="272" />
            <wire x2="3168" y1="1984" y2="1984" x1="3152" />
            <wire x2="3232" y1="1984" y2="1984" x1="3168" />
            <wire x2="3232" y1="1984" y2="2160" x1="3232" />
        </branch>
        <branch name="XLXN_16(7:0)">
            <wire x2="224" y1="1584" y2="2144" x1="224" />
            <wire x2="3216" y1="2144" y2="2144" x1="224" />
            <wire x2="272" y1="1584" y2="1584" x1="224" />
            <wire x2="288" y1="1584" y2="1584" x1="272" />
            <wire x2="3168" y1="2048" y2="2048" x1="3152" />
            <wire x2="3216" y1="2048" y2="2048" x1="3168" />
            <wire x2="3216" y1="2048" y2="2144" x1="3216" />
        </branch>
        <branch name="XLXN_17(15:0)">
            <wire x2="912" y1="944" y2="944" x1="896" />
            <wire x2="1744" y1="944" y2="944" x1="912" />
            <wire x2="1744" y1="944" y2="1344" x1="1744" />
            <wire x2="2560" y1="1344" y2="1344" x1="1744" />
            <wire x2="2576" y1="1344" y2="1344" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="256" y="1136" name="ALE" orien="R180" />
        <branch name="nWR">
            <wire x2="272" y1="1328" y2="1328" x1="256" />
            <wire x2="288" y1="1328" y2="1328" x1="272" />
        </branch>
        <iomarker fontsize="28" x="256" y="1328" name="nWR" orien="R180" />
        <branch name="nRD">
            <wire x2="272" y1="1392" y2="1392" x1="256" />
            <wire x2="288" y1="1392" y2="1392" x1="272" />
        </branch>
        <iomarker fontsize="28" x="256" y="1392" name="nRD" orien="R180" />
        <branch name="nIOM">
            <wire x2="272" y1="1456" y2="1456" x1="256" />
            <wire x2="288" y1="1456" y2="1456" x1="272" />
        </branch>
        <iomarker fontsize="28" x="256" y="1456" name="nIOM" orien="R180" />
        <branch name="IDATA(7:0)">
            <wire x2="912" y1="1264" y2="1264" x1="896" />
            <wire x2="928" y1="1264" y2="1264" x1="912" />
        </branch>
        <iomarker fontsize="28" x="928" y="1264" name="IDATA(7:0)" orien="R0" />
        <branch name="FAST_CLOCK">
            <wire x2="2560" y1="1600" y2="1600" x1="2544" />
            <wire x2="2576" y1="1600" y2="1600" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2544" y="1600" name="FAST_CLOCK" orien="R180" />
        <branch name="HWAIT">
            <wire x2="2560" y1="1664" y2="1664" x1="2544" />
            <wire x2="2576" y1="1664" y2="1664" x1="2560" />
        </branch>
        <iomarker fontsize="28" x="2544" y="1664" name="HWAIT" orien="R180" />
        <branch name="nCE">
            <wire x2="3168" y1="1664" y2="1664" x1="3152" />
            <wire x2="3184" y1="1664" y2="1664" x1="3168" />
        </branch>
        <iomarker fontsize="28" x="3184" y="1664" name="nCE" orien="R0" />
        <branch name="nWE">
            <wire x2="3168" y1="1600" y2="1600" x1="3152" />
            <wire x2="3184" y1="1600" y2="1600" x1="3168" />
        </branch>
        <iomarker fontsize="28" x="3184" y="1600" name="nWE" orien="R0" />
        <branch name="nOE">
            <wire x2="3168" y1="1536" y2="1536" x1="3152" />
            <wire x2="3184" y1="1536" y2="1536" x1="3168" />
        </branch>
        <iomarker fontsize="28" x="3184" y="1536" name="nOE" orien="R0" />
        <branch name="DATA_CHIP(7:0)">
            <wire x2="3168" y1="1792" y2="1792" x1="3152" />
            <wire x2="3248" y1="1792" y2="1792" x1="3168" />
            <wire x2="3264" y1="1792" y2="1792" x1="3248" />
        </branch>
        <iomarker fontsize="28" x="3264" y="1792" name="DATA_CHIP(7:0)" orien="R0" />
        <instance x="1792" y="688" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_1">
            <wire x2="912" y1="688" y2="688" x1="896" />
            <wire x2="1776" y1="592" y2="592" x1="912" />
            <wire x2="1792" y1="592" y2="592" x1="1776" />
            <wire x2="912" y1="592" y2="688" x1="912" />
        </branch>
        <branch name="HOLT_ADDR(15:0)">
            <wire x2="3168" y1="1344" y2="1344" x1="3152" />
            <wire x2="3184" y1="1344" y2="1344" x1="3168" />
        </branch>
        <iomarker fontsize="28" x="3184" y="1344" name="HOLT_ADDR(15:0)" orien="R0" />
        <branch name="XLXN_19">
            <wire x2="272" y1="1648" y2="2272" x1="272" />
            <wire x2="3200" y1="2272" y2="2272" x1="272" />
            <wire x2="288" y1="1648" y2="1648" x1="272" />
            <wire x2="3168" y1="2112" y2="2112" x1="3152" />
            <wire x2="3200" y1="2112" y2="2112" x1="3168" />
            <wire x2="3200" y1="2112" y2="2272" x1="3200" />
        </branch>
        <branch name="XLXN_20">
            <wire x2="256" y1="1712" y2="2224" x1="256" />
            <wire x2="3216" y1="2224" y2="2224" x1="256" />
            <wire x2="272" y1="1712" y2="1712" x1="256" />
            <wire x2="288" y1="1712" y2="1712" x1="272" />
            <wire x2="3168" y1="2176" y2="2176" x1="3152" />
            <wire x2="3216" y1="2176" y2="2176" x1="3168" />
            <wire x2="3216" y1="2176" y2="2224" x1="3216" />
        </branch>
        <branch name="ALE">
            <wire x2="272" y1="1136" y2="1136" x1="256" />
            <wire x2="288" y1="1136" y2="1136" x1="272" />
        </branch>
        <branch name="Address(15:0)">
            <wire x2="256" y1="816" y2="816" x1="240" />
            <wire x2="272" y1="816" y2="816" x1="256" />
            <wire x2="288" y1="816" y2="816" x1="272" />
        </branch>
        <instance x="288" y="1104" name="XLXI_4" orien="R0">
        </instance>
    </sheet>
</drawing>