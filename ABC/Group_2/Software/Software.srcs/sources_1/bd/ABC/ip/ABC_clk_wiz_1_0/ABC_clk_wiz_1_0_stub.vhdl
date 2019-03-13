-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Wed Mar 13 18:19:31 2019
-- Host        : 9900K_1080ti running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {d:/Shared/USN_study/HW_SW_CO_Design/ABC/Group
--               2/Software/Software.srcs/sources_1/bd/ABC/ip/ABC_clk_wiz_1_0/ABC_clk_wiz_1_0_stub.vhdl}
-- Design      : ABC_clk_wiz_1_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ABC_clk_wiz_1_0 is
  Port ( 
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end ABC_clk_wiz_1_0;

architecture stub of ABC_clk_wiz_1_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,reset,locked,clk_in1";
begin
end;
