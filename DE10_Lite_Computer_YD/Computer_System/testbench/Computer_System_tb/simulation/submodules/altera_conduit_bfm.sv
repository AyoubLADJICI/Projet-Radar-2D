// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       altera_conduit_bfm
// role:width:direction:                              echo:1:output,readdata:10:input,trig:1:input
// 0
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module altera_conduit_bfm
(
   sig_echo,
   sig_readdata,
   sig_trig
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   output sig_echo;
   input [9 : 0] sig_readdata;
   input sig_trig;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_echo_t;
   typedef logic [9 : 0] ROLE_readdata_t;
   typedef logic ROLE_trig_t;

   reg sig_echo_temp;
   reg sig_echo_out;
   logic [9 : 0] sig_readdata_in;
   logic [9 : 0] sig_readdata_local;
   logic [0 : 0] sig_trig_in;
   logic [0 : 0] sig_trig_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_input_readdata_change;
   event signal_input_trig_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "18.1";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // echo
   // -------------------------------------------------------

   function automatic void set_echo (
      ROLE_echo_t new_value
   );
      // Drive the new value to echo.
      
      $sformat(message, "%m: method called arg0 %0d", new_value); 
      print(VERBOSITY_DEBUG, message);
      
      sig_echo_temp = new_value;
   endfunction

   // -------------------------------------------------------
   // readdata
   // -------------------------------------------------------
   function automatic ROLE_readdata_t get_readdata();
   
      // Gets the readdata input value.
      $sformat(message, "%m: called get_readdata");
      print(VERBOSITY_DEBUG, message);
      return sig_readdata_in;
      
   endfunction

   // -------------------------------------------------------
   // trig
   // -------------------------------------------------------
   function automatic ROLE_trig_t get_trig();
   
      // Gets the trig input value.
      $sformat(message, "%m: called get_trig");
      print(VERBOSITY_DEBUG, message);
      return sig_trig_in;
      
   endfunction

   assign sig_echo = sig_echo_temp;
   assign sig_readdata_in = sig_readdata;
   assign sig_trig_in = sig_trig;


   always @(sig_readdata_in) begin
      if (sig_readdata_local != sig_readdata_in)
         -> signal_input_readdata_change;
      sig_readdata_local = sig_readdata_in;
   end
   
   always @(sig_trig_in) begin
      if (sig_trig_local != sig_trig_in)
         -> signal_input_trig_change;
      sig_trig_local = sig_trig_in;
   end
   


// synthesis translate_on

endmodule

