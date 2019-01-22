----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2019 06:01:53 PM
-- Design Name: 
-- Module Name: TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB is
--  Port ( );
end TB;

architecture Behavioral of TB is
    component Top is
        generic (BaseTime : integer := 675000); -- 5 ms
        Port ( Cheat_mode : in STD_LOGIC_VECTOR (1 downto 0);
               Cheat_set : in STD_LOGIC_VECTOR (2 downto 0);
               clk : in STD_LOGIC;
               stop : in STD_LOGIC;
               num_out_H : out STD_LOGIC_VECTOR (5 downto 0);
               num_out_L : out STD_LOGIC_VECTOR (5 downto 0));
    end component;
    
    signal Cheat_mode : STD_LOGIC_VECTOR (1 downto 0) := "11";
    signal Cheat_set : STD_LOGIC_VECTOR (2 downto 0) :="010";
    signal clk : STD_LOGIC;
    signal stop : STD_LOGIC;
    signal num_out_H : STD_LOGIC_VECTOR (5 downto 0);
    signal num_out_L : STD_LOGIC_VECTOR (5 downto 0);
begin

    IMP: Top generic map (10) -- 5 ms
            Port map( Cheat_mode,
                   Cheat_set,
                   clk,
                   stop,
                   num_out_H,
                   num_out_L);

    clock: process
    begin
        clk <= '0';
        wait for 8 ns;
        clk <= '1';
        wait for 8 ns;
    end process;
    
    test:process
    begin
        Stop <= '0';
        wait for 13000ns;
        stop <= '1';
        wait for 8000ns;
    end process;


end Behavioral;
