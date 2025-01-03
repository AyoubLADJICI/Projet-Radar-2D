// Computer_System_tb.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module Computer_System_tb (
	);

	wire         computer_system_inst_system_pll_ref_clk_bfm_clk_clk;                // Computer_System_inst_system_pll_ref_clk_bfm:clk -> [Computer_System_inst:system_pll_ref_clk_clk, Computer_System_inst_system_pll_ref_reset_bfm:clk]
	wire         computer_system_inst_video_pll_ref_clk_bfm_clk_clk;                 // Computer_System_inst_video_pll_ref_clk_bfm:clk -> [Computer_System_inst:video_pll_ref_clk_clk, Computer_System_inst_video_pll_ref_reset_bfm:clk]
	wire         sdram_my_partner_clk_bfm_clk_clk;                                   // SDRAM_my_partner_clk_bfm:clk -> SDRAM_my_partner:clk
	wire   [9:0] computer_system_inst_avalon_telemetre_0_telemetre_readdata;         // Computer_System_inst:avalon_telemetre_0_telemetre_readdata -> Computer_System_inst_avalon_telemetre_0_telemetre_bfm:sig_readdata
	wire   [0:0] computer_system_inst_avalon_telemetre_0_telemetre_bfm_conduit_echo; // Computer_System_inst_avalon_telemetre_0_telemetre_bfm:sig_echo -> Computer_System_inst:avalon_telemetre_0_telemetre_echo
	wire         computer_system_inst_avalon_telemetre_0_telemetre_trig;             // Computer_System_inst:avalon_telemetre_0_telemetre_trig -> Computer_System_inst_avalon_telemetre_0_telemetre_bfm:sig_trig
	wire  [31:0] computer_system_inst_hex3_hex0_export;                              // Computer_System_inst:hex3_hex0_export -> Computer_System_inst_hex3_hex0_bfm:sig_export
	wire  [15:0] computer_system_inst_hex5_hex4_export;                              // Computer_System_inst:hex5_hex4_export -> Computer_System_inst_hex5_hex4_bfm:sig_export
	wire   [9:0] computer_system_inst_leds_export;                                   // Computer_System_inst:leds_export -> Computer_System_inst_leds_bfm:sig_export
	wire   [1:0] computer_system_inst_pushbuttons_bfm_conduit_export;                // Computer_System_inst_pushbuttons_bfm:sig_export -> Computer_System_inst:pushbuttons_export
	wire         computer_system_inst_sdram_cs_n;                                    // Computer_System_inst:sdram_cs_n -> SDRAM_my_partner:zs_cs_n
	wire   [1:0] computer_system_inst_sdram_dqm;                                     // Computer_System_inst:sdram_dqm -> SDRAM_my_partner:zs_dqm
	wire         computer_system_inst_sdram_cas_n;                                   // Computer_System_inst:sdram_cas_n -> SDRAM_my_partner:zs_cas_n
	wire         computer_system_inst_sdram_ras_n;                                   // Computer_System_inst:sdram_ras_n -> SDRAM_my_partner:zs_ras_n
	wire         computer_system_inst_sdram_we_n;                                    // Computer_System_inst:sdram_we_n -> SDRAM_my_partner:zs_we_n
	wire  [12:0] computer_system_inst_sdram_addr;                                    // Computer_System_inst:sdram_addr -> SDRAM_my_partner:zs_addr
	wire         computer_system_inst_sdram_cke;                                     // Computer_System_inst:sdram_cke -> SDRAM_my_partner:zs_cke
	wire  [15:0] computer_system_inst_sdram_dq;                                      // [] -> [Computer_System_inst:sdram_dq, SDRAM_my_partner:zs_dq]
	wire   [1:0] computer_system_inst_sdram_ba;                                      // Computer_System_inst:sdram_ba -> SDRAM_my_partner:zs_ba
	wire   [9:0] computer_system_inst_slider_switches_bfm_conduit_export;            // Computer_System_inst_slider_switches_bfm:sig_export -> Computer_System_inst:slider_switches_export
	wire         computer_system_inst_system_pll_ref_reset_bfm_reset_reset;          // Computer_System_inst_system_pll_ref_reset_bfm:reset -> Computer_System_inst:system_pll_ref_reset_reset
	wire         computer_system_inst_video_pll_ref_reset_bfm_reset_reset;           // Computer_System_inst_video_pll_ref_reset_bfm:reset -> Computer_System_inst:video_pll_ref_reset_reset

	Computer_System computer_system_inst (
		.avalon_telemetre_0_telemetre_trig     (computer_system_inst_avalon_telemetre_0_telemetre_trig),             // avalon_telemetre_0_telemetre.trig
		.avalon_telemetre_0_telemetre_echo     (computer_system_inst_avalon_telemetre_0_telemetre_bfm_conduit_echo), //                             .echo
		.avalon_telemetre_0_telemetre_readdata (computer_system_inst_avalon_telemetre_0_telemetre_readdata),         //                             .readdata
		.hex3_hex0_export                      (computer_system_inst_hex3_hex0_export),                              //                    hex3_hex0.export
		.hex5_hex4_export                      (computer_system_inst_hex5_hex4_export),                              //                    hex5_hex4.export
		.leds_export                           (computer_system_inst_leds_export),                                   //                         leds.export
		.pushbuttons_export                    (computer_system_inst_pushbuttons_bfm_conduit_export),                //                  pushbuttons.export
		.sdram_addr                            (computer_system_inst_sdram_addr),                                    //                        sdram.addr
		.sdram_ba                              (computer_system_inst_sdram_ba),                                      //                             .ba
		.sdram_cas_n                           (computer_system_inst_sdram_cas_n),                                   //                             .cas_n
		.sdram_cke                             (computer_system_inst_sdram_cke),                                     //                             .cke
		.sdram_cs_n                            (computer_system_inst_sdram_cs_n),                                    //                             .cs_n
		.sdram_dq                              (computer_system_inst_sdram_dq),                                      //                             .dq
		.sdram_dqm                             (computer_system_inst_sdram_dqm),                                     //                             .dqm
		.sdram_ras_n                           (computer_system_inst_sdram_ras_n),                                   //                             .ras_n
		.sdram_we_n                            (computer_system_inst_sdram_we_n),                                    //                             .we_n
		.sdram_clk_clk                         (),                                                                   //                    sdram_clk.clk
		.slider_switches_export                (computer_system_inst_slider_switches_bfm_conduit_export),            //              slider_switches.export
		.system_pll_ref_clk_clk                (computer_system_inst_system_pll_ref_clk_bfm_clk_clk),                //           system_pll_ref_clk.clk
		.system_pll_ref_reset_reset            (computer_system_inst_system_pll_ref_reset_bfm_reset_reset),          //         system_pll_ref_reset.reset
		.video_pll_ref_clk_clk                 (computer_system_inst_video_pll_ref_clk_bfm_clk_clk),                 //            video_pll_ref_clk.clk
		.video_pll_ref_reset_reset             (computer_system_inst_video_pll_ref_reset_bfm_reset_reset)            //          video_pll_ref_reset.reset
	);

	altera_conduit_bfm computer_system_inst_avalon_telemetre_0_telemetre_bfm (
		.sig_echo     (computer_system_inst_avalon_telemetre_0_telemetre_bfm_conduit_echo), // conduit.echo
		.sig_readdata (computer_system_inst_avalon_telemetre_0_telemetre_readdata),         //        .readdata
		.sig_trig     (computer_system_inst_avalon_telemetre_0_telemetre_trig)              //        .trig
	);

	altera_conduit_bfm_0002 computer_system_inst_hex3_hex0_bfm (
		.sig_export (computer_system_inst_hex3_hex0_export)  // conduit.export
	);

	altera_conduit_bfm_0003 computer_system_inst_hex5_hex4_bfm (
		.sig_export (computer_system_inst_hex5_hex4_export)  // conduit.export
	);

	altera_conduit_bfm_0004 computer_system_inst_leds_bfm (
		.sig_export (computer_system_inst_leds_export)  // conduit.export
	);

	altera_conduit_bfm_0005 computer_system_inst_pushbuttons_bfm (
		.sig_export (computer_system_inst_pushbuttons_bfm_conduit_export)  // conduit.export
	);

	altera_conduit_bfm_0006 computer_system_inst_slider_switches_bfm (
		.sig_export (computer_system_inst_slider_switches_bfm_conduit_export)  // conduit.export
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) computer_system_inst_system_pll_ref_clk_bfm (
		.clk (computer_system_inst_system_pll_ref_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (1),
		.INITIAL_RESET_CYCLES (50)
	) computer_system_inst_system_pll_ref_reset_bfm (
		.reset (computer_system_inst_system_pll_ref_reset_bfm_reset_reset), // reset.reset
		.clk   (computer_system_inst_system_pll_ref_clk_bfm_clk_clk)        //   clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) computer_system_inst_video_pll_ref_clk_bfm (
		.clk (computer_system_inst_video_pll_ref_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (1),
		.INITIAL_RESET_CYCLES (50)
	) computer_system_inst_video_pll_ref_reset_bfm (
		.reset (computer_system_inst_video_pll_ref_reset_bfm_reset_reset), // reset.reset
		.clk   (computer_system_inst_video_pll_ref_clk_bfm_clk_clk)        //   clk.clk
	);

	altera_sdram_partner_module sdram_my_partner (
		.clk      (sdram_my_partner_clk_bfm_clk_clk), //     clk.clk
		.zs_dq    (computer_system_inst_sdram_dq),    // conduit.dq
		.zs_addr  (computer_system_inst_sdram_addr),  //        .addr
		.zs_ba    (computer_system_inst_sdram_ba),    //        .ba
		.zs_cas_n (computer_system_inst_sdram_cas_n), //        .cas_n
		.zs_cke   (computer_system_inst_sdram_cke),   //        .cke
		.zs_cs_n  (computer_system_inst_sdram_cs_n),  //        .cs_n
		.zs_dqm   (computer_system_inst_sdram_dqm),   //        .dqm
		.zs_ras_n (computer_system_inst_sdram_ras_n), //        .ras_n
		.zs_we_n  (computer_system_inst_sdram_we_n)   //        .we_n
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (100000000),
		.CLOCK_UNIT (1)
	) sdram_my_partner_clk_bfm (
		.clk (sdram_my_partner_clk_bfm_clk_clk)  // clk.clk
	);

endmodule
