library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.numeric_std.ALL;

entity send_data_state_machine is
    Port ( send_control : in STD_LOGIC;
           clk : in STD_LOGIC;
           address_reg : in STD_LOGIC_VECTOR ( 12 downto 0 );
           Data_in : in STD_LOGIC_VECTOR (7 downto 0);
           Address_to_read : out STD_LOGIC_VECTOR ( 12 downto 0 );
           LF : out STD_LOGIC;
           Data_out : out STD_LOGIC);
end send_data_state_machine;

architecture Behavioral of send_data_state_machine is
    type state is
                (
                idle_state,
                fetch_data_state,
                sending_state,
                LF_state
                );
    signal current_state, next_state: state := idle_state;
    signal Current_address, next_address: STD_LOGIC_VECTOR ( 12 downto 0 );
    signal data_to_send, data_to_send_next: STD_LOGIC;
    signal FF_send_control: std_logic_vector(1 downto 0) := "00";
    signal update_address, count_bit: boolean := false;
    signal Tone_counter, Tone_counter_next, baud_counter, baud_counter_next: integer := 0;
    constant Half_second: integer := 62500000;
    signal Baud_width: integer := 1;
    signal Data: integer;
begin
    flipflop:process(clk)
    begin
        if rising_edge(clk) then
            FF_send_control <= FF_send_control(0) & send_control;
        end if;
    end process;
    
    Data <=  to_integer(signed(Data_in));
    Tone_decoding: process(Data)
    begin
        baud_width <= Half_second;
        case Data is
            when 65 => baud_width <= (Half_second +Half_second)*100/44000; --A 4
            when 66 => baud_width <= (Half_second +Half_second)*100/49388; --B 4 
            when 67 => baud_width <= (Half_second +Half_second)*100/26163; --C 4
            when 68 => baud_width <= (Half_second +Half_second)*100/29366; --D 4
            when 69 => baud_width <= (Half_second +Half_second)*100/32963; --E 4
            when 70 => baud_width <= (Half_second +Half_second)*100/34923; --F 4
            when 71 => baud_width <= (Half_second +Half_second)*100/39200; --G 4
            when 97 => baud_width <= (Half_second +Half_second)*100/88000; --a 5
            when 98 => baud_width <= (Half_second +Half_second)*100/98777; --b 5
            when 99 => baud_width <= (Half_second +Half_second)*100/52325; --c 5
            when 100 => baud_width <= (Half_second +Half_second)*100/58733; --d 5
            when 101 => baud_width <= (Half_second +Half_second)*100/65925; --e 5
            when 102 => baud_width <= (Half_second +Half_second)*100/69846; --f 5
            when 103 => baud_width <= (Half_second +Half_second)*100/78399; --g 5
        end case;
    end process;
    
    next_state_logic:process(current_state, FF_send_control, Tone_counter, Current_address, address_reg)
    begin
        next_state <= current_state;
        update_address <= false;
        count_bit <= false;
        case current_state is
            when idle_state => 
                if FF_send_control = "01" then
                    next_state <= sending_state;
                end if;
            when sending_state => 
                count_bit <= true;
                if Tone_counter >=10 then
                    if Current_address > address_reg then
                        next_state <= LF_state; 
                    else 
                        next_state <= fetch_data_state;
                    end if;
                end if; 
            when fetch_data_state => 
                update_address <= true;
                next_state <= sending_state;  
            when LF_state => 
                next_state <= idle_state;
        end case;
    end process;
    
    Sync_proc:process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
            Tone_counter <= Tone_counter_next;
            current_address <= next_address;
            baud_counter <= baud_counter_next;
            data_to_send <= data_to_send_next;
        end if;
    end process;
    
    next_address <= 
                    std_logic_vector(unsigned(current_address) + 1) 
                        when update_address 
                        else
                    current_address                                 
                        when count_bit 
                        else 
                    (others => '0'); 
    Tone_counter_next <= Tone_counter + 1 when count_bit and not (Tone_counter = Half_second) else 
                     0 when not count_bit else Tone_counter;
                       
    baud_counter_next <= 0 when (not count_bit) else
                         baud_counter + 1 when(baud_counter < baud_width) else
                         0;
    data_to_send_next <= not data_to_send when (baud_counter = baud_width) else 
                         data_to_send ;
    output_logic:process(current_state, Tone_counter, current_address)
    begin
        Address_to_read <= current_address;
        LF <= '0';
        Data_out <= '0';
        case current_state is
            when idle_state => 
                Data_out <= '1';
            when sending_state => 
                if Tone_counter < 10 then
                Data_out <= data_to_send;
                end if;
            when fetch_data_state => 
                Address_to_read <= current_address;
            when LF_state => 
                LF <= '1';
        end case;
    end process;
    
end Behavioral;