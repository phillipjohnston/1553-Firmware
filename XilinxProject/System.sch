<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CPU_RESET" />
        <signal name="nMR" />
        <signal name="BWID" />
        <signal name="BTYPE" />
        <signal name="WPOL" />
        <signal name="nCE" />
        <signal name="nWE" />
        <signal name="nOE" />
        <signal name="ADDRESS(15:0)" />
        <signal name="DATA(7:0)" />
        <signal name="HWAIT" />
        <signal name="XLXN_118" />
        <signal name="XLXN_120" />
        <signal name="XLXN_121" />
        <signal name="XLXN_122" />
        <signal name="XLXN_123" />
        <signal name="XLXN_124" />
        <signal name="XLXN_125" />
        <signal name="XLXN_126" />
        <signal name="ADDR_OUT_8085(15:0)" />
        <signal name="nIOM" />
        <signal name="ALE" />
        <signal name="MEM_WEA" />
        <signal name="MEM_ADDR(15:0)" />
        <signal name="nWR" />
        <signal name="nRD" />
        <signal name="FAST_CLOCK" />
        <signal name="IDATA(7:0)" />
        <signal name="MEM_DATA_IN(7:0)" />
        <signal name="MEM_ENA" />
        <signal name="SLOW_CLOCK" />
        <signal name="MEM_DATA(7:0)" />
        <signal name="NET_GND" />
        <signal name="SEL_SFR(15:0)" />
        <signal name="RE" />
        <signal name="WE" />
        <signal name="SEL_SFR(0)" />
        <signal name="ADDR_OUT_8085(7:0)" />
        <signal name="SEL_SFR(2)" />
        <signal name="CPU_RESET_BUF" />
        <signal name="HWAIT_BUF" />
        <signal name="SYSCLK_P" />
        <signal name="SYSCLK_N" />
        <signal name="CHIPSCOPE_CLK" />
        <signal name="CPU_RESET_BUF_INV" />
        <signal name="SEL_SFR(1)" />
        <signal name="MTRUN" />
        <signal name="BCTRIG" />
        <signal name="TEST" />
        <signal name="BCENA" />
        <signal name="RT1ENA" />
        <signal name="RT1SSF" />
        <signal name="TXINHA" />
        <signal name="TXINHB" />
        <signal name="ACTIVE" />
        <signal name="MTPKRDY" />
        <signal name="READY" />
        <signal name="nRT1MC8" />
        <signal name="XLXN_150" />
        <port polarity="Input" name="CPU_RESET" />
        <port polarity="Output" name="nMR" />
        <port polarity="Output" name="BWID" />
        <port polarity="Output" name="BTYPE" />
        <port polarity="Output" name="WPOL" />
        <port polarity="Output" name="nCE" />
        <port polarity="Output" name="nWE" />
        <port polarity="Output" name="nOE" />
        <port polarity="Output" name="ADDRESS(15:0)" />
        <port polarity="BiDirectional" name="DATA(7:0)" />
        <port polarity="Input" name="HWAIT" />
        <port polarity="Output" name="NET_GND" />
        <port polarity="Input" name="SYSCLK_P" />
        <port polarity="Input" name="SYSCLK_N" />
        <port polarity="Output" name="CHIPSCOPE_CLK" />
        <port polarity="Output" name="MTRUN" />
        <port polarity="Output" name="BCTRIG" />
        <port polarity="Output" name="TEST" />
        <port polarity="Output" name="BCENA" />
        <port polarity="Output" name="RT1ENA" />
        <port polarity="Output" name="RT1SSF" />
        <port polarity="Output" name="TXINHA" />
        <port polarity="Output" name="TXINHB" />
        <port polarity="Input" name="ACTIVE" />
        <port polarity="Input" name="MTPKRDY" />
        <port polarity="Input" name="READY" />
        <port polarity="Input" name="nRT1MC8" />
        <blockdef name="I8085_c">
            <timestamp>2012-11-7T20:44:41</timestamp>
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
            <timestamp>2012-11-8T0:33:19</timestamp>
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
        <blockdef name="Memory">
            <timestamp>2012-11-8T2:13:35</timestamp>
            <line x2="32" y1="80" y2="80" style="linewidth:W" x1="0" />
            <line x2="32" y1="112" y2="112" style="linewidth:W" x1="0" />
            <line x2="32" y1="144" y2="144" x1="0" />
            <line x2="32" y1="208" y2="208" style="linewidth:W" x1="0" />
            <line x2="32" y1="272" y2="272" x1="0" />
            <line x2="544" y1="80" y2="80" style="linewidth:W" x1="576" />
            <rect width="512" x="32" y="32" height="348" />
        </blockdef>
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
        </blockdef>
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="Mem8085_Controller">
            <timestamp>2012-11-7T20:34:29</timestamp>
            <rect width="448" x="64" y="-320" height="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="576" y1="-288" y2="-288" x1="512" />
            <line x2="576" y1="-208" y2="-208" x1="512" />
            <rect width="64" x="512" y="-140" height="24" />
            <line x2="576" y1="-128" y2="-128" x1="512" />
            <rect width="64" x="512" y="-60" height="24" />
            <line x2="576" y1="-48" y2="-48" x1="512" />
        </blockdef>
        <blockdef name="tri_buf_8">
            <timestamp>2012-11-8T0:48:5</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <blockdef name="SFR_Address_Decoder">
            <timestamp>2012-11-12T13:8:52</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="sfr_8_output">
            <timestamp>2012-11-15T1:38:43</timestamp>
            <line x2="384" y1="96" y2="96" x1="320" />
            <line x2="384" y1="160" y2="160" x1="320" />
            <line x2="384" y1="224" y2="224" x1="320" />
            <line x2="384" y1="288" y2="288" x1="320" />
            <line x2="384" y1="352" y2="352" x1="320" />
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="320" y="20" height="24" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="256" x="64" y="-320" height="704" />
        </blockdef>
        <blockdef name="sfr_8_input">
            <timestamp>2012-11-15T2:6:40</timestamp>
            <line x2="0" y1="96" y2="96" x1="64" />
            <line x2="0" y1="160" y2="160" x1="64" />
            <line x2="0" y1="224" y2="224" x1="64" />
            <line x2="0" y1="288" y2="288" x1="64" />
            <rect width="64" x="320" y="20" height="24" />
            <line x2="384" y1="32" y2="32" x1="320" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="256" x="64" y="-256" height="576" />
        </blockdef>
        <blockdef name="sfr_8_output_pulse">
            <timestamp>2012-11-15T1:54:42</timestamp>
            <line x2="384" y1="96" y2="96" x1="320" />
            <line x2="384" y1="160" y2="160" x1="320" />
            <line x2="384" y1="224" y2="224" x1="320" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
            <rect width="256" x="64" y="-384" height="640" />
        </blockdef>
        <blockdef name="ibuf">
            <timestamp>2009-3-20T10:10:10</timestamp>
            <line x2="64" y1="0" y2="-64" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
        </blockdef>
        <blockdef name="Clock">
            <timestamp>2012-11-12T22:55:41</timestamp>
            <rect width="544" x="32" y="32" height="364" />
            <line x2="32" y1="112" y2="112" x1="0" />
            <line x2="32" y1="144" y2="144" x1="0" />
            <line x2="576" y1="80" y2="80" x1="608" />
            <line x2="576" y1="176" y2="176" x1="608" />
            <line x2="576" y1="272" y2="272" x1="608" />
            <line x2="32" y1="352" y2="352" x1="0" />
            <line x2="576" y1="352" y2="352" x1="608" />
        </blockdef>
        <block symbolname="MS1553_Controller" name="XLXI_2">
            <blockpin signalname="ADDR_OUT_8085(15:0)" name="Address(15:0)" />
            <blockpin signalname="FAST_CLOCK" name="FAST_CLOCK" />
            <blockpin signalname="ALE" name="ALE" />
            <blockpin signalname="nWR" name="nWR" />
            <blockpin signalname="nRD" name="nRD" />
            <blockpin signalname="nIOM" name="nIOM" />
            <blockpin signalname="HWAIT_BUF" name="HWAIT" />
            <blockpin signalname="DATA(7:0)" name="DATA_CHIP(7:0)" />
            <blockpin signalname="nMR" name="nMR" />
            <blockpin signalname="BWID" name="BWID" />
            <blockpin signalname="BTYPE" name="BTYPE" />
            <blockpin signalname="WPOL" name="WPOL" />
            <blockpin signalname="IDATA(7:0)" name="IDATA(7:0)" />
            <blockpin signalname="nCE" name="nCE" />
            <blockpin signalname="nWE" name="nWE" />
            <blockpin signalname="nOE" name="nOE" />
            <blockpin signalname="ADDRESS(15:0)" name="HOLT_ADDR(15:0)" />
        </block>
        <block symbolname="I8085_c" name="XLXI_1">
            <blockpin signalname="SLOW_CLOCK" name="X1" />
            <blockpin signalname="XLXN_120" name="SID" />
            <blockpin signalname="XLXN_121" name="TRAP" />
            <blockpin signalname="XLXN_122" name="RST75" />
            <blockpin signalname="XLXN_123" name="RST65" />
            <blockpin signalname="XLXN_124" name="RST55" />
            <blockpin signalname="XLXN_125" name="INTR" />
            <blockpin signalname="XLXN_118" name="READY" />
            <blockpin signalname="CPU_RESET_BUF" name="RESETINBAR" />
            <blockpin signalname="XLXN_126" name="HOLD" />
            <blockpin signalname="IDATA(7:0)" name="ID(7:0)" />
            <blockpin name="RESETOUT" />
            <blockpin name="SOD" />
            <blockpin name="INTABAR" />
            <blockpin name="S0" />
            <blockpin signalname="ALE" name="ALE" />
            <blockpin signalname="nWR" name="WRBAR" />
            <blockpin signalname="nRD" name="RDBAR" />
            <blockpin name="S1" />
            <blockpin signalname="nIOM" name="IOMBAR" />
            <blockpin name="CLKOUT" />
            <blockpin name="HLDA" />
            <blockpin signalname="ADDR_OUT_8085(15:0)" name="ADDRESS_OUT(15:0)" />
        </block>
        <block symbolname="vcc" name="XLXI_10">
            <blockpin signalname="XLXN_118" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_12">
            <blockpin signalname="XLXN_120" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_13">
            <blockpin signalname="XLXN_121" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_14">
            <blockpin signalname="XLXN_122" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_15">
            <blockpin signalname="XLXN_123" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_16">
            <blockpin signalname="XLXN_124" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_17">
            <blockpin signalname="XLXN_125" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_18">
            <blockpin signalname="XLXN_126" name="G" />
        </block>
        <block symbolname="Mem8085_Controller" name="XLXI_19">
            <blockpin signalname="ALE" name="ALE" />
            <blockpin signalname="nWR" name="nWR" />
            <blockpin signalname="nRD" name="nRD" />
            <blockpin signalname="nIOM" name="nIOM" />
            <blockpin signalname="ADDR_OUT_8085(15:0)" name="ADDRESS_IN(15:0)" />
            <blockpin signalname="MEM_ENA" name="ENA" />
            <blockpin signalname="MEM_WEA" name="WEA" />
            <blockpin signalname="MEM_ADDR(15:0)" name="ADDRESS_OUT(15:0)" />
            <blockpin signalname="MEM_DATA_IN(7:0)" name="DATA_OUT(7:0)" />
        </block>
        <block symbolname="tri_buf_8" name="XLXI_68">
            <blockpin signalname="MEM_ENA" name="EN" />
            <blockpin signalname="MEM_DATA(7:0)" name="DIN(7:0)" />
            <blockpin signalname="IDATA(7:0)" name="DOUT(7:0)" />
        </block>
        <block symbolname="gnd" name="XLXI_92">
            <blockpin signalname="NET_GND" name="G" />
        </block>
        <block symbolname="inv" name="XLXI_93">
            <blockpin signalname="nWR" name="I" />
            <blockpin signalname="WE" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_94">
            <blockpin signalname="nRD" name="I" />
            <blockpin signalname="RE" name="O" />
        </block>
        <block symbolname="SFR_Address_Decoder" name="XLXI_96">
            <blockpin signalname="ADDR_OUT_8085(15:0)" name="ADDR(15:0)" />
            <blockpin signalname="SEL_SFR(15:0)" name="SEL(15:0)" />
        </block>
        <block symbolname="sfr_8_output" name="XLXI_98">
            <blockpin signalname="RE" name="RE" />
            <blockpin signalname="WE" name="WE" />
            <blockpin signalname="SLOW_CLOCK" name="clock" />
            <blockpin signalname="CPU_RESET_BUF_INV" name="clear" />
            <blockpin signalname="SEL_SFR(0)" name="CS" />
            <blockpin signalname="ADDR_OUT_8085(7:0)" name="DIN(7:0)" />
            <blockpin signalname="IDATA(7:0)" name="DOUT(7:0)" />
            <blockpin signalname="BCENA" name="BCENA" />
            <blockpin signalname="RT1ENA" name="RT1ENA" />
            <blockpin signalname="RT1SSF" name="RT1SSF" />
            <blockpin signalname="TXINHA" name="TXINHA" />
            <blockpin signalname="TXINHB" name="TXINHB" />
        </block>
        <block symbolname="sfr_8_output_pulse" name="XLXI_100">
            <blockpin signalname="RE" name="RE" />
            <blockpin signalname="WE" name="WE" />
            <blockpin signalname="SLOW_CLOCK" name="clock" />
            <blockpin signalname="CPU_RESET_BUF_INV" name="clear" />
            <blockpin signalname="SEL_SFR(2)" name="CS" />
            <blockpin signalname="ADDR_OUT_8085(7:0)" name="DIN(7:0)" />
            <blockpin signalname="MTRUN" name="MTRUN" />
            <blockpin signalname="BCTRIG" name="BCTRIG" />
            <blockpin signalname="TEST" name="TEST" />
            <blockpin signalname="IDATA(7:0)" name="DOUT(7:0)" />
        </block>
        <block symbolname="ibuf" name="XLXI_101">
            <blockpin signalname="CPU_RESET" name="I" />
            <blockpin signalname="CPU_RESET_BUF" name="O" />
        </block>
        <block symbolname="ibuf" name="XLXI_104">
            <blockpin signalname="HWAIT" name="I" />
            <blockpin signalname="HWAIT_BUF" name="O" />
        </block>
        <block symbolname="Memory" name="XLXI_9">
            <blockpin signalname="MEM_ADDR(15:0)" name="addra(15:0)" />
            <blockpin signalname="MEM_DATA_IN(7:0)" name="dina(7:0)" />
            <blockpin signalname="MEM_ENA" name="ena" />
            <blockpin signalname="MEM_WEA" name="wea(0:0)" />
            <blockpin signalname="SLOW_CLOCK" name="clka" />
            <blockpin signalname="MEM_DATA(7:0)" name="douta(7:0)" />
        </block>
        <block symbolname="Clock" name="XLXI_105">
            <blockpin signalname="SYSCLK_P" name="clk_in1_p" />
            <blockpin signalname="SYSCLK_N" name="clk_in1_n" />
            <blockpin signalname="FAST_CLOCK" name="clk_out1" />
            <blockpin signalname="SLOW_CLOCK" name="clk_out2" />
            <blockpin signalname="CHIPSCOPE_CLK" name="clk_out3" />
            <blockpin signalname="CPU_RESET_BUF_INV" name="reset" />
            <blockpin name="locked" />
        </block>
        <block symbolname="inv" name="XLXI_108">
            <blockpin signalname="CPU_RESET_BUF" name="I" />
            <blockpin signalname="CPU_RESET_BUF_INV" name="O" />
        </block>
        <block symbolname="sfr_8_input" name="XLXI_99">
            <blockpin signalname="RE" name="RE" />
            <blockpin signalname="SEL_SFR(1)" name="CS" />
            <blockpin signalname="SLOW_CLOCK" name="clock" />
            <blockpin signalname="IDATA(7:0)" name="DOUT(7:0)" />
            <blockpin signalname="ACTIVE" name="ACTIVE" />
            <blockpin signalname="MTPKRDY" name="MTPKRDY" />
            <blockpin signalname="READY" name="READY" />
            <blockpin signalname="nRT1MC8" name="nRT1MC8" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2592" y="1280" name="XLXI_2" orien="R0">
        </instance>
        <branch name="nMR">
            <wire x2="3120" y1="160" y2="160" x1="3088" />
        </branch>
        <branch name="BWID">
            <wire x2="3120" y1="736" y2="736" x1="3088" />
        </branch>
        <branch name="BTYPE">
            <wire x2="3120" y1="800" y2="800" x1="3088" />
        </branch>
        <branch name="WPOL">
            <wire x2="3120" y1="864" y2="864" x1="3088" />
        </branch>
        <branch name="nCE">
            <wire x2="3232" y1="992" y2="992" x1="3088" />
        </branch>
        <branch name="nWE">
            <wire x2="3232" y1="1056" y2="1056" x1="3088" />
        </branch>
        <branch name="nOE">
            <wire x2="3232" y1="1120" y2="1120" x1="3088" />
        </branch>
        <branch name="ADDRESS(15:0)">
            <wire x2="3232" y1="1184" y2="1184" x1="3088" />
        </branch>
        <branch name="DATA(7:0)">
            <wire x2="3232" y1="1248" y2="1248" x1="3088" />
        </branch>
        <branch name="HWAIT_BUF">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2560" y="1216" type="branch" />
            <wire x2="2592" y1="1216" y2="1216" x1="2560" />
        </branch>
        <instance x="336" y="896" name="XLXI_1" orien="R0">
        </instance>
        <branch name="CPU_RESET_BUF">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="304" y="672" type="branch" />
            <wire x2="336" y1="672" y2="672" x1="304" />
        </branch>
        <branch name="XLXN_118">
            <wire x2="336" y1="608" y2="608" x1="304" />
        </branch>
        <instance x="304" y="672" name="XLXI_10" orien="R270" />
        <branch name="XLXN_120">
            <wire x2="336" y1="224" y2="224" x1="304" />
        </branch>
        <instance x="176" y="160" name="XLXI_12" orien="R90" />
        <branch name="XLXN_121">
            <wire x2="336" y1="288" y2="288" x1="304" />
        </branch>
        <instance x="176" y="224" name="XLXI_13" orien="R90" />
        <branch name="XLXN_122">
            <wire x2="336" y1="352" y2="352" x1="304" />
        </branch>
        <instance x="176" y="288" name="XLXI_14" orien="R90" />
        <branch name="XLXN_123">
            <wire x2="336" y1="416" y2="416" x1="304" />
        </branch>
        <instance x="176" y="352" name="XLXI_15" orien="R90" />
        <branch name="XLXN_124">
            <wire x2="336" y1="480" y2="480" x1="304" />
        </branch>
        <instance x="176" y="416" name="XLXI_16" orien="R90" />
        <branch name="XLXN_125">
            <wire x2="336" y1="544" y2="544" x1="304" />
        </branch>
        <instance x="176" y="480" name="XLXI_17" orien="R90" />
        <branch name="XLXN_126">
            <wire x2="336" y1="736" y2="736" x1="304" />
        </branch>
        <instance x="176" y="672" name="XLXI_18" orien="R90" />
        <branch name="ADDR_OUT_8085(15:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="896" y="864" type="branch" />
            <wire x2="896" y1="864" y2="864" x1="848" />
        </branch>
        <branch name="ADDR_OUT_8085(15:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2544" y="160" type="branch" />
            <wire x2="2592" y1="160" y2="160" x1="2544" />
        </branch>
        <branch name="nIOM">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="896" y="672" type="branch" />
            <wire x2="896" y1="672" y2="672" x1="848" />
        </branch>
        <branch name="nIOM">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2544" y="1040" type="branch" />
            <wire x2="2592" y1="1040" y2="1040" x1="2544" />
        </branch>
        <branch name="ALE">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="880" y="416" type="branch" />
            <wire x2="880" y1="416" y2="416" x1="848" />
        </branch>
        <branch name="ALE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2512" y="512" type="branch" />
            <wire x2="2592" y1="512" y2="512" x1="2512" />
        </branch>
        <branch name="nWR">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="896" y="480" type="branch" />
            <wire x2="896" y1="480" y2="480" x1="848" />
        </branch>
        <branch name="nRD">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="896" y="544" type="branch" />
            <wire x2="896" y1="544" y2="544" x1="848" />
        </branch>
        <branch name="IDATA(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="800" type="branch" />
            <wire x2="336" y1="800" y2="800" x1="256" />
        </branch>
        <branch name="SLOW_CLOCK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="160" type="branch" />
            <wire x2="336" y1="160" y2="160" x1="256" />
        </branch>
        <branch name="FAST_CLOCK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2528" y="336" type="branch" />
            <wire x2="2592" y1="336" y2="336" x1="2528" />
        </branch>
        <branch name="nWR">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2528" y="688" type="branch" />
            <wire x2="2592" y1="688" y2="688" x1="2528" />
        </branch>
        <branch name="nRD">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2528" y="864" type="branch" />
            <wire x2="2592" y1="864" y2="864" x1="2528" />
        </branch>
        <branch name="IDATA(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="3136" y="928" type="branch" />
            <wire x2="3136" y1="928" y2="928" x1="3088" />
        </branch>
        <iomarker fontsize="28" x="3120" y="736" name="BWID" orien="R0" />
        <iomarker fontsize="28" x="3120" y="160" name="nMR" orien="R0" />
        <iomarker fontsize="28" x="3120" y="864" name="WPOL" orien="R0" />
        <iomarker fontsize="28" x="3232" y="992" name="nCE" orien="R0" />
        <iomarker fontsize="28" x="3232" y="1056" name="nWE" orien="R0" />
        <iomarker fontsize="28" x="3232" y="1120" name="nOE" orien="R0" />
        <iomarker fontsize="28" x="3232" y="1248" name="DATA(7:0)" orien="R0" />
        <iomarker fontsize="28" x="3232" y="1184" name="ADDRESS(15:0)" orien="R0" />
        <iomarker fontsize="28" x="3120" y="800" name="BTYPE" orien="R0" />
        <instance x="320" y="1824" name="XLXI_19" orien="R0">
        </instance>
        <branch name="ADDR_OUT_8085(15:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="1792" type="branch" />
            <wire x2="320" y1="1792" y2="1792" x1="256" />
        </branch>
        <branch name="nIOM">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="1728" type="branch" />
            <wire x2="320" y1="1728" y2="1728" x1="256" />
        </branch>
        <branch name="ALE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="272" y="1536" type="branch" />
            <wire x2="320" y1="1536" y2="1536" x1="272" />
        </branch>
        <branch name="MEM_ENA">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="1536" type="branch" />
            <wire x2="928" y1="1536" y2="1536" x1="896" />
        </branch>
        <branch name="MEM_WEA">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="944" y="1616" type="branch" />
            <wire x2="944" y1="1616" y2="1616" x1="896" />
        </branch>
        <branch name="MEM_ADDR(15:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="1696" type="branch" />
            <wire x2="928" y1="1696" y2="1696" x1="896" />
        </branch>
        <branch name="MEM_DATA_IN(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="944" y="1776" type="branch" />
            <wire x2="944" y1="1776" y2="1776" x1="896" />
        </branch>
        <branch name="nWR">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="288" y="1600" type="branch" />
            <wire x2="320" y1="1600" y2="1600" x1="288" />
        </branch>
        <branch name="nRD">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="304" y="1664" type="branch" />
            <wire x2="320" y1="1664" y2="1664" x1="304" />
        </branch>
        <instance x="432" y="2080" name="XLXI_68" orien="R0">
        </instance>
        <branch name="IDATA(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="880" y="1984" type="branch" />
            <wire x2="880" y1="1984" y2="1984" x1="816" />
        </branch>
        <branch name="MEM_ENA">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="400" y="1984" type="branch" />
            <wire x2="432" y1="1984" y2="1984" x1="400" />
        </branch>
        <branch name="MEM_DATA(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="400" y="2048" type="branch" />
            <wire x2="432" y1="2048" y2="2048" x1="400" />
        </branch>
        <branch name="MEM_ADDR(15:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="272" y="2272" type="branch" />
            <wire x2="320" y1="2272" y2="2272" x1="272" />
        </branch>
        <branch name="MEM_DATA_IN(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="272" y="2304" type="branch" />
            <wire x2="320" y1="2304" y2="2304" x1="272" />
        </branch>
        <branch name="MEM_ENA">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="272" y="2336" type="branch" />
            <wire x2="320" y1="2336" y2="2336" x1="272" />
        </branch>
        <branch name="MEM_WEA">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="272" y="2400" type="branch" />
            <wire x2="320" y1="2400" y2="2400" x1="272" />
        </branch>
        <branch name="SLOW_CLOCK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="272" y="2464" type="branch" />
            <wire x2="320" y1="2464" y2="2464" x1="272" />
        </branch>
        <branch name="MEM_DATA(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="960" y="2272" type="branch" />
            <wire x2="960" y1="2272" y2="2272" x1="896" />
        </branch>
        <instance x="3312" y="2640" name="XLXI_92" orien="R0" />
        <branch name="NET_GND">
            <wire x2="3376" y1="2480" y2="2512" x1="3376" />
        </branch>
        <iomarker fontsize="28" x="3376" y="2480" name="NET_GND" orien="R270" />
        <instance x="1392" y="208" name="XLXI_93" orien="R0" />
        <instance x="1392" y="304" name="XLXI_94" orien="R0" />
        <branch name="nWR">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1328" y="176" type="branch" />
            <wire x2="1392" y1="176" y2="176" x1="1328" />
        </branch>
        <branch name="nRD">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1328" y="272" type="branch" />
            <wire x2="1344" y1="272" y2="272" x1="1328" />
            <wire x2="1392" y1="272" y2="272" x1="1344" />
        </branch>
        <branch name="WE">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1680" y="176" type="branch" />
            <wire x2="1680" y1="176" y2="176" x1="1616" />
        </branch>
        <branch name="RE">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1680" y="272" type="branch" />
            <wire x2="1680" y1="272" y2="272" x1="1616" />
        </branch>
        <instance x="1520" y="544" name="XLXI_96" orien="R0">
        </instance>
        <branch name="ADDR_OUT_8085(15:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1472" y="512" type="branch" />
            <wire x2="1520" y1="512" y2="512" x1="1472" />
        </branch>
        <branch name="SEL_SFR(15:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1952" y="512" type="branch" />
            <wire x2="1952" y1="512" y2="512" x1="1904" />
        </branch>
        <instance x="1616" y="1104" name="XLXI_98" orien="R0">
        </instance>
        <instance x="1616" y="2048" name="XLXI_100" orien="R0">
        </instance>
        <branch name="RE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="816" type="branch" />
            <wire x2="1616" y1="816" y2="816" x1="1568" />
        </branch>
        <branch name="WE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="880" type="branch" />
            <wire x2="1616" y1="880" y2="880" x1="1568" />
        </branch>
        <branch name="SLOW_CLOCK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="944" type="branch" />
            <wire x2="1616" y1="944" y2="944" x1="1568" />
        </branch>
        <branch name="CPU_RESET_BUF_INV">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1008" type="branch" />
            <wire x2="1616" y1="1008" y2="1008" x1="1568" />
        </branch>
        <branch name="SEL_SFR(0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1072" type="branch" />
            <wire x2="1616" y1="1072" y2="1072" x1="1568" />
        </branch>
        <branch name="ADDR_OUT_8085(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1136" type="branch" />
            <wire x2="1616" y1="1136" y2="1136" x1="1568" />
        </branch>
        <branch name="IDATA(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2048" y="1136" type="branch" />
            <wire x2="2048" y1="1136" y2="1136" x1="2000" />
        </branch>
        <branch name="RE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1696" type="branch" />
            <wire x2="1616" y1="1696" y2="1696" x1="1568" />
        </branch>
        <branch name="WE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1760" type="branch" />
            <wire x2="1616" y1="1760" y2="1760" x1="1568" />
        </branch>
        <branch name="SLOW_CLOCK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1824" type="branch" />
            <wire x2="1616" y1="1824" y2="1824" x1="1568" />
        </branch>
        <branch name="CPU_RESET_BUF_INV">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1888" type="branch" />
            <wire x2="1616" y1="1888" y2="1888" x1="1568" />
        </branch>
        <branch name="SEL_SFR(2)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="1952" type="branch" />
            <wire x2="1584" y1="1952" y2="1952" x1="1568" />
            <wire x2="1616" y1="1952" y2="1952" x1="1584" />
        </branch>
        <branch name="ADDR_OUT_8085(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1568" y="2016" type="branch" />
            <wire x2="1616" y1="2016" y2="2016" x1="1568" />
        </branch>
        <branch name="IDATA(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2064" y="2016" type="branch" />
            <wire x2="2064" y1="2016" y2="2016" x1="2000" />
        </branch>
        <instance x="1440" y="2512" name="XLXI_101" orien="R0" />
        <branch name="CPU_RESET">
            <wire x2="1440" y1="2480" y2="2480" x1="1392" />
        </branch>
        <branch name="CPU_RESET_BUF">
            <attrtext style="alignment:SOFT-TCENTER;fontsize:28;fontname:Arial" attrname="Name" x="1728" y="2480" type="branch" />
            <wire x2="1648" y1="2368" y2="2368" x1="1584" />
            <wire x2="1584" y1="2368" y2="2416" x1="1584" />
            <wire x2="1728" y1="2416" y2="2416" x1="1584" />
            <wire x2="1728" y1="2416" y2="2480" x1="1728" />
            <wire x2="1728" y1="2480" y2="2480" x1="1664" />
        </branch>
        <iomarker fontsize="28" x="1392" y="2480" name="CPU_RESET" orien="R180" />
        <instance x="1440" y="2624" name="XLXI_104" orien="R0" />
        <branch name="HWAIT_BUF">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1744" y="2592" type="branch" />
            <wire x2="1744" y1="2592" y2="2592" x1="1664" />
        </branch>
        <branch name="HWAIT">
            <wire x2="1440" y1="2592" y2="2592" x1="1392" />
        </branch>
        <iomarker fontsize="28" x="1392" y="2592" name="HWAIT" orien="R180" />
        <instance x="320" y="2192" name="XLXI_9" orien="R0">
        </instance>
        <instance x="304" y="944" name="XLXI_105" orien="R0">
        </instance>
        <branch name="SYSCLK_P">
            <wire x2="304" y1="1056" y2="1056" x1="256" />
        </branch>
        <branch name="SYSCLK_N">
            <wire x2="304" y1="1088" y2="1088" x1="256" />
        </branch>
        <branch name="FAST_CLOCK">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1008" y="1024" type="branch" />
            <wire x2="1008" y1="1024" y2="1024" x1="912" />
        </branch>
        <branch name="SLOW_CLOCK">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1024" y="1120" type="branch" />
            <wire x2="1024" y1="1120" y2="1120" x1="912" />
        </branch>
        <iomarker fontsize="28" x="256" y="1056" name="SYSCLK_P" orien="R180" />
        <iomarker fontsize="28" x="256" y="1088" name="SYSCLK_N" orien="R180" />
        <branch name="CPU_RESET_BUF_INV">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="208" y="1296" type="branch" />
            <wire x2="256" y1="1296" y2="1296" x1="208" />
            <wire x2="304" y1="1296" y2="1296" x1="256" />
        </branch>
        <branch name="CHIPSCOPE_CLK">
            <wire x2="992" y1="1216" y2="1216" x1="912" />
        </branch>
        <iomarker fontsize="28" x="992" y="1216" name="CHIPSCOPE_CLK" orien="R0" />
        <instance x="1648" y="2400" name="XLXI_108" orien="R0" />
        <branch name="CPU_RESET_BUF_INV">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1904" y="2368" type="branch" />
            <wire x2="1904" y1="2368" y2="2368" x1="1872" />
        </branch>
        <branch name="IDATA(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="3104" y="1776" type="branch" />
            <wire x2="3104" y1="1776" y2="1776" x1="3056" />
        </branch>
        <branch name="RE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2624" y="1520" type="branch" />
            <wire x2="2672" y1="1520" y2="1520" x1="2624" />
        </branch>
        <branch name="SEL_SFR(1)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2624" y="1584" type="branch" />
            <wire x2="2672" y1="1584" y2="1584" x1="2624" />
        </branch>
        <branch name="SLOW_CLOCK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2624" y="1648" type="branch" />
            <wire x2="2640" y1="1648" y2="1648" x1="2624" />
            <wire x2="2672" y1="1648" y2="1648" x1="2640" />
        </branch>
        <instance x="2672" y="1744" name="XLXI_99" orien="R0">
        </instance>
        <branch name="MTRUN">
            <wire x2="2064" y1="2144" y2="2144" x1="2000" />
        </branch>
        <branch name="BCTRIG">
            <wire x2="2080" y1="2208" y2="2208" x1="2000" />
        </branch>
        <branch name="TEST">
            <wire x2="2080" y1="2272" y2="2272" x1="2000" />
        </branch>
        <branch name="BCENA">
            <wire x2="2080" y1="1200" y2="1200" x1="2000" />
        </branch>
        <branch name="RT1ENA">
            <wire x2="2096" y1="1264" y2="1264" x1="2000" />
        </branch>
        <branch name="RT1SSF">
            <wire x2="2096" y1="1328" y2="1328" x1="2000" />
        </branch>
        <branch name="TXINHA">
            <wire x2="2096" y1="1392" y2="1392" x1="2000" />
        </branch>
        <branch name="TXINHB">
            <wire x2="2112" y1="1456" y2="1456" x1="2000" />
        </branch>
        <iomarker fontsize="28" x="2080" y="2208" name="BCTRIG" orien="R0" />
        <iomarker fontsize="28" x="2080" y="2272" name="TEST" orien="R0" />
        <iomarker fontsize="28" x="2064" y="2144" name="MTRUN" orien="R0" />
        <iomarker fontsize="28" x="2080" y="1200" name="BCENA" orien="R0" />
        <iomarker fontsize="28" x="2096" y="1264" name="RT1ENA" orien="R0" />
        <iomarker fontsize="28" x="2096" y="1328" name="RT1SSF" orien="R0" />
        <iomarker fontsize="28" x="2096" y="1392" name="TXINHA" orien="R0" />
        <iomarker fontsize="28" x="2112" y="1456" name="TXINHB" orien="R0" />
        <branch name="ACTIVE">
            <wire x2="2672" y1="1840" y2="1840" x1="2608" />
        </branch>
        <branch name="MTPKRDY">
            <wire x2="2672" y1="1904" y2="1904" x1="2624" />
        </branch>
        <branch name="READY">
            <wire x2="2448" y1="1984" y2="1984" x1="2384" />
            <wire x2="2384" y1="1984" y2="2128" x1="2384" />
            <wire x2="2656" y1="2128" y2="2128" x1="2384" />
            <wire x2="2448" y1="1968" y2="1984" x1="2448" />
            <wire x2="2672" y1="1968" y2="1968" x1="2656" />
            <wire x2="2656" y1="1968" y2="2128" x1="2656" />
        </branch>
        <branch name="nRT1MC8">
            <wire x2="2672" y1="2032" y2="2032" x1="2624" />
        </branch>
        <iomarker fontsize="28" x="2624" y="2032" name="nRT1MC8" orien="R180" />
        <iomarker fontsize="28" x="2448" y="1968" name="READY" orien="R270" />
        <iomarker fontsize="28" x="2624" y="1904" name="MTPKRDY" orien="R180" />
        <iomarker fontsize="28" x="2608" y="1840" name="ACTIVE" orien="R180" />
    </sheet>
</drawing>