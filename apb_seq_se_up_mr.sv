class apb_seq_se_up_mr extends base_seq;
  `uvm_object_utils(apb_seq_se_up_mr)
  bit[31:0] read_data;
uvm_status_e status;
  function new(string name ="apb_seq_se_up_mr");
 super.new(name);
 endfunction

virtual task body();
   
  model.ctrl_register_inst.set(1);
  `uvm_info("[SEQ]:", $sformatf("set ctrl_register -> Desired Value: %0h & Mirrored Value: %0h ", model.ctrl_register_inst.get(), model.ctrl_register_inst.get_mirrored_value()),UVM_LOW);
 
  
  model.ctrl_register_inst.update(status);
  `uvm_info("[SEQ]:", $sformatf("update ctrl_register -> Desired Value: %0h & Mirrored Value: %0h ", model.ctrl_register_inst.get(), model.ctrl_register_inst.get_mirrored_value()),UVM_LOW);
  
 
  model.ctrl_register_inst.mirror(status,UVM_CHECK); 
  `uvm_info("[SEQ]:", $sformatf("mirror ctrl_register -> Desired Value: %0h & Mirrored Value: %0h", model.ctrl_register_inst.get(), model.ctrl_register_inst.get_mirrored_value()),UVM_LOW);
 //-----------------------------------------------   
  
  
 endtask

endclass
