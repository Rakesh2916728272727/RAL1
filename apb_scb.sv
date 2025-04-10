class apb_scb extends uvm_scoreboard;
  `uvm_component_utils(apb_scb)
 
  uvm_analysis_imp#(apb_seq_item,apb_scb) recv;
  bit [31:0] arr [17];
  bit [31:0] temp;
 
 
  function new(input string inst = "apb_scb", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv", this);
    endfunction
    
    
  virtual function void write(apb_seq_item tr);
    
    if(tr.pwrite == 1'b1)
      begin
        arr[tr.paddr] = tr.pwdata;
        `uvm_info("SCO", $sformatf("DATA Stored Addr : %0h Data :%0h", tr.paddr, tr.pwdata), UVM_NONE)
      end
    else
       begin
         
         temp = arr[tr.paddr];
         
         if( temp == tr.prdata)
           `uvm_info("SCO", $sformatf("Test Passed -> Addr : %0h tempData :%0h prdata=%0h", tr.paddr, temp,tr.prdata), UVM_NONE)
         else
           `uvm_error("SCO", $sformatf("Test Failed -> Addr : %0h tempData :%0h prdata=%0h", tr.paddr, temp,tr.prdata))
         
       end
       $display("----------------------------------------------------------------");
     
           
           
      endfunction
 
endclass      