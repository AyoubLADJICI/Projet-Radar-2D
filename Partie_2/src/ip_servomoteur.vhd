library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ip_servomoteur is
  port (
    clk        : in std_logic;                   
    position   : in std_logic_vector(7 downto 0); 
    reset_n    : in std_logic;                   
    commande   : out std_logic    
  );
end ip_servomoteur;

architecture RTL of ip_servomoteur is

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
      --Calcul de la duree de l'impulsion en fonction de la position
      --si position == 0 alors on a une duree d'impulsion d'1 ms (50 000 ticks) ~ 0°
	    --si position == 85 alors duree d'impulsion d'1.5 ms (75 000 ticks) ~ 45°
	    --si position == 170 alors duree d'impulsion d'2 ms (100 000 ticks) ~ 90°
      --si position == 255 alors duree d'impulsion d'2.5 ms (125 000 ticks) ~ 135°
      duty <= to_unsigned(MIN_PULSE + 75000*(to_integer(unsigned(position)))/255, 20);
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

end RTL;
