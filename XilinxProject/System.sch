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
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5(15:0)" />
        <signal name="XLXN_7(15:0)" />
        <signal name="XLXN_12(15:0)" />
        <signal name="XLXN_14(7:0)" />
        <signal name="nMR" />
        <signal name="AUTOEN" />
        <signal name="MTSTOFF" />
        <signal name="EECOPY" />
        <signal name="BENDI" />
        <signal name="RAMEDC" />
        <signal name="BWID" />
        <signal name="BTYPE" />
        <signal name="WPOL" />
        <signal name="nCE" />
        <signal name="nWE" />
        <signal name="nOE" />
        <signal name="HOLT_ADDR_BUS(15:0)" />
        <signal name="HOLT_DATA_BUS(7:0)" />
        <signal name="HWAIT" />
        <signal name="FAST_CLOCK" />
        <port polarity="Output" name="nMR" />
        <port polarity="Output" name="AUTOEN" />
        <port polarity="Output" name="MTSTOFF" />
        <port polarity="Output" name="EECOPY" />
        <port polarity="Output" name="BENDI" />
        <port polarity="Output" name="RAMEDC" />
        <port polarity="Output" name="BWID" />
        <port polarity="Output" name="BTYPE" />
        <port polarity="Output" name="WPOL" />
        <port polarity="Output" name="nCE" />
        <port polarity="Output" name="nWE" />
        <port polarity="Output" name="nOE" />
        <port polarity="Output" name="HOLT_ADDR_BUS(15:0)" />
        <port polarity="BiDirectional" name="HOLT_DATA_BUS(7:0)" />
        <port polarity="Input" name="HWAIT" />
        <port polarity="Input" name="FAST_CLOCK" />
        <blockdef name="I8085_c">
            <timestamp>2012-11-7T1:8:33</timestamp>
            <rect width="384" x="64" y="-768" height="768" />
            <line x2="0" y1="-736" y2="-736" x1="64" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="512" y1="-736" y2="-736" x1="448" />
            <line x2="512" y1="-672" y2="-672" x1="448" />
            <line x2="512" y1="-608" y2="-608" x1="448" />
            <line x2="512" y1="-544" y2="-544" x1="448" />
            <line x2="512" y1="-480" y2="-480" x1="448" />
            <line x2="512" y1="-416" y2="-416" x1="448" />
            <line x2="512" y1="-352" y2="-352" x1="448" />
            <line x2="512" y1="-288" y2="-288" x1="448" />
            <line x2="512" y1="-224" y2="-224" x1="448" />
            <line x2="512" y1="-160" y2="-160" x1="448" />
            <line x2="512" y1="-96" y2="-96" x1="448" />
            <rect width="64" x="448" y="-44" height="24" />
            <line x2="512" y1="-32" y2="-32" x1="448" />
        </blockdef>
        <blockdef name="MS1553_Controller">
            <timestamp>2012-11-7T1:14:17</timestamp>
            <rect width="368" x="64" y="-1152" height="1152" />
            <rect width="64" x="0" y="-1132" height="24" />
            <line x2="0" y1="-1120" y2="-1120" x1="64" />
            <line x2="0" y1="-944" y2="-944" x1="64" />
            <line x2="0" y1="-768" y2="-768" x1="64" />
            <line x2="0" y1="-592" y2="-592" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
            <line x2="496" y1="-1120" y2="-1120" x1="432" />
            <line x2="496" y1="-928" y2="-928" x1="432" />
            <line x2="496" y1="-864" y2="-864" x1="432" />
            <line x2="496" y1="-800" y2="-800" x1="432" />
            <line x2="496" y1="-736" y2="-736" x1="432" />
            <line x2="496" y1="-672" y2="-672" x1="432" />
            <line x2="496" y1="-544" y2="-544" x1="432" />
            <line x2="496" y1="-480" y2="-480" x1="432" />
            <line x2="496" y1="-416" y2="-416" x1="432" />
            <rect width="64" x="432" y="-364" height="24" />
            <line x2="496" y1="-352" y2="-352" x1="432" />
            <line x2="496" y1="-288" y2="-288" x1="432" />
            <line x2="496" y1="-224" y2="-224" x1="432" />
            <line x2="496" y1="-160" y2="-160" x1="432" />
            <rect width="64" x="432" y="-108" height="24" />
            <line x2="496" y1="-96" y2="-96" x1="432" />
            <rect width="64" x="432" y="-44" height="24" />
            <line x2="496" y1="-32" y2="-32" x1="432" />
        </blockdef>
        <block symbolname="I8085_c" name="XLXI_1">
            <blockpin name="X1" />
            <blockpin name="SID" />
            <blockpin name="TRAP" />
            <blockpin name="RST75" />
            <blockpin name="RST65" />
            <blockpin name="RST55" />
            <blockpin name="INTR" />
            <blockpin name="READY" />
            <blockpin name="RESETINBAR" />
            <blockpin name="HOLD" />
            <blockpin signalname="XLXN_14(7:0)" name="ID(7:0)" />
            <blockpin name="RESETOUT" />
            <blockpin name="SOD" />
            <blockpin name="INTABAR" />
            <blockpin name="S0" />
            <blockpin signalname="XLXN_1" name="ALE" />
            <blockpin signalname="XLXN_2" name="WRBAR" />
            <blockpin signalname="XLXN_3" name="RDBAR" />
            <blockpin name="S1" />
            <blockpin signalname="XLXN_4" name="IOMBAR" />
            <blockpin name="CLKOUT" />
            <blockpin name="HLDA" />
            <blockpin signalname="XLXN_5(15:0)" name="ADDRESS_OUT(15:0)" />
        </block>
        <block symbolname="MS1553_Controller" name="XLXI_2">
            <blockpin signalname="XLXN_5(15:0)" name="Address(15:0)" />
            <blockpin signalname="FAST_CLOCK" name="FAST_CLOCK" />
            <blockpin signalname="XLXN_1" name="ALE" />
            <blockpin signalname="XLXN_2" name="nWR" />
            <blockpin signalname="XLXN_3" name="nRD" />
            <blockpin signalname="XLXN_4" name="nIOM" />
            <blockpin signalname="HWAIT" name="HWAIT" />
            <blockpin signalname="HOLT_DATA_BUS(7:0)" name="DATA_CHIP(7:0)" />
            <blockpin signalname="nMR" name="nMR" />
            <blockpin signalname="MTSTOFF" name="MTSTOFF" />
            <blockpin signalname="AUTOEN" name="AUTOEN" />
            <blockpin signalname="EECOPY" name="EECOPY" />
            <blockpin signalname="BENDI" name="BENDI" />
            <blockpin signalname="RAMEDC" name="RAMEDC" />
            <blockpin signalname="BWID" name="BWID" />
            <blockpin signalname="BTYPE" name="BTYPE" />
            <blockpin signalname="WPOL" name="WPOL" />
            <blockpin signalname="XLXN_14(7:0)" name="IDATA(7:0)" />
            <blockpin signalname="nCE" name="nCE" />
            <blockpin signalname="nWE" name="nWE" />
            <blockpin signalname="nOE" name="nOE" />
            <blockpin signalname="HOLT_ADDR_BUS(15:0)" name="HOLT_ADDR(15:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="XLXN_5(15:0)">
            <wire x2="1376" y1="832" y2="832" x1="1152" />
            <wire x2="1376" y1="128" y2="832" x1="1376" />
            <wire x2="1584" y1="128" y2="128" x1="1376" />
        </branch>
        <instance x="640" y="864" name="XLXI_1" orien="R0">
        </instance>
        <branch name="XLXN_2">
            <wire x2="1344" y1="448" y2="448" x1="1152" />
            <wire x2="1344" y1="448" y2="656" x1="1344" />
            <wire x2="1584" y1="656" y2="656" x1="1344" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="1392" y1="512" y2="512" x1="1152" />
            <wire x2="1392" y1="512" y2="832" x1="1392" />
            <wire x2="1584" y1="832" y2="832" x1="1392" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="1360" y1="640" y2="640" x1="1152" />
            <wire x2="1360" y1="640" y2="1008" x1="1360" />
            <wire x2="1584" y1="1008" y2="1008" x1="1360" />
        </branch>
        <branch name="XLXN_1">
            <wire x2="1360" y1="384" y2="384" x1="1152" />
            <wire x2="1360" y1="384" y2="480" x1="1360" />
            <wire x2="1584" y1="480" y2="480" x1="1360" />
        </branch>
        <branch name="XLXN_14(7:0)">
            <wire x2="640" y1="768" y2="768" x1="624" />
            <wire x2="624" y1="768" y2="1312" x1="624" />
            <wire x2="2160" y1="1312" y2="1312" x1="624" />
            <wire x2="2160" y1="896" y2="896" x1="2080" />
            <wire x2="2160" y1="896" y2="1312" x1="2160" />
        </branch>
        <instance x="1584" y="1248" name="XLXI_2" orien="R0">
        </instance>
        <branch name="nMR">
            <wire x2="2112" y1="128" y2="128" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="128" name="nMR" orien="R0" />
        <branch name="AUTOEN">
            <wire x2="2112" y1="384" y2="384" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="384" name="AUTOEN" orien="R0" />
        <branch name="MTSTOFF">
            <wire x2="2112" y1="320" y2="320" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="320" name="MTSTOFF" orien="R0" />
        <branch name="EECOPY">
            <wire x2="2112" y1="448" y2="448" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="448" name="EECOPY" orien="R0" />
        <branch name="BENDI">
            <wire x2="2112" y1="512" y2="512" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="512" name="BENDI" orien="R0" />
        <branch name="RAMEDC">
            <wire x2="2112" y1="576" y2="576" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="576" name="RAMEDC" orien="R0" />
        <branch name="BWID">
            <wire x2="2112" y1="704" y2="704" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="704" name="BWID" orien="R0" />
        <branch name="BTYPE">
            <wire x2="2112" y1="768" y2="768" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="768" name="BTYPE" orien="R0" />
        <branch name="WPOL">
            <wire x2="2112" y1="832" y2="832" x1="2080" />
        </branch>
        <iomarker fontsize="28" x="2112" y="832" name="WPOL" orien="R0" />
        <branch name="nCE">
            <wire x2="2096" y1="960" y2="960" x1="2080" />
            <wire x2="2224" y1="960" y2="960" x1="2096" />
        </branch>
        <branch name="nWE">
            <wire x2="2096" y1="1024" y2="1024" x1="2080" />
            <wire x2="2224" y1="1024" y2="1024" x1="2096" />
        </branch>
        <branch name="nOE">
            <wire x2="2096" y1="1088" y2="1088" x1="2080" />
            <wire x2="2224" y1="1088" y2="1088" x1="2096" />
        </branch>
        <branch name="HOLT_ADDR_BUS(15:0)">
            <wire x2="2096" y1="1152" y2="1152" x1="2080" />
            <wire x2="2224" y1="1152" y2="1152" x1="2096" />
        </branch>
        <branch name="HOLT_DATA_BUS(7:0)">
            <wire x2="2096" y1="1216" y2="1216" x1="2080" />
            <wire x2="2224" y1="1216" y2="1216" x1="2096" />
        </branch>
        <branch name="HWAIT">
            <wire x2="1584" y1="1184" y2="1184" x1="1552" />
        </branch>
        <iomarker fontsize="28" x="1552" y="1184" name="HWAIT" orien="R180" />
        <branch name="FAST_CLOCK">
            <wire x2="1584" y1="304" y2="304" x1="1552" />
        </branch>
        <iomarker fontsize="28" x="1552" y="304" name="FAST_CLOCK" orien="R180" />
        <iomarker fontsize="28" x="2224" y="1088" name="nOE" orien="R0" />
        <iomarker fontsize="28" x="2224" y="1024" name="nWE" orien="R0" />
        <iomarker fontsize="28" x="2224" y="960" name="nCE" orien="R0" />
        <iomarker fontsize="28" x="2224" y="1152" name="HOLT_ADDR_BUS(15:0)" orien="R0" />
        <iomarker fontsize="28" x="2224" y="1216" name="HOLT_DATA_BUS(7:0)" orien="R0" />
    </sheet>
</drawing>