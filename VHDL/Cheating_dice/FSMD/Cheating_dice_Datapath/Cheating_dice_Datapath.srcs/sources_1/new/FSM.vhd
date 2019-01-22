----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/22/2019 01:39:38 AM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
  Port (
        Skip: in integer range 0 to 6;
        Tick: in std_logic;
        clk: in std_logic;
        FSM_OUT: out integer range 1 to 6
         );
end FSM;

architecture Behavioral of FSM is
    type State is (
                    State_1,
                    State_2,
                    State_3,
                    State_4,
                    State_5,
                    State_6
                    );
    signal Next_state, current_state: state;
    signal Out_reg: integer range 1 to 6;
begin
    sync_logic: process(clk)
    begin
        if rising_edge(clk) then
            Current_state <= Next_state;
        end if;
    end process;
    
    next_state_logic: process(tick, current_state)
    begin
        Next_state <= Current_state;
        case Current_state is
            when State_1 => 
                if tick = '1' then
                    if skip = 2 then 
                        Next_state <= state_3;
                    else
                        Next_state <= state_2;
                    end if;
                end if;
            when State_2 => 
                if tick = '1' then
                    if skip = 3 then 
                        Next_state <= state_4;
                    else
                        Next_state <= state_3;
                    end if;
                end if;
            when State_3 =>
                if tick = '1' then
                    if skip = 4 then 
                        Next_state <= state_5;
                    else
                        Next_state <= state_4;
                    end if;
                end if; 
            when State_4 =>
                if tick = '1' then
                    if skip = 5 then 
                        Next_state <= state_6;
                    else
                        Next_state <= state_5;
                    end if;
                end if; 
            when State_5 =>
                if tick = '1' then
                    if skip = 6 then 
                        Next_state <= state_1;
                    else
                        Next_state <= state_6;
                    end if;
                end if;
            when State_6 =>
                if tick = '1' then
                    if skip = 1 then 
                        Next_state <= state_2;
                    else
                        Next_state <= state_1;
                    end if;
                end if; 
            when others =>
                Next_state <= state_1;
        end case;
    end process;
    
    OutPut_logic:process(current_state)
    begin
        case Current_state is
            when State_1 => 
                Out_reg <= 1;
            when State_2 => 
                Out_reg <= 2;
            when State_3 =>
                Out_reg <= 3;
            when State_4 =>
                Out_reg <= 4;
            when State_5 =>
                Out_reg <= 5;
            when State_6 =>
                Out_reg <= 6;
        end case;
    end process;

end Behavioral;
