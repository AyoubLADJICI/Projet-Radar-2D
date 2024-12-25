library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity tb_ip_servomoteur is
end entity;

architecture Behavioral of tb_ip_servomoteur is
signal clk       : std_logic := '0';
signal reset_n   : std_logic := '0';
signal position  : std_logic_vector(7 downto 0) := (others => '0');
signal commande  : std_logic;
signal OK : boolean := TRUE;

begin
    inst_ip_servomoteur: entity work.ip_servomoteur
        port map (clk => clk, reset_n => reset_n, position => position, commande => commande);

    clk_process : process
    begin
        while now < 100 ms loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;

    process
        --Variable pour verifier la duree de l'impulsion
        variable pulse_start, pulse_end : time := 0 ns;
    begin
        report "Debut de la simulation";
        reset_n <= '0';
        wait for 100 ns;
        reset_n <= '1';
        wait for 20 ms;
        
        --Simulation d'une position a 45° (1.5 ms)
        report "Test 1 : Position 45° (1.5 ms)";
        position <= "01010101"; 
        wait until commande = '1';
        pulse_start := now;
        wait until commande = '0';
        pulse_end := now;
        if (pulse_end - pulse_start) = 1.5 ms  then
            report "Duree d'impulsion correcte pour un angle de 45°" severity note;
        else
            report "Duree d'impulsion incorrecte pour un angle de 45°" severity error;
            OK <= FALSE;
        end if;
        wait for 18.5 ms;

        --Simulation d'une position a 90° (2 ms)
        report "Test 2 : Position 90° (2 ms)";
        position <= "10101010"; 
        wait until commande = '1';
        pulse_start := now;
        wait until commande = '0';
        pulse_end := now;
        if (pulse_end - pulse_start) = 2 ms  then
            report "Duree d'impulsion correcte pour un angle de 90°" severity note;
        else
            report "Duree d'impulsion incorrecte pour un angle de 90°" severity error;
            OK <= FALSE;
        end if;
        wait for 18 ms;

        --Simulation d'une position a 135° (2.5 ms)
        report "Test 3 : Position 135° (2.5 ms)";
        position <= (others => '1'); 
        wait until commande = '1';
        pulse_start := now;
        wait until commande = '0';
        pulse_end := now;
        if (pulse_end - pulse_start) = 2.5 ms  then
            report "Duree d'impulsion correcte pour un angle de 135°" severity note;
        else
            report "Duree d'impulsion incorrecte pour un angle de 135°" severity error;
            OK <= FALSE;
        end if;
        wait for 17.5 ms;
        
        --Simulation d'une position à 0° (1 ms)
        report "Test 4 : Position 0° (1 ms)";
        position <= "00000000"; 
        wait until commande = '1';
        pulse_start := now;
        wait until commande = '0';
        pulse_end := now;
        if (pulse_end - pulse_start) = 1 ms  then
            report "Duree d'impulsion correcte pour un angle de 0°" severity note;
        else
            report "Duree d'impulsion incorrecte pour un angle de 0°" severity error;
            OK <= FALSE;
        end if;
        wait for 19 ms;


        if (OK) then
            report "Tous les tests ont ete reussis !" severity note;
        else
            report "Certains tests ont echoue." severity error;
        end if;

        report "Fin de la simulation";
        wait;
    end process;

end Behavioral;
