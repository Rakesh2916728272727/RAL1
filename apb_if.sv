interface apb_if (input pclk,presetn);
 // Signals
 logic [31:0] paddr;
 logic pwrite;
 logic [31:0] pwdata;
 logic penable;
 logic psel;
 logic [31:0] prdata;
 

endinterface 