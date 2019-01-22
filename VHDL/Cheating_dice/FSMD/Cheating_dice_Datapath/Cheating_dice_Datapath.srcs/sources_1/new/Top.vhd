----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2019 05:47:25 PM
-- Design Name: 
-- Module Name: Top - Behavioral
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

entity Top is
    generic (BaseTime : integer := 675000); -- 5 ms
    Port ( Cheat_mode : in STD_LOGIC_VECTOR (1 downto 0);
           Cheat_set : in STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC;
           stop : in STD_LOGIC;
           num_out_H : out STD_LOGIC_VECTOR (5 downto 0);
           num_out_L : out STD_LOGIC_VECTOR (5 downto 0));
end Top;

architecture Behavioral of Top is

    
    component DataPath is
    Generic (BaseTime: integer := 5400000); -- 40 ms
    Port(
        Cheat_mode: in std_logic_vector(1 downto 0);
        Cheat_set: in std_logic_vector(2 downto 0);
        stop, clk: in std_logic;
        FSM_out: in integer range 1 to 6;
        skip: out integer range 0 to 6;
        tick: out std_logic;
        Num_out: out std_logic_vector(5 downto 0)
        );
    end component;
    

    
    Signal FSM_out: integer range 1 to 6;
    Signal skip: integer range 0 to 6;
    Signal tick: std_logic;
    Signal num_out: STD_LOGIC_VECTOR (5 downto 0);
begin
    Data_Path: DataPath generic map(BaseTime * 8)
                        Port map(
                                Cheat_mode,
                                Cheat_set,
                                stop, 
                                clk,
                                FSM_out,
                                skip,
                                tick,
                                num_out
                                );
    FSM_SEG: entity work.StateMachine(FSM) Port map (
                            Skip => Skip,
                            Tick => tick,
                            clk => clk,
                            stop => stop,
                            FSM_OUT => FSM_out
                             );
                             
     num_out_H <= num_out;
     num_out_L <= num_out;

end Behavioral;
