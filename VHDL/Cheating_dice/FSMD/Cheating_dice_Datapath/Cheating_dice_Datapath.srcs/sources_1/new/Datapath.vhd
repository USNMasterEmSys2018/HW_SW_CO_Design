library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity DataPath is
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
end DataPath;

Architecture Behave of DataPath is
    component decoder is
    Generic( Base_time : integer);
    Port ( clk : in std_logic;
           Num : in integer range 1 to 6;
           Num_out : out STD_LOGIC_VECTOR (5 downto 0));
    end component;
    signal Cheats: integer range 0 to 7;
    signal Cheats_on: boolean;
    signal TickLimit: integer;
    signal TickCounter, Tickcounter_Next: integer := 0;
    signal Data_out: integer range 1 to 6;
begin
    --Preset flag Signal
    Cheats <= to_integer(signed(Cheat_set));
    Cheats_on <= Cheat_mode /= "00" and Cheats < 7 and Cheats > 0;
    TickLimit <= BaseTime * 3 when FSM_out = Cheats and Cheat_Mode = "11" --Tripple Chance
                 else BaseTime;
                 
    --Generate signal for FSM
    FSM_signaling:process(clk)
    begin
        if rising_edge(clk) then
            if stop = '0' then
                TickCounter <= Tickcounter_Next;
            end if;
        end if;
    end process;
    tick <= '1' when TickCounter >= TickLimit 
            else '0';
    Tickcounter_Next <= TickCounter + 1 when TickCounter < TickLimit 
                        else 0;
    Skip <= Cheats when Cheat_Mode = "01" and Cheats_on -- forbidden result
            else 0;
     
    --Dataout_Control
    Data_out <= Cheats when Cheats_on and Cheat_Mode = "10" and stop = '1' --Fixed result
                else FSM_out;
                
    Decode: decoder Generic map( Basetime )
        Port map( clk, Data_out, Num_out);

end Behave;