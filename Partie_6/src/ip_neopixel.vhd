library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ip_neopixel is
    port (
        clk     : in  std_logic;   
        reset_n : in  std_logic;
        --on va commander le nombre de leds allumées avec nos switchs
        SW     : in  std_logic_vector(3 downto 0);    
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
    --les couleurs sont au format GRB comme requis dans la datasheet
    result(0) := x"FF0000"; --LED 0 : Vert
    result(1) := x"00FF00"; --LED 1 : Rouge
    result(2) := x"FFFFFF"; --LED 2 : Blanc
    result(3) := x"0000FF"; --LED 3 : Bleu
    result(4) := x"80FF00"; --LED 4 : Orange
    result(5) := x"FFFF00"; --LED 5 : Jaune
    result(6) := x"203B77"; --LED 6 : Violet
    result(7) := x"18FFFF"; --LED 7 : Rose
    result(8) := x"E040D0"; --LED 8 : Turquoise
    result(9) := x"808080"; --LED 9 : Gris
    result(10) := x"FA2BFA"; --LED 10 : Cyan
    result(11) := x"00FFFF"; --LED 11 : Magenta
    return result;
end init_memoire;

signal memoire: led_color_array := init_memoire;    
signal cnt_ticks     : unsigned(11 downto 0) := (others => '0');
signal cnt_bits      : integer range 0 to 23 := 0;
signal led_index     : integer range 0 to 11 := 0;
signal couleur_index : std_logic_vector(23 downto 0) := (others => '0');
signal high_time : integer := 0;
signal low_time  : integer := 0;
signal num_leds : integer range 0 to 12 := 0;


type state_type is (RESET_STATE, LOAD_COLOR, SEND_BIT, NEXT_LED);
signal state : state_type := RESET_STATE;

--On utilise une frequence d'horloge de 50MHz
--Alors on a une periode de 20ns 
--1 tick = 20ns
constant T0H : integer := 18; --18 ticks ≃ 0.35 µs (impossible d'avoir exactement 0.35 µs car il faudrait 17.5 ticks)
constant T0L : integer := 40; --40 ticks = 0.8 µs 
constant T1H : integer := 35; --35 ticks = 0.7 µs 
constant T1L : integer := 30; --30 ticks = 0.6 µs 
constant RESET_DURATION : integer := 2500; --2500 ticks = 50 µs 

begin
    process (SW)
    begin
        num_leds <= to_integer(unsigned(SW));
        if num_leds > 12 then
            --Notre anneau contient 12 leds
            num_leds <= 12; 
        end if;
    end process;

    process (clk, reset_n)
    begin
        if reset_n = '0' then
            cnt_ticks <= (others => '0');
            cnt_bits <= 0;
            led_index <= 0;
            couleur_index <= (others => '0');
            OUT_WS <= '1';
            state <= RESET_STATE;
        elsif rising_edge(clk) then
            case state is
                --Avant de commencer à envoyer les couleurs ou après avoir transmis toutes les couleurs
                --On envoi un signal de reset
                when RESET_STATE =>
                    if cnt_ticks < RESET_DURATION then
                        cnt_ticks <= cnt_ticks + 1;
                        OUT_WS <= '0';
                    else
                        cnt_ticks <= (others => '0');
                        state <= LOAD_COLOR;
                    end if;
                
                when LOAD_COLOR =>
                    if led_index < num_leds then
                        couleur_index <= memoire(led_index);
                    else
                        --On a fini d'allumer toutes les leds demandées
                        --les leds restantes seront éteintes
                        couleur_index <= x"000000";
                    end if;
                    cnt_bits <= 0;
                    state <= SEND_BIT;
                
                when SEND_BIT =>
                    --Si le bit est à 1, on respecte le diagramme de séquence T1H puis T1L
                    --Sinon on respecte le diagramme de séquence T0H puis T0L
                    if couleur_index(23 - cnt_bits) = '1' then
                        high_time <= T1H;
                        low_time <= T1L;
                    else
                        high_time <= T0H;
                        low_time <= T0L;
                    end if;
                    
                    if cnt_ticks < high_time then
                        OUT_WS <= '1';
                        cnt_ticks <= cnt_ticks + 1;
                    elsif cnt_ticks < (high_time + low_time) then
                        OUT_WS <= '0';
                        cnt_ticks <= cnt_ticks + 1;
                    else
                        cnt_ticks <= (others => '0');
                        --On parcoure tous les bits de notre signal de données de la couleur
                        if cnt_bits < 23 then
                            cnt_bits <= cnt_bits + 1;
                        else
                            cnt_bits <= 0;
                            state <= NEXT_LED;
                        end if;
                    end if;
                
                when NEXT_LED =>
                    --On parcoure toutes les leds sur notre anneau
                    if led_index < 11 then
                        led_index <= led_index + 1;
                        state <= LOAD_COLOR;
                    else
                        --On a fini de transmettre toutes les couleurs
                        --On demande une pause RESET et on recommence à partir de la première LED
                        led_index <= 0;
                        state <= RESET_STATE;
                    end if;
                
                when others =>
                    state <= RESET_STATE;
            end case;
        end if;
    end process;
end Behavioral;
