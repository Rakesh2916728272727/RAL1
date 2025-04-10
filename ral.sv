class	ctrl_register extends uvm_reg;
  rand uvm_reg_field cntrl;
  
   
`uvm_object_utils(ctrl_register)
function new(string name = "ctrl_register");
    super.new(name, 4, build_coverage(UVM_NO_COVERAGE));
  endfunction
  
  virtual function void build();
    this.cntrl = uvm_reg_field::type_id::create("cntrl");   
    this.cntrl.configure (this, 4, 0, "RW", 0, 'h0, 1, 1, 1);
  endfunction
endclass
//----------------------------------------------------------------------

class reg1_register extends uvm_reg;
  rand uvm_reg_field reg1;
   
  `uvm_object_utils(reg1_register)
  function new(string name = "reg1_register");
    super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
  endfunction
  
  virtual function void build();
    this.reg1 = uvm_reg_field::type_id::create("reg1");
   
    this.reg1.configure (this, 32, 0, "RW", 0, 'hA5A50000, 1, 1, 1);
  endfunction
endclass
//------------------------------------------------------------------

class reg2_register extends uvm_reg;
  rand uvm_reg_field reg2;
   
  `uvm_object_utils(reg2_register)
  function new(string name = "reg2_register");
    super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
  endfunction
  
  virtual function void build();
    reg2 = uvm_reg_field::type_id::create("reg2");
   
    reg2.configure (this, 32, 0, "RW", 0, 'h12349876, 1, 1, 1);
  endfunction
endclass
//-------------------------------------------------------------

class reg3_register extends uvm_reg;
  rand uvm_reg_field reg3;
   
  `uvm_object_utils(reg3_register)
  function new(string name = "reg3_register");
    super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
  endfunction
  
  virtual function void build();
    this.reg3 = uvm_reg_field::type_id::create("reg3");
   
    this.reg3.configure (this, 32, 0, "RW", 0, 'h5A5A5555, 1, 1, 1);
  endfunction
endclass
//-------------------------------------------------------------

class reg4_register extends uvm_reg;
  rand uvm_reg_field reg4;
   
  `uvm_object_utils(reg4_register)
  function new(string name = "reg4_register");
    super.new(name, 32, build_coverage(UVM_NO_COVERAGE));
  endfunction
  
  virtual function void build();
    this.reg4 = uvm_reg_field::type_id::create("reg4");
   
    this.reg4.configure (this, 32, 0, "RW", 0, 'h0000FFFF, 1, 1, 1);
  endfunction
endclass
//---------------------------------------------------------------

class module_reg extends uvm_reg_block;
  rand ctrl_register  ctrl_register_inst;
  rand reg1_register reg1_register_inst ;
  rand reg2_register reg2_register_inst ;
  rand reg3_register reg3_register_inst ;
  rand reg4_register reg4_register_inst ;
  
  `uvm_object_utils(module_reg)
  function new(string name = "module_reg");
    super.new(name);
  endfunction
  
  virtual function void build();
   ctrl_register_inst= ctrl_register::type_id::create("ctrl_register_inst");
    ctrl_register_inst.configure(this,null);
    ctrl_register_inst.build();
    
    reg1_register_inst = reg1_register ::type_id::create("reg1_register_inst");
    reg1_register_inst.configure(this,null);
    reg1_register_inst.build();
    
    reg2_register_inst = reg2_register ::type_id::create("reg2_register_inst");
    reg2_register_inst.configure(this,null);
    reg2_register_inst.build();
    
    reg3_register_inst = reg3_register ::type_id::create("reg3_register_inst");
    reg3_register_inst.configure(this,null);
    reg3_register_inst.build();
    
    reg4_register_inst = reg4_register ::type_id::create("reg4_register_inst");
    reg4_register_inst.configure(this,null);
    reg4_register_inst.build();

    this.default_map = create_map("default_map",'h0, 4, UVM_LITTLE_ENDIAN);
    
    this.default_map.add_reg(ctrl_register_inst,'h0, "RW");
    this.default_map.add_reg(reg1_register_inst,'h4, "RW");
    this.default_map.add_reg(reg2_register_inst,'h8, "RW");
    this.default_map.add_reg(reg3_register_inst,'hc, "RW");
    this.default_map.add_reg(reg4_register_inst,'h10, "RW");
 
    //lockmodel();
  endfunction
endclass


//---------------------------------------
class my_adapter extends uvm_reg_adapter;
  `uvm_object_utils(my_adapter)
  
  function new(string name = "my_adapter");
    super.new(name);
  endfunction
  
  virtual function uvm_sequence_item reg2bus (const ref uvm_reg_bus_op rw);
   apb_seq_item tr; 
   tr = apb_seq_item::type_id::create("tr");
   
    tr.pwrite = (rw.kind == UVM_WRITE) ? 1: 0;
    tr.paddr  = rw.addr;
    tr.pwdata = rw.data;
    return tr;
  endfunction
  
  virtual function void bus2reg (uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
    apb_seq_item tr;
    if(!$cast(tr, bus_item))
      `uvm_fatal(get_type_name(), "Failed to cast  transaction")
    
      rw.kind = (tr.pwrite) ? 1 : 0;
    rw.addr = tr.paddr;
    rw.data = (tr.pwrite) ? tr.pwdata : tr.prdata;
   
  endfunction

endclass

//----------------------------------

