-------------------------------------------------------------------------------
-- Copyright (c) 2012 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.1
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : icon_pro.vhd
-- /___/   /\     Timestamp  : Mon Nov 12 15:35:26 Eastern Standard Time 2012
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY icon_pro IS
  port (
    CONTROL0: inout std_logic_vector(35 downto 0));
END icon_pro;

ARCHITECTURE icon_pro_a OF icon_pro IS
BEGIN

END icon_pro_a;
