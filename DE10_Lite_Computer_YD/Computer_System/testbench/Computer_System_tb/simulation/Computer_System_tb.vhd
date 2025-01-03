-- Computer_System_tb.vhd

-- Generated using ACDS version 18.1 625

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Computer_System_tb is
end entity Computer_System_tb;

architecture rtl of Computer_System_tb is
	component Computer_System is
		port (
			avalon_servomoteur_0_servomoteur_commande : out   std_logic;                                        -- commande
			avalon_telemetre_0_telemetre_distance     : out   std_logic_vector(9 downto 0);                     -- distance
			avalon_telemetre_0_telemetre_echo         : in    std_logic                     := 'X';             -- echo
			avalon_telemetre_0_telemetre_trig         : out   std_logic;                                        -- trig
			hex3_hex0_export                          : out   std_logic_vector(31 downto 0);                    -- export
			hex5_hex4_export                          : out   std_logic_vector(15 downto 0);                    -- export
			leds_export                               : out   std_logic_vector(9 downto 0);                     -- export
			pushbuttons_export                        : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			sdram_addr                                : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba                                  : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n                               : out   std_logic;                                        -- cas_n
			sdram_cke                                 : out   std_logic;                                        -- cke
			sdram_cs_n                                : out   std_logic;                                        -- cs_n
			sdram_dq                                  : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_dqm                                 : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ras_n                               : out   std_logic;                                        -- ras_n
			sdram_we_n                                : out   std_logic;                                        -- we_n
			sdram_clk_clk                             : out   std_logic;                                        -- clk
			slider_switches_export                    : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			system_pll_ref_clk_clk                    : in    std_logic                     := 'X';             -- clk
			system_pll_ref_reset_reset                : in    std_logic                     := 'X';             -- reset
			video_pll_ref_clk_clk                     : in    std_logic                     := 'X';             -- clk
			video_pll_ref_reset_reset                 : in    std_logic                     := 'X'              -- reset
		);
	end component Computer_System;

	component altera_conduit_bfm is
		port (
			sig_commande : in std_logic_vector(0 downto 0) := (others => 'X')  -- commande
		);
	end component altera_conduit_bfm;

	component altera_conduit_bfm_0002 is
		port (
			sig_distance : in  std_logic_vector(9 downto 0) := (others => 'X'); -- distance
			sig_echo     : out std_logic_vector(0 downto 0);                    -- echo
			sig_trig     : in  std_logic_vector(0 downto 0) := (others => 'X')  -- trig
		);
	end component altera_conduit_bfm_0002;

	component altera_conduit_bfm_0003 is
		port (
			sig_export : in std_logic_vector(31 downto 0) := (others => 'X')  -- export
		);
	end component altera_conduit_bfm_0003;

	component altera_conduit_bfm_0004 is
		port (
			sig_export : in std_logic_vector(15 downto 0) := (others => 'X')  -- export
		);
	end component altera_conduit_bfm_0004;

	component altera_conduit_bfm_0005 is
		port (
			sig_export : in std_logic_vector(9 downto 0) := (others => 'X')  -- export
		);
	end component altera_conduit_bfm_0005;

	component altera_conduit_bfm_0006 is
		port (
			sig_export : out std_logic_vector(1 downto 0)   -- export
		);
	end component altera_conduit_bfm_0006;

	component altera_conduit_bfm_0007 is
		port (
			sig_export : out std_logic_vector(9 downto 0)   -- export
		);
	end component altera_conduit_bfm_0007;

	component altera_avalon_clock_source is
		generic (
			CLOCK_RATE : positive := 10;
			CLOCK_UNIT : positive := 1000000
		);
		port (
			clk : out std_logic   -- clk
		);
	end component altera_avalon_clock_source;

	component altera_avalon_reset_source is
		generic (
			ASSERT_HIGH_RESET    : integer := 1;
			INITIAL_RESET_CYCLES : integer := 0
		);
		port (
			reset : out std_logic;        -- reset
			clk   : in  std_logic := 'X'  -- clk
		);
	end component altera_avalon_reset_source;

	component altera_sdram_partner_module is
		port (
			clk      : in    std_logic                     := 'X';             -- clk
			zs_dq    : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			zs_addr  : in    std_logic_vector(12 downto 0) := (others => 'X'); -- addr
			zs_ba    : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- ba
			zs_cas_n : in    std_logic                     := 'X';             -- cas_n
			zs_cke   : in    std_logic                     := 'X';             -- cke
			zs_cs_n  : in    std_logic                     := 'X';             -- cs_n
			zs_dqm   : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- dqm
			zs_ras_n : in    std_logic                     := 'X';             -- ras_n
			zs_we_n  : in    std_logic                     := 'X'              -- we_n
		);
	end component altera_sdram_partner_module;

	signal computer_system_inst_system_pll_ref_clk_bfm_clk_clk                : std_logic;                     -- Computer_System_inst_system_pll_ref_clk_bfm:clk -> [Computer_System_inst:system_pll_ref_clk_clk, Computer_System_inst_system_pll_ref_reset_bfm:clk]
	signal computer_system_inst_video_pll_ref_clk_bfm_clk_clk                 : std_logic;                     -- Computer_System_inst_video_pll_ref_clk_bfm:clk -> [Computer_System_inst:video_pll_ref_clk_clk, Computer_System_inst_video_pll_ref_reset_bfm:clk]
	signal sdram_my_partner_clk_bfm_clk_clk                                   : std_logic;                     -- SDRAM_my_partner_clk_bfm:clk -> SDRAM_my_partner:clk
	signal computer_system_inst_avalon_servomoteur_0_servomoteur_commande     : std_logic;                     -- Computer_System_inst:avalon_servomoteur_0_servomoteur_commande -> Computer_System_inst_avalon_servomoteur_0_servomoteur_bfm:sig_commande
	signal computer_system_inst_avalon_telemetre_0_telemetre_distance         : std_logic_vector(9 downto 0);  -- Computer_System_inst:avalon_telemetre_0_telemetre_distance -> Computer_System_inst_avalon_telemetre_0_telemetre_bfm:sig_distance
	signal computer_system_inst_avalon_telemetre_0_telemetre_bfm_conduit_echo : std_logic_vector(0 downto 0);  -- Computer_System_inst_avalon_telemetre_0_telemetre_bfm:sig_echo -> Computer_System_inst:avalon_telemetre_0_telemetre_echo
	signal computer_system_inst_avalon_telemetre_0_telemetre_trig             : std_logic;                     -- Computer_System_inst:avalon_telemetre_0_telemetre_trig -> Computer_System_inst_avalon_telemetre_0_telemetre_bfm:sig_trig
	signal computer_system_inst_hex3_hex0_export                              : std_logic_vector(31 downto 0); -- Computer_System_inst:hex3_hex0_export -> Computer_System_inst_hex3_hex0_bfm:sig_export
	signal computer_system_inst_hex5_hex4_export                              : std_logic_vector(15 downto 0); -- Computer_System_inst:hex5_hex4_export -> Computer_System_inst_hex5_hex4_bfm:sig_export
	signal computer_system_inst_leds_export                                   : std_logic_vector(9 downto 0);  -- Computer_System_inst:leds_export -> Computer_System_inst_leds_bfm:sig_export
	signal computer_system_inst_pushbuttons_bfm_conduit_export                : std_logic_vector(1 downto 0);  -- Computer_System_inst_pushbuttons_bfm:sig_export -> Computer_System_inst:pushbuttons_export
	signal computer_system_inst_sdram_cs_n                                    : std_logic;                     -- Computer_System_inst:sdram_cs_n -> SDRAM_my_partner:zs_cs_n
	signal computer_system_inst_sdram_dqm                                     : std_logic_vector(1 downto 0);  -- Computer_System_inst:sdram_dqm -> SDRAM_my_partner:zs_dqm
	signal computer_system_inst_sdram_cas_n                                   : std_logic;                     -- Computer_System_inst:sdram_cas_n -> SDRAM_my_partner:zs_cas_n
	signal computer_system_inst_sdram_ras_n                                   : std_logic;                     -- Computer_System_inst:sdram_ras_n -> SDRAM_my_partner:zs_ras_n
	signal computer_system_inst_sdram_we_n                                    : std_logic;                     -- Computer_System_inst:sdram_we_n -> SDRAM_my_partner:zs_we_n
	signal computer_system_inst_sdram_addr                                    : std_logic_vector(12 downto 0); -- Computer_System_inst:sdram_addr -> SDRAM_my_partner:zs_addr
	signal computer_system_inst_sdram_cke                                     : std_logic;                     -- Computer_System_inst:sdram_cke -> SDRAM_my_partner:zs_cke
	signal computer_system_inst_sdram_dq                                      : std_logic_vector(15 downto 0); -- [] -> [Computer_System_inst:sdram_dq, SDRAM_my_partner:zs_dq]
	signal computer_system_inst_sdram_ba                                      : std_logic_vector(1 downto 0);  -- Computer_System_inst:sdram_ba -> SDRAM_my_partner:zs_ba
	signal computer_system_inst_slider_switches_bfm_conduit_export            : std_logic_vector(9 downto 0);  -- Computer_System_inst_slider_switches_bfm:sig_export -> Computer_System_inst:slider_switches_export
	signal computer_system_inst_system_pll_ref_reset_bfm_reset_reset          : std_logic;                     -- Computer_System_inst_system_pll_ref_reset_bfm:reset -> Computer_System_inst:system_pll_ref_reset_reset
	signal computer_system_inst_video_pll_ref_reset_bfm_reset_reset           : std_logic;                     -- Computer_System_inst_video_pll_ref_reset_bfm:reset -> Computer_System_inst:video_pll_ref_reset_reset

begin

	computer_system_inst : component Computer_System
		port map (
			avalon_servomoteur_0_servomoteur_commande => computer_system_inst_avalon_servomoteur_0_servomoteur_commande,        -- avalon_servomoteur_0_servomoteur.commande
			avalon_telemetre_0_telemetre_distance     => computer_system_inst_avalon_telemetre_0_telemetre_distance,            --     avalon_telemetre_0_telemetre.distance
			avalon_telemetre_0_telemetre_echo         => computer_system_inst_avalon_telemetre_0_telemetre_bfm_conduit_echo(0), --                                 .echo
			avalon_telemetre_0_telemetre_trig         => computer_system_inst_avalon_telemetre_0_telemetre_trig,                --                                 .trig
			hex3_hex0_export                          => computer_system_inst_hex3_hex0_export,                                 --                        hex3_hex0.export
			hex5_hex4_export                          => computer_system_inst_hex5_hex4_export,                                 --                        hex5_hex4.export
			leds_export                               => computer_system_inst_leds_export,                                      --                             leds.export
			pushbuttons_export                        => computer_system_inst_pushbuttons_bfm_conduit_export,                   --                      pushbuttons.export
			sdram_addr                                => computer_system_inst_sdram_addr,                                       --                            sdram.addr
			sdram_ba                                  => computer_system_inst_sdram_ba,                                         --                                 .ba
			sdram_cas_n                               => computer_system_inst_sdram_cas_n,                                      --                                 .cas_n
			sdram_cke                                 => computer_system_inst_sdram_cke,                                        --                                 .cke
			sdram_cs_n                                => computer_system_inst_sdram_cs_n,                                       --                                 .cs_n
			sdram_dq                                  => computer_system_inst_sdram_dq,                                         --                                 .dq
			sdram_dqm                                 => computer_system_inst_sdram_dqm,                                        --                                 .dqm
			sdram_ras_n                               => computer_system_inst_sdram_ras_n,                                      --                                 .ras_n
			sdram_we_n                                => computer_system_inst_sdram_we_n,                                       --                                 .we_n
			sdram_clk_clk                             => open,                                                                  --                        sdram_clk.clk
			slider_switches_export                    => computer_system_inst_slider_switches_bfm_conduit_export,               --                  slider_switches.export
			system_pll_ref_clk_clk                    => computer_system_inst_system_pll_ref_clk_bfm_clk_clk,                   --               system_pll_ref_clk.clk
			system_pll_ref_reset_reset                => computer_system_inst_system_pll_ref_reset_bfm_reset_reset,             --             system_pll_ref_reset.reset
			video_pll_ref_clk_clk                     => computer_system_inst_video_pll_ref_clk_bfm_clk_clk,                    --                video_pll_ref_clk.clk
			video_pll_ref_reset_reset                 => computer_system_inst_video_pll_ref_reset_bfm_reset_reset               --              video_pll_ref_reset.reset
		);

	computer_system_inst_avalon_servomoteur_0_servomoteur_bfm : component altera_conduit_bfm
		port map (
			sig_commande(0) => computer_system_inst_avalon_servomoteur_0_servomoteur_commande  -- conduit.commande
		);

	computer_system_inst_avalon_telemetre_0_telemetre_bfm : component altera_conduit_bfm_0002
		port map (
			sig_distance => computer_system_inst_avalon_telemetre_0_telemetre_distance,         -- conduit.distance
			sig_echo     => computer_system_inst_avalon_telemetre_0_telemetre_bfm_conduit_echo, --        .echo
			sig_trig(0)  => computer_system_inst_avalon_telemetre_0_telemetre_trig              --        .trig
		);

	computer_system_inst_hex3_hex0_bfm : component altera_conduit_bfm_0003
		port map (
			sig_export => computer_system_inst_hex3_hex0_export  -- conduit.export
		);

	computer_system_inst_hex5_hex4_bfm : component altera_conduit_bfm_0004
		port map (
			sig_export => computer_system_inst_hex5_hex4_export  -- conduit.export
		);

	computer_system_inst_leds_bfm : component altera_conduit_bfm_0005
		port map (
			sig_export => computer_system_inst_leds_export  -- conduit.export
		);

	computer_system_inst_pushbuttons_bfm : component altera_conduit_bfm_0006
		port map (
			sig_export => computer_system_inst_pushbuttons_bfm_conduit_export  -- conduit.export
		);

	computer_system_inst_slider_switches_bfm : component altera_conduit_bfm_0007
		port map (
			sig_export => computer_system_inst_slider_switches_bfm_conduit_export  -- conduit.export
		);

	computer_system_inst_system_pll_ref_clk_bfm : component altera_avalon_clock_source
		generic map (
			CLOCK_RATE => 50000000,
			CLOCK_UNIT => 1
		)
		port map (
			clk => computer_system_inst_system_pll_ref_clk_bfm_clk_clk  -- clk.clk
		);

	computer_system_inst_system_pll_ref_reset_bfm : component altera_avalon_reset_source
		generic map (
			ASSERT_HIGH_RESET    => 1,
			INITIAL_RESET_CYCLES => 50
		)
		port map (
			reset => computer_system_inst_system_pll_ref_reset_bfm_reset_reset, -- reset.reset
			clk   => computer_system_inst_system_pll_ref_clk_bfm_clk_clk        --   clk.clk
		);

	computer_system_inst_video_pll_ref_clk_bfm : component altera_avalon_clock_source
		generic map (
			CLOCK_RATE => 50000000,
			CLOCK_UNIT => 1
		)
		port map (
			clk => computer_system_inst_video_pll_ref_clk_bfm_clk_clk  -- clk.clk
		);

	computer_system_inst_video_pll_ref_reset_bfm : component altera_avalon_reset_source
		generic map (
			ASSERT_HIGH_RESET    => 1,
			INITIAL_RESET_CYCLES => 50
		)
		port map (
			reset => computer_system_inst_video_pll_ref_reset_bfm_reset_reset, -- reset.reset
			clk   => computer_system_inst_video_pll_ref_clk_bfm_clk_clk        --   clk.clk
		);

	sdram_my_partner : component altera_sdram_partner_module
		port map (
			clk      => sdram_my_partner_clk_bfm_clk_clk, --     clk.clk
			zs_dq    => computer_system_inst_sdram_dq,    -- conduit.dq
			zs_addr  => computer_system_inst_sdram_addr,  --        .addr
			zs_ba    => computer_system_inst_sdram_ba,    --        .ba
			zs_cas_n => computer_system_inst_sdram_cas_n, --        .cas_n
			zs_cke   => computer_system_inst_sdram_cke,   --        .cke
			zs_cs_n  => computer_system_inst_sdram_cs_n,  --        .cs_n
			zs_dqm   => computer_system_inst_sdram_dqm,   --        .dqm
			zs_ras_n => computer_system_inst_sdram_ras_n, --        .ras_n
			zs_we_n  => computer_system_inst_sdram_we_n   --        .we_n
		);

	sdram_my_partner_clk_bfm : component altera_avalon_clock_source
		generic map (
			CLOCK_RATE => 100000000,
			CLOCK_UNIT => 1
		)
		port map (
			clk => sdram_my_partner_clk_bfm_clk_clk  -- clk.clk
		);

end architecture rtl; -- of Computer_System_tb
