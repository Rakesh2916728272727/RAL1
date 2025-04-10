 import uvm_pkg::*;
`include "uvm_macros.svh"
`include "apb_if.sv"
`include "apb_seq_item.sv"
`include "ral.sv"
`include  "apb_seq.sv"
`include "apb_sqr.sv"
`include "apb_drv.sv"
`include "apb_mon.sv"
`include "apb_agent.sv"
`include "apb_scb.sv"
`include "apb_env.sv"
`include "apb_test.sv"

module tb;
bit pclk;
bit presetn;
  
  always #10 pclk = ~pclk;
  initial begin
   
    presetn=1;
  end

  apb_if vif(pclk,presetn);

  top dut (.presetn(vif.presetn),
               .pclk(vif.pclk), 
               .psel(vif.psel), 
               .penable(vif.penable), 
               .pwrite(vif.pwrite), 
               .paddr(vif.paddr), 
               .pwdata(vif.pwdata), 
               .prdata(vif.prdata));


 initial begin
   uvm_config_db#(virtual apb_if)::set(null, "*", "intf", vif);
   run_test("apb_test");
 end


 initial begin
   
   $dumpfile("wave.vcd");
    $dumpvars;
   #1000 $finish;
 end

endmodule