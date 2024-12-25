library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity ip_neopixel is
    port (
        CLK     : in  std_logic;                       -- Horloge 50 MHz
        RESET   : in  std_logic;                       -- Reset
        OUT_WS  : out std_logic                        -- Signal de sortie WS2812
    );
end entity;

architecture Behavioral of ip_neopixel is
    -- Déclaration du type tableau mémoire
    type table is array(11 downto 0) of std_logic_vector(23 downto 0);

    -- Fonction d'initialisation des couleurs
    function init_memory return table is
        variable result : table;
    begin
        result(0)  := x"00FF00"; -- Rouge
        result(1)  := x"FF0000"; -- Vert
        result(2)  := x"0000FF"; -- Bleu
        result(3)  := x"FFFF00"; -- Jaune
        result(4)  := x"00FFFF"; -- Cyan
        result(5)  := x"FF00FF"; -- Magenta
        result(6)  := x"FFFFFF"; -- Blanc
        result(7)  := x"FF7F00"; -- Orange
        result(8)  := x"7F00FF"; -- Violet
        result(9)  := x"FF3F7F"; -- Rose clair
        result(10) := x"3FFFFF"; -- Turquoise
        result(11) := x"7F7F7F"; -- Gris moyen
        return result;
    end function;

    -- Signal mémoire
    signal memory     : table := init_memory;
    signal led_index  : integer range 0 to 11 := 0;     -- Index des LEDs
    signal bit_index  : integer range 0 to 23 := 0;     -- Index des bits à envoyer
    signal current_bit: std_logic := '0';               -- Bit actuel

    -- Timing constants en cycles (50 MHz)
    constant T0H : integer := 17;  -- 0.35 µs
    constant T0L : integer := 40;  -- 0.8 µs
    constant T1H : integer := 35;  -- 0.7 µs
    constant T1L : integer := 30;  -- 0.6 µs
    constant RESET_TIME : integer := 2500; -- >50 µs (reset WS2812)

    signal state : std_logic_vector(1 downto 0) := "00"; -- FSM

begin
    process (CLK, RESET)
        variable clk_counter : integer := 0;
    begin
        if RESET = '1' then
            state <= "00";
            led_index <= 0;
            bit_index <= 0;
            clk_counter := 0;
            OUT_WS <= '0';
        elsif rising_edge(CLK) then
            case state is
                -- État : Envoi des bits
                when "00" =>
                    current_bit <= memory(led_index)(23 - bit_index); -- MSB first
                    if current_bit = '1' then
                        if clk_counter < T1H then
                            OUT_WS <= '1';
                        else
                            OUT_WS <= '0';
                        end if;
                    else
                        if clk_counter < T0H then
                            OUT_WS <= '1';
                        else
                            OUT_WS <= '0';
                        end if;
                    end if;

                    clk_counter := clk_counter + 1;
                    if clk_counter = T0H + T0L or clk_counter = T1H + T1L then
                        clk_counter := 0;
                        if bit_index = 23 then
                            bit_index <= 0;
                            if led_index = 11 then
                                led_index <= 0;
                                state <= "01"; -- Reset WS2812
                            else
                                led_index <= led_index + 1;
                            end if;
                        else
                            bit_index <= bit_index + 1;
                        end if;
                    end if;

                -- État : Reset WS2812
                when "01" =>
                    OUT_WS <= '0';
                    clk_counter := clk_counter + 1;
                    if clk_counter = RESET_TIME then
                        clk_counter := 0;
                        state <= "00"; -- Retour à l'état d'envoi des bits
                    end if;

                when others =>
                    state <= "00";
            end case;
        end if;
    end process;
end Behavioral;

    port(
        Color_In: in std_logic_vector (3 downto 0); -- Permet de choisir une couleur dans la memoire
        DataOut: out std_logic_vector (31 downto 0)
    );
end entity;

architecture Behavioral of data_memory is
    -- Déclaration du type tableau mémoire
    type table is array(11 downto 0) of std_logic_vector(23 downto 0);

    -- Fonction d'initialisation de la mémoire (12 LEDs avec des couleurs par défaut)
    function init_memory return table is
    variable result : table;
    begin
        for i in 0 to 11 loop
            result(i) := (others => '0'); -- Couleur noire (LED éteinte)
        end loop;
        result(0)  := x"00FF00"; -- Rouge
        result(1)  := x"FF0000"; -- Vert
        result(2)  := x"0000FF"; -- Bleu
        result(3)  := x"FFFF00"; -- Jaune
        result(4)  := x"00FFFF"; -- Cyan
        result(5)  := x"FF00FF"; -- Magenta
        result(6)  := x"FFFFFF"; -- Blanc
        result(7)  := x"FF7F00"; -- Orange
        result(8)  := x"7F00FF"; -- Violet
        result(9)  := x"FF3F7F"; -- Rose clair
        result(10) := x"3FFFFF"; -- Turquoise
        result(11) := x"7F7F7F"; -- Gris moyen
        return result;
    end function;

    -- Déclaration et initialisation du tableau de mémoire
    signal memory : table := init_memory;
    begin
        DataOut <= memory(to_integer(unsigned(Color_In)));
    end architecture;
