library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity tb_telemetre_us_avalon is
end entity;

architecture Behavioral of tb_telemetre_us_avalon is
    constant Pulse    : time := 10 us; 
    signal Clk        : std_logic := '0';
    signal Rst_n      : std_logic := '0';
    signal trig       : std_logic;
    signal echo       : std_logic := '0';
    signal dist_cm    : std_logic_vector(9 downto 0);
    signal chipselect : std_logic := '0';
    signal Read_n     : std_logic := '1';
    signal readdata   : std_logic_vector(31 downto 0);
    signal OK         : boolean := TRUE; 

begin
    Inst_Telemetre_us_Avalon: entity work.Telemetre_us_Avalon
        port map (clk => Clk, rst_n => Rst_n, echo => echo, trig => trig, Read_n => Read_n, 
        chipselect => chipselect, readdata => readdata, Dist_cm => dist_cm);

    Clk_process : process
    begin
        Clk <= '0';
        wait for 10 ns;
        Clk <= '1';
        wait for 10 ns;
    end process;

    process
        --Variables pour mesurer les temps
        variable t1, t2 : time := 0 ns;
    begin
        report "Debut de la simulation";
        Rst_n <= '0';
        wait for 100 ns;
        Rst_n <= '1'; 
        wait for 100 ns;
        
        wait until trig = '1';
        t1 := now;
        wait until trig = '0';
        t2 := now;

        --Verification de la duree de Trig
        if Pulse = (t2 - t1) then
            report "Duree de l'impulsion Trig correcte !" severity note;
        else
            report "Duree de l'impulsion Trig incorrecte !" severity error;
            OK <= FALSE;
        end if;

        --Simulation d'un echo de 540 us
        report "Test : Verification de Trig et Echo pour 540 us";
        wait for 100 ns; 
        echo <= '1';
        wait for 540 us; 
        echo <= '0'; 
        wait for 20 ms;

        chipselect <= '1'; 
        Read_n <= '0'; --Demande de lecture
        wait for 10 ns;
        if readdata = x"00000009" and dist_cm = "0000001001" then 
            report "Readdata lit la bonne distance pour un Echo de 540 us" severity note;
        else
            report "Readdata lit une mauvaise distance pour un Echo de 540 us" severity error;
            OK <= FALSE;
        end if;

        chipselect <= '0'; 
        Read_n <= '1'; 

        wait until trig = '1';
        wait until trig = '0';

        --Simulation d'un echo de 180 us
        report "Test : Verification de Trig et Echo pour 180 us";
        wait for 100 ns; 
        echo <= '1'; 
        wait for 180 us; 
        echo <= '0'; 
        wait for 20 ms;

        chipselect <= '1'; 
        Read_n <= '0'; 
        wait for 10 ns;
        if readdata = x"00000003" and dist_cm = "0000000011" then 
            report "Readdata lit la bonne distance pour un Echo de 180 us" severity note;
        else
            report "Readdata lit une mauvaise distance pour un Echo de 180 us" severity error;
            OK <= FALSE;
        end if;

        chipselect <= '0'; 
        Read_n <= '1'; 

        wait for 1 ms;
        if (OK) then
            report "Tous les tests ont ete reussis !" severity note;
            report "L'interface Avalon pour le telemetre fonctionne bien" severity note;
        else
            report "Tous les tests ont ete reussis !" severity note;
            report "L'interface Avalon pour le telemetre ne fonctionne pas" severity error;
        end if;

        report "Fin de la simulation";
        wait;
    end process;
end architecture;
