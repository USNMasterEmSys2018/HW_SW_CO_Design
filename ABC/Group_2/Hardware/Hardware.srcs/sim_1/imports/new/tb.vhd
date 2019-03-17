library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity RX_TX_read_write_control_tb is
end;

architecture bench of RX_TX_read_write_control_tb is

  component RX_TX_read_write_control
      generic( Baud_width: integer := 1085);
      Port (
          clk: in std_logic;
          rx: in std_logic;
          tx: out std_logic
          );
  end component;

  signal clk: std_logic;
  signal rx: std_logic;
  signal tx: std_logic ;

begin

  -- Insert values for generic parameters !!
  uut: RX_TX_read_write_control port map ( clk        => clk,
                                           rx         => rx,
                                           tx         => tx );


clk_process: process
begin
    clk <= '0';
    wait for 4 ns;
    clk <= '1';
    wait for 4 ns;
end process;

tb: process
    begin
    rx <= '1';
    wait for 8680 ns;
    rx <= '1';
    wait for 8680 ns;
    rx <= '1';
    wait for 8680 ns;
    rx <= '1';
    wait for 8680 ns;
    rx <= '1';
    wait for 8680 ns;
    rx <= '1';
    wait for 8680 ns;
    
    --One character lower-case a 01100001
    rx <= '0'; -- start bit 
    wait for 8680 ns;
    rx <= '1'; -- 1
    wait for 8680 ns;
    rx <= '0'; -- 2
    wait for 8680 ns;
    rx <= '0'; -- 3
    wait for 8680 ns;
    rx <= '0'; -- 4
    wait for 8680 ns;
    rx <= '0'; -- 5
    wait for 8680 ns;
    rx <= '1'; -- 6
    wait for 8680 ns;
    rx <= '1'; -- 7
    wait for 8680 ns; 
    rx <= '0'; -- 8
    wait for 8680 ns;
    rx <= '1'; -- stop bit
    wait for 8680 ns;
    
    --Second 01100010 lower-case b
    rx <= '0'; -- start bit 
    wait for 8680 ns;
    rx <= '0'; -- 1
    wait for 8680 ns;
    rx <= '1'; -- 2
    wait for 8680 ns;
    rx <= '0'; -- 3
    wait for 8680 ns;
    rx <= '0'; -- 4
    wait for 8680 ns;
    rx <= '0'; -- 5
    wait for 8680 ns;
    rx <= '1'; -- 6
    wait for 8680 ns;
    rx <= '1'; -- 7
    wait for 8680 ns; 
    rx <= '0'; -- 8
    wait for 8680 ns;
    rx <= '1'; -- stop bit
    wait for 8680 ns;

    --Line-feed 00001010 
    rx <= '0'; -- start bit 
    wait for 8680 ns;
    rx <= '0'; -- 1
    wait for 8680 ns;
    rx <= '1'; -- 2
    wait for 8680 ns;
    rx <= '0'; -- 3
    wait for 8680 ns;
    rx <= '1'; -- 4
    wait for 8680 ns;
    rx <= '0'; -- 5
    wait for 8680 ns;
    rx <= '0'; -- 6
    wait for 8680 ns;
    rx <= '0'; -- 7
    wait for 8680 ns; 
    rx <= '0'; -- 8
    wait for 8680 ns;
    rx <= '1'; -- stop bit
    wait;
end process;

end;