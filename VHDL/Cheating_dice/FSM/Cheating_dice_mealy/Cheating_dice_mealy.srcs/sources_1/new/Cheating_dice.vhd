----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2019 06:30:21 PM
-- Design Name: 
-- Module Name: Cheating_dice - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Cheating_dice is
    generic (Base_time : integer := 675000); -- 5 mm --New changes
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           cheat_en : in STD_LOGIC;
           cheat_in : in STD_LOGIC_VECTOR (2 downto 0);
           num_out_H : out STD_LOGIC_VECTOR (5 downto 0);
           num_out_L : out STD_LOGIC_VECTOR (5 downto 0));
end Cheating_dice;

architecture Behavioral of Cheating_dice is
    component Generate_dice is
        Generic( Base_time : integer); 
        Port ( clk : in std_logic;
               Num : in integer range 1 to 6;
               Num_out : out STD_LOGIC_VECTOR (5 downto 0));
    end component;
    type state is 
        (
            state_1,
            state_2,
            state_3,
            state_4,
            state_5,
            state_6,
            state_Cheat_1,
            state_Cheat_2
        );
    signal time_counter: integer := 0;
    signal dice_Cheat: integer := 0;
    signal dice: integer range 1 to 6;
    constant mmswitch: integer := Base_time * 8; 
    signal Cheat_Enabled: boolean := false;
    signal num_out : STD_LOGIC_VECTOR (5 downto 0);
    signal current_state, Next_state: state := state_1;
begin
    dice_Cheat <= to_integer(signed(cheat_in));
    Cheat_Enabled <= cheat_en = '1' and dice_Cheat < 7 and dice_Cheat > 0;
    sync_prc:process(clk)
    begin
        if rising_edge(clk) then
            if btn = '1' then
                current_state <= next_state;
                if time_counter < mmswitch then
                    time_counter <= time_counter + 1;
                else
                    time_counter <= 0;
                end if;
            end if;
        end if;
    end process;
    
    next_state_logic: process(current_state, time_counter)
    begin
        next_state <= current_state;
        case current_state is 
            when state_1 =>
                if time_counter = mmswitch then
                    next_state <= state_2;
                end if;
                
            when state_2 =>
                if time_counter = mmswitch then
                    next_state <= state_3; ---The wrong function
                end if;
                
            when state_3 =>
                if time_counter = mmswitch then
                    next_state <= state_4;
                end if;
                
            when state_4 =>
                if time_counter = mmswitch then
                    next_state <= state_5;
                end if;
                
            when state_5 =>
                if time_counter = mmswitch then
                    next_state <= state_6;
                end if;
                
            when state_6 =>
                if time_counter = mmswitch then
                    if Cheat_Enabled then
                        next_state <= state_Cheat_1;
                    else
                        next_state <= state_1;
                    end if;
                end if;
                
            when state_Cheat_1 =>
                if time_counter = mmswitch then
                    if Cheat_Enabled then
                        next_state <= state_Cheat_2;
                    else
                        next_state <= state_1;
                    end if;
                end if;
                
            when state_Cheat_2 =>
                if time_counter = mmswitch then
                    next_state <= state_1;
                end if;
        end case;
    end process;

    output_logic:process(current_state)
    begin
        case current_state is 
            when state_1 =>
                dice <= 1;
                
            when state_2 =>
                dice <= 2;
                
            when state_3 =>
                dice <= 3;
                
            when state_4 =>
                dice <= 4;
                
            when state_5 =>
                dice <= 5;
                
            when state_6 =>
                dice <= 6;
                
            when state_Cheat_1 =>
                dice <= dice_Cheat;
                
            when state_Cheat_2 =>
                dice <= dice_Cheat;
        end case;
    end process;
    
    
    Gen_dice: Generate_dice generic map (Base_time)
                            port map (clk, dice, num_out);
    num_out_H <= num_out;
    num_out_L <= num_out;
end Behavioral;
