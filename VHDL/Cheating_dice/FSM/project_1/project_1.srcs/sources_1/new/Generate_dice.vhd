----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2019 06:45:18 PM
-- Design Name: 
-- Module Name: Generate_dice - Behavioral
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

entity Generate_dice is
    Generic( Base_time : integer);
    Port ( clk : in std_logic;
           Num : in integer range 1 to 6;
           Num_out : out STD_LOGIC_VECTOR (5 downto 0));
end Generate_dice;

architecture Behavioral of Generate_dice is
    type numflash is array (2 downto 0) of std_logic_vector(5 downto 0);
    type dice_array is array (5 downto 0) of numflash;
    constant dice:dice_array := (("011111","111000","110111"),--6
                                 ("011101","101010","110101"),--5
                                 ("011101","111000","110101"),--4
                                 ("011100","101010","110001"),--3
                                 ("011001","111000","110100"),--2
                                 ("111000","101010","111000"));--1
    signal D_num: integer range 0 to 5 := 0;
    signal bitcounter: integer range 0 to 2 := 0;
    signal CLKcounter: integer := 0;
begin
    D_num <= Num - 1;
    process(clk)
    begin
        if rising_edge(clk) then
            if CLKcounter < Base_time then
                CLKcounter <= CLKcounter + 1;
            else
                if bitcounter < 2 then
                    bitcounter <= bitcounter + 1;
                else
                    bitcounter <= 0;
                end if;
                CLKcounter <= 0;
            end if;
        end if;
    end process;
    
    Num_out <= dice(D_num)(bitcounter);
end Behavioral;
