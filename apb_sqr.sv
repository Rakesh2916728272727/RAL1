class apb_sqr extends uvm_sequencer#(apb_seq_item);
  `uvm_component_utils(apb_sqr)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
endclass