library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity telemetre_us_Avalon is
    Port (
        clk        : in  std_logic;                
        rst_n      : in  std_logic;                  
        echo       : in  std_logic;                  
        trig       : out std_logic;                  
        Read_n     : in  std_logic;               
        chipselect : in  std_logic;                 
        readdata   : out std_logic_vector(31 downto 0);
        Dist_cm    : out std_logic_vector(9 downto 0) 
    );
end telemetre_us_Avalon;

architecture Behavioral of telemetre_us_Avalon is

    constant TRIG_DURATION  : integer := 500;        
    constant TIMEOUT_TICKS  : integer := 1_000_000;   
    constant WAIT_TICKS     : integer := 5_000_000;   
    constant DIVISOR        : integer := 3000;        

    signal counter         : integer := 0;           
    signal cnt_echo_ticks  : integer := 0;           
    signal distance_cm     : integer := 0;           

    type state_type is (IDLE, TRIGGER, MEASURE, WAIT100MS);
    signal state : state_type := IDLE;

begin
    -- Assignation de la distance mesurée
    Dist_cm <= std_logic_vector(to_unsigned(distance_cm, 10));
    -- Gestion Avalon
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            readdata <= (others => '0'); 
        elsif rising_edge(clk) then
            if chipselect = '1' then
                if Read_n = '0' then
                    readdata <= std_logic_vector(to_unsigned(distance_cm, 32)); -- Placer la distance sur le bus;
                end if;
            end if;
        end if;
    end process;

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            trig <= '0';
            distance_cm <= 0;
            cnt_echo_ticks <= 0;
            counter <= 0;
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    trig <= '0';
                    cnt_echo_ticks <= 0;
                    counter <= 0;
                    state <= TRIGGER;

                when TRIGGER =>
                    if counter < TRIG_DURATION then
                        counter <= counter + 1;
                        trig <= '1';
                    else
                        trig <= '0';
                        counter <= 0;
                        state <= MEASURE;
                    end if;

                when MEASURE =>
                    if echo = '1' then
                        cnt_echo_ticks <= cnt_echo_ticks + 1;
                    elsif counter < TIMEOUT_TICKS then
                        counter <= counter + 1;
                    else
                        distance_cm <= cnt_echo_ticks / DIVISOR;
                        counter <= 0;
                        state <= WAIT100MS;
                    end if;

                when WAIT100MS =>
                    if counter < WAIT_TICKS then
                        counter <= counter + 1;
                    else
                        counter <= 0;
                        state <= IDLE;
                    end if;

                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;

end Behavioral;
