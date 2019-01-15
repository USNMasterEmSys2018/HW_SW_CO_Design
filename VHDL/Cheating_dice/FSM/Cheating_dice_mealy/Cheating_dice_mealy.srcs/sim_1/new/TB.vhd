----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2019 08:37:18 PM
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
    component Cheating_dice is
        generic (Base_time : integer := 1250000);
        Port ( clk : in STD_LOGIC;
               btn : in STD_LOGIC;
               cheat_en : in STD_LOGIC;
               cheat_in : in STD_LOGIC_VECTOR (2 downto 0);
               num_out : out STD_LOGIC_VECTOR (5 downto 0));
    end component;
    signal clk : STD_LOGIC := '0';
    signal btn : STD_LOGIC := '0';
    signal cheat_en : STD_LOGIC := '0';
    signal cheat_in : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal num_out : STD_LOGIC_VECTOR (5 downto 0) := "000000";
begin
    clker: process
    begin
        clk <= '0';
        wait for 8 ns;
        clk <= '1';
        wait for 8 ns;
    end process;
    
    process
    begin
       btn <= '0';
       wait for 32 ns;
       btn <= '1';
       wait for 8000 ns; 
    end process;
    
    dicer: Cheating_dice generic map (10)
                         port map (clk, btn, cheat_en, cheat_in, num_out);

end Behavioral;
