library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ip_neopixel is
    port (
        CLK     : in  std_logic;   
        RESET   : in  std_logic;   
        OUT_WS  : out std_logic    
    );
end entity;

architecture Behavioral of ip_neopixel is
    --Déclaration Type Tableau Memoire
    type led_color_array is array (0 to 11) of std_logic_vector(23 downto 0);
    --Fonction d'Initialisation de la mémoire
    function init_memoire return led_color_array is
    variable result : led_color_array;
    begin
        for i in 0 to 11 loop
            result(i) := (others => '0');
        end loop;
        result(0) := x"FF0000"; -- LED 0 : Rouge
        result(1) := x"00FF00"; -- LED 1 : Vert
        result(2) := x"0000FF"; -- LED 2 : Bleu
        result(3) := x"FFFF00"; -- LED 3 : Jaune
        result(4) := x"00FFFF"; -- LED 4 : Cyan
        result(5) := x"FF00FF"; -- LED 5 : Magenta
        result(6) := x"FFFFFF"; -- LED 6 : Blanc
        result(7) := x"FF7F00"; -- LED 7 : Orange
        result(8) := x"7F00FF"; -- LED 8 : Violet
        result(9) := x"FF3F7F"; -- LED 9 : Rose clair
        result(10) := x"3FFFFF"; -- LED 10 : Turquoise
        result(11) := x"7F7F7F"; -- LED 11 : Gris moyen
        return result;
    end init_memoire;
    -- Initialisation des couleurs en mémoire (format GRB)
    --constant LED_COLORS : led_color_array := (
        --x"FF0000", -- LED 0 : Rouge
       -- x"00FF00", -- LED 1 : Vert
        --x"0000FF", -- LED 2 : Bleu
       -- x"FFFF00", -- LED 3 : Jaune
       -- x"00FFFF", -- LED 4 : Cyan
       -- x"FF00FF", -- LED 5 : Magenta
       -- x"FFFFFF", -- LED 6 : Blanc
       -- x"FF7F00", -- LED 7 : Orange
      --  x"7F00FF", -- LED 8 : Violet
      --  x"FF3F7F", -- LED 9 : Rose clair
      --  x"3FFFFF", -- LED 10 : Turquoise
      --  x"7F7F7F"  -- LED 11 : Gris moyen
    --);
    signal memoire: led_color_array := init_memoire;       
    -- Signaux internes
    signal timer_counter      : integer := 0;               -- Compteur pour les cycles d'horloge
    signal bit_counter        : integer range 0 to 23 := 0; -- Compteur pour les bits
    signal led_index          : integer range 0 to 11 := 0; -- Index de la LED actuelle
    signal current_color      : std_logic_vector(23 downto 0) := (others => '0'); -- Couleur actuelle
    signal current_bit        : std_logic := '0';           -- Bit en cours de transmission
    signal reset_done         : std_logic := '0';           -- Indicateur de reset terminé

    -- Constantes pour les timings (en cycles d'horloge à 50 MHz)
    constant T0H : integer := 17;    -- 0.35 µs pour un "0" (haut)
    constant T0L : integer := 40;    -- 0.8 µs pour un "0" (bas)
    constant T1H : integer := 35;    -- 0.7 µs pour un "1" (haut)
    constant T1L : integer := 30;    -- 0.6 µs pour un "1" (bas)
    constant RESET_TIME : integer := 2500; -- 50 µs pour le signal de reset
begin

    -- Processus principal pour gérer l'envoi des données
    process (CLK, RESET)
    begin
        if RESET = '0' then
            -- Réinitialisation des signaux
            memoire <= init_memoire;
            timer_counter <= 0;
            bit_counter <= 0;
            led_index <= 0;
            reset_done <= '0';
            current_color <= memoire(0);
            OUT_WS <= '0';
        elsif rising_edge(CLK) then
            if reset_done = '0' then
                -- Envoi du signal de reset
                if timer_counter < RESET_TIME then
                    timer_counter <= timer_counter + 1;
                    OUT_WS <= '0';
                else
                    timer_counter <= 0;
                    reset_done <= '1'; -- Fin du reset
                    current_color <= memoire(led_index); -- Charger la première couleur
                end if;
            else
                -- Envoi des bits de données
                current_bit <= current_color(23 - bit_counter); -- MSB en premier
                if current_bit = '1' then
                    -- Timing pour un bit "1"
                    if timer_counter < T1H then
                        OUT_WS <= '1';
                        timer_counter <= timer_counter + 1;
                    elsif timer_counter < (T1H + T1L) then
                        OUT_WS <= '0';
                        timer_counter <= timer_counter + 1;
                    else
                        timer_counter <= 0;
                        if bit_counter < 23 then
                            bit_counter <= bit_counter + 1; -- Prochain bit
                        else
                            bit_counter <= 0;
                            if led_index < 11 then
                                led_index <= led_index + 1; -- Prochaine LED
                                current_color <= memoire(led_index + 1);
                            else
                                led_index <= 0;
                                reset_done <= '0'; -- Recommencer avec un reset
                            end if;
                        end if;
                    end if;
                else
                    -- Timing pour un bit "0"
                    if timer_counter < T0H then
                        OUT_WS <= '1';
                        timer_counter <= timer_counter + 1;
                    elsif timer_counter < (T0H + T0L) then
                        OUT_WS <= '0';
                        timer_counter <= timer_counter + 1;
                    else
                        timer_counter <= 0;
                        if bit_counter < 23 then
                            bit_counter <= bit_counter + 1; -- Prochain bit
                        else
                            bit_counter <= 0;
                            if led_index < 11 then
                                led_index <= led_index + 1; -- Prochaine LED
                                current_color <= memoire(led_index + 1);
                            else
                                led_index <= 0;
                                reset_done <= '0'; -- Recommencer avec un reset
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
