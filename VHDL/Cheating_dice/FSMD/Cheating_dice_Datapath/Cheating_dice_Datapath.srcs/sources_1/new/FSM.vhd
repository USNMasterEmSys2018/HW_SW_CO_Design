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

entity StateMachine is
  Port (
        Skip: in integer range 0 to 6;
        Tick: in std_logic;
        clk: in std_logic;
        stop: in std_logic;
        FSM_OUT: out integer range 1 to 6
         );
end StateMachine;

architecture FSM of StateMachine is
    type State is (
                    State_1,
                    State_2,
                    State_3,
                    State_4,
                    State_5,
                    State_6
                    );
    signal Next_state, current_state: State := State_1;
    signal Next_Cheat_state, current_Cheat_state: State := State_1;
    --signal 
    signal Out_reg, Out_reg_cheat: integer range 1 to 6;
begin
    sync_logic: process(clk)
    begin
        if rising_edge(clk) then
            Current_state <= Next_state;
            Current_Cheat_state <= Next_Cheat_state;
        end if;
    end process;
    
    next_state_logic: process(tick, current_state)
    begin
        Next_state <= Current_state;
        case current_state is
            when State_1 => 
                if tick = '1' then
                    Next_state <= state_2;
                end if;
            when State_2 => 
                if tick = '1' then
                    Next_state <= state_3;
                end if;
            when State_3 =>
                if tick = '1' then
                    Next_state <= state_4;
                end if; 
            when State_4 =>
                if tick = '1' then
                    Next_state <= state_5;
                end if; 
            when State_5 =>
                if tick = '1' then
                    Next_state <= state_6;
                end if;
            when State_6 =>
                if tick = '1' then
                    Next_state <= state_1;
                end if;
            when others =>
                Next_state <= state_1;
        end case;
    end process;
    
    next_state_logic_cheat: process(tick, skip, current_Cheat_state)
    begin
        Next_Cheat_state <= current_Cheat_state;
        if skip /= 0 then
            case current_Cheat_state is
                when State_1 => 
                    if tick = '1' then
                        if skip = 2 then 
                            Next_Cheat_state <= state_3;
                        else
                            Next_Cheat_state <= state_2;
                        end if;
                    end if;
                when State_2 => 
                    if tick = '1' then
                        if skip = 3 then 
                            Next_Cheat_state <= state_4;
                        else
                            Next_Cheat_state <= state_3;
                        end if;
                    end if;
                when State_3 =>
                    if tick = '1' then
                        if skip = 4 then 
                            Next_Cheat_state <= state_5;
                        else
                            Next_Cheat_state <= state_4;
                        end if;
                    end if; 
                when State_4 =>
                    if tick = '1' then
                        if skip = 5 then 
                            Next_Cheat_state <= state_6;
                        else
                            Next_Cheat_state <= state_5;
                        end if;
                    end if; 
                when State_5 =>
                    if tick = '1' then
                        if skip = 6 then 
                            Next_Cheat_state <= state_1;
                        else
                            Next_Cheat_state <= state_6;
                        end if;
                    end if;
                when State_6 =>
                    if tick = '1' then
                        if skip = 1 then 
                            Next_Cheat_state <= state_2;
                        else
                            Next_Cheat_state <= state_1;
                        end if;
                    end if; 
                when others =>
                    if skip = 1 then 
                        Next_Cheat_state <= state_2;
                    else
                        Next_Cheat_state <= state_1;
                    end if;
            end case;
        else
            Next_Cheat_state <= state_1;
        end if;
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
        
        case current_Cheat_state is
            when State_1 => 
                Out_reg_cheat <= 1;
            when State_2 => 
                Out_reg_cheat <= 2;
            when State_3 =>
                Out_reg_cheat <= 3;
            when State_4 =>
                Out_reg_cheat <= 4;
            when State_5 =>
                Out_reg_cheat <= 5;
            when State_6 =>
                Out_reg_cheat <= 6;
        end case;
    end process;
    
    FSM_out <= Out_reg_cheat when Skip /= 0 and Stop = '1' 
               else Out_reg;

end FSM;

architecture ASM of StateMachine is
    signal Next_Result_control, Current_Result_control: integer range 1 to 6;
    signal Next_Cheat_Result_control, Current_Cheat_Result_control: integer range 1 to 6;
begin
    sync_logic: process(clk)
    begin
        if rising_edge(clk) then
            Current_Result_control <= Next_Result_control;
            Current_Cheat_Result_control <= Next_Cheat_Result_control;
        end if;
    end process;
    
    next_state_logic: process(tick, Current_Result_control)
    begin
        Next_Result_control <= Current_Result_control;
        if Tick = '1' then
            if Current_Result_control < 6 then
                Next_Result_control <= Current_Result_control + 1;
            else
                Next_Result_control <= 1;
            end if;
        end if;
    end process;
    
    next_state_logic_cheat: process(tick, skip, Current_Cheat_Result_control)
    begin
        Next_Cheat_Result_control <= Current_Cheat_Result_control;
        if skip /= 0 then
            if tick = '1' then
                if Current_Cheat_Result_control < 6 then
                    Next_Cheat_Result_control <= Current_Cheat_Result_control + 1;
                    if skip = Current_Cheat_Result_control + 1 then
                        Next_Cheat_Result_control <= Current_Cheat_Result_control + 2;
                        if Current_Cheat_Result_control = 5 then
                            Next_Cheat_Result_control <= 1;
                        end if;
                    end if;
                else
                    Next_Cheat_Result_control <= 1;
                    if skip = 1 then
                        Next_Cheat_Result_control <= 2;
                    end if;
                end if;
            end if;            
        else
            Next_Cheat_Result_control <= 1;
        end if;
    end process;
    
    FSM_out <= Current_Cheat_Result_control when Skip /= 0 and Stop = '1' 
               else Current_Result_control;

end ASM;

