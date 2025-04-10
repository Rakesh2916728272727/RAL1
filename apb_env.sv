class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  module_reg model;
  my_adapter adp;
  uvm_reg_predictor #(apb_seq_item) predictor_inst;
  apb_agent agent;
  apb_scb scb;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = apb_agent::type_id::create("agent",this);
    model = module_reg::type_id::create("model");
    adp = my_adapter::type_id::create("adp");
    scb = apb_scb::type_id::create("scb",this);
    predictor_inst = uvm_reg_predictor #(apb_seq_item) :: type_id:: create("predictor_inst", this);
    model.build();
    model.lock_model();
//     model.print();
    
//    uvm_config_db#(module_reg)::set(uvm_root::get(), "*", "model", model);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.mon.mon_ap.connect(scb.recv);
    model.default_map.set_sequencer( .sequencer(agent.sqr), .adapter(adp) );
    model.default_map.set_base_addr('h0);  
    
    predictor_inst.map = model.default_map; //Assigning map handle
    predictor_inst.adapter = adp;
    
    agent.mon.mon_ap.connect(predictor_inst.bus_in); 
  endfunction
  
endclass