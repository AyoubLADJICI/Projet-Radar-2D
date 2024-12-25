library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity tb_ip_telemetre is
end entity;

architecture Behavioral of tb_ip_telemetre is
constant Pulse : time := 10 us; 
signal clk : std_logic := '0';
signal rst_n : std_logic := '0';
signal trig : std_logic;
signal echo : std_logic := '0';
signal dist_cm : std_logic_vector(9 downto 0);
signal OK : boolean := TRUE; 

begin
    Inst_IP_Telemetre: entity work.ip_telemetre
        port map (clk => clk, rst_n => rst_n, trig => trig, echo => echo, Dist_cm  => dist_cm);

    Clk_process : process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    process
        --Variables pour mesurer les temps
        variable t1, t2 : time := 0 ns;
    begin
        report "Debut de la simulation"; 
        rst_n <= '0';
        wait for 100 ns;
        rst_n <= '1'; 
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
        if dist_cm = "0000001001" then --9 en decimal
            report "Distance correcte pour Echo de 540 us : 9 cm" severity note;
        else
            report "Erreur : Distance incorrecte pour Echo de 540 us" severity error;
            OK <= FALSE;
        end if;

        wait until trig = '1';
        wait until trig = '0';

        --Simulation d'un echo de 180 us
        report "Test : Verification de Trig et Echo pour 180 us";
        wait for 100 ns; 
        echo <= '1'; 
        wait for 180 us; 
        echo <= '0'; 
        wait for 20 ms;
        if dist_cm = "0000000011" then --3 en decimal
            report "Distance correcte pour Echo de 180 us : 3 cm" severity note;
        else
            report "Erreur : Distance incorrecte pour Echo de 340 us" severity error;
            OK <= FALSE;
        end if;

        --wait for 1 ms;

        if (OK) then
            report "Tous les tests ont ete reussis !" severity note;
        else
            report "Certains tests ont echoue." severity error;
        end if;

        report "Fin de la simulation";
        wait;
    end process;
end architecture;
