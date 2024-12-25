	Computer_System u0 (
		.avalon_servomoteur_0_servomoteur_commande (<connected-to-avalon_servomoteur_0_servomoteur_commande>), // avalon_servomoteur_0_servomoteur.commande
		.avalon_telemetre_0_telemetre_distance     (<connected-to-avalon_telemetre_0_telemetre_distance>),     //     avalon_telemetre_0_telemetre.distance
		.avalon_telemetre_0_telemetre_echo         (<connected-to-avalon_telemetre_0_telemetre_echo>),         //                                 .echo
		.avalon_telemetre_0_telemetre_trig         (<connected-to-avalon_telemetre_0_telemetre_trig>),         //                                 .trig
		.hex3_hex0_export                          (<connected-to-hex3_hex0_export>),                          //                        hex3_hex0.export
		.hex5_hex4_export                          (<connected-to-hex5_hex4_export>),                          //                        hex5_hex4.export
		.leds_export                               (<connected-to-leds_export>),                               //                             leds.export
		.pushbuttons_export                        (<connected-to-pushbuttons_export>),                        //                      pushbuttons.export
		.sdram_addr                                (<connected-to-sdram_addr>),                                //                            sdram.addr
		.sdram_ba                                  (<connected-to-sdram_ba>),                                  //                                 .ba
		.sdram_cas_n                               (<connected-to-sdram_cas_n>),                               //                                 .cas_n
		.sdram_cke                                 (<connected-to-sdram_cke>),                                 //                                 .cke
		.sdram_cs_n                                (<connected-to-sdram_cs_n>),                                //                                 .cs_n
		.sdram_dq                                  (<connected-to-sdram_dq>),                                  //                                 .dq
		.sdram_dqm                                 (<connected-to-sdram_dqm>),                                 //                                 .dqm
		.sdram_ras_n                               (<connected-to-sdram_ras_n>),                               //                                 .ras_n
		.sdram_we_n                                (<connected-to-sdram_we_n>),                                //                                 .we_n
		.sdram_clk_clk                             (<connected-to-sdram_clk_clk>),                             //                        sdram_clk.clk
		.slider_switches_export                    (<connected-to-slider_switches_export>),                    //                  slider_switches.export
		.system_pll_ref_clk_clk                    (<connected-to-system_pll_ref_clk_clk>),                    //               system_pll_ref_clk.clk
		.system_pll_ref_reset_reset                (<connected-to-system_pll_ref_reset_reset>),                //             system_pll_ref_reset.reset
		.video_pll_ref_clk_clk                     (<connected-to-video_pll_ref_clk_clk>),                     //                video_pll_ref_clk.clk
		.video_pll_ref_reset_reset                 (<connected-to-video_pll_ref_reset_reset>)                  //              video_pll_ref_reset.reset
	);

