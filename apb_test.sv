
class apb_test extends uvm_test;
  `uvm_component_utils(apb_test)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  apb_env env;
  apb_seq  seq;
// apb_seq_se_up_mr seq1;
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env",this);
    seq = apb_seq::type_id::create("seq");
  // seq1 = apb_seq_se_up_mr::type_id::create("seq");
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("TEST",sprint(),UVM_LOW)
  endfunction
  
  task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
     seq.model = env.model;
    seq.start(env.agent.sqr);
    //seq1.model = env.model;
   // seq1.start(env.agent.sqr);
    #100
    phase.drop_objection(this);
  endtask
endclass
  
  
    
