library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ip_neopixel is
end entity;

architecture Behavioral of tb_ip_neopixel is
signal clk       : std_logic := '0';
signal reset_n   : std_logic := '0';
signal SW        : std_logic_vector(3 downto 0) := (others => '0');
signal OUT_WS    : std_logic := '1';
signal OK : boolean := TRUE;

begin
    Inst_ip_neopixel: entity work.ip_neopixel
        port map (clk => clk, reset_n => reset_n, SW => SW, OUT_WS  => OUT_WS);

    clk_process : process
    begin
        while now < 835 us loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;

    process
        variable pulse_start, pulse_end : time := 0 ns;
    begin
        report "Debut de la simulation";
        reset_n <= '0';
        wait for 150 ns;
        reset_n <= '1';

        -- Mesure de la durée du RESET
        report "Mesure de la duree du RESET";
        wait until OUT_WS = '0';
        pulse_start := now;
        wait until OUT_WS = '1';
        pulse_end := now;
        if (pulse_end - pulse_start) >= 50 us then
            report "Test de la duree du RESET valide (>=50 us)" severity note;
        else
            report "Test de la duree du RESET echoue (<50 us)" severity error;
            OK <= FALSE;
        end if;

        report "Toutes les LEDs sont eteintes";
        report "Test de la duree de T0H";
        SW <= "0000"; --1 LED
        --d'après la datasheet, pour transmettre un bit 0, il faut envoyer un signal WS a l'etat haut de 0.35us suivi de 0.8us à l'état bas
        pulse_start := now;
        wait until OUT_WS = '0';
        pulse_end := now;
        if (pulse_end - pulse_start) >= 0.35 us then
            report "Test de la duree de T0H valide (>=0.35 us)" severity note;
        else
            report "Test de la duree de T0H echoue" severity error;
            OK <= FALSE;
        end if;

        report "Test de la duree de T0L";
        pulse_start := now;
        wait until OUT_WS = '1';
        pulse_end := now;
        if (pulse_end - pulse_start) >= 0.8 us then
            report "Test de la duree de T0L valide (0.8 us)" severity note;
        else
            report "Test de la duree de T0L echoue" severity error;
            OK <= FALSE;
        end if;

        wait for 358.75 us;

        report "Les 3 premieres LEDs sont allumees";
        report "Test de la duree de T1H";
        SW <= "0011"; --3 LED
        --d'après la datasheet, pour transmettre un bit 1, il faut envoyer un signal WS a l'etat haut de 0.7us suivi de 0.6us à l'état bas
        pulse_start := now;
        wait until OUT_WS = '0';
        pulse_end := now;
        if (pulse_end - pulse_start) >= 0.7 us then
            report "Test de la duree de T1H valide (>=0.7 us)" severity note;
        else
            report "Test de la duree de T1H echoue" severity error;
            OK <= FALSE;
        end if;

        report "Test de la duree de T1L";
        pulse_start := now;
        wait until OUT_WS = '1';
        pulse_end := now;
        if (pulse_end - pulse_start) >= 0.6 us then
            report "Test de la duree de T1L valide (0.6 us)" severity note;
        else
            report "Test de la duree de T1L echoue" severity error;
            OK <= FALSE;
        end if;
        
        wait for 358.75 us;

        if (OK) then
            report "Tous les tests ont ete reussis !" severity note;
        else
            report "Certains tests ont echoue." severity error;
        end if;

        report "Fin de la simulation";
        wait;
    end process;
end Behavioral;
