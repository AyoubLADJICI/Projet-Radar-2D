library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ip_servo_avalon is
  port (
    clk        : in std_logic;                   
    reset_n    : in std_logic;                  
    chipselect : in std_logic;                   
    write_n    : in std_logic;                   
    writedata  : in std_logic_vector(31 downto 0); 
    commande   : out std_logic                   
  );
end ip_servo_avalon;

architecture Behavioral of ip_servo_avalon is

constant MIN_PULSE : integer := 50000; --1 ms
  
signal div         : unsigned(19 downto 0) := to_unsigned(50E6/50, 20); --20 ms ~ 1 000 000 de ticks (necessite 20 bits pour coder 1000000)
signal duty        : unsigned(19 downto 0); --Duree de l'impulsion
signal counter     : unsigned(19 downto 0);
signal pwm_on      : std_logic := '0';  

begin
  process(clk, reset_n)
  begin
    if reset_n = '0' then
      duty <= to_unsigned(MIN_PULSE, 20); 
    elsif rising_edge(clk) then
      if chipselect = '1' then
        if write_n = '0' then
          duty <= to_unsigned(MIN_PULSE + 75000*(to_integer(unsigned(writedata)))/255, 20);
        end if;
      end if;
    end if;
  end process;

  process(clk, reset_n)
  begin
    if reset_n = '0' then
      counter <= (others => '0');
    elsif rising_edge(clk) then
      if counter >= div then
        counter <= (others => '0');
      else
        counter <= counter + 1;
      end if;
    end if;
  end process;

  process(clk, reset_n)
  begin
    if reset_n = '0' then
      pwm_on <= '0';
    elsif rising_edge(clk) then
      if counter < duty then
        pwm_on <= '1'; 
      else
        pwm_on <= '0';
      end if;
    end if;
  end process;

  commande <= pwm_on;

end Behavioral;
