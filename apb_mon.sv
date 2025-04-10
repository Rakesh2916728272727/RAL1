class apb_mon extends uvm_monitor;
  `uvm_component_utils(apb_mon)
  
  uvm_analysis_port#(apb_seq_item) mon_ap;
  
apb_seq_item tx;
  
virtual apb_if vif;
  
  function new(string name="",uvm_component parent);
    super.new(name,parent);
 endfunction

 function void build_phase(uvm_phase phase);
 super.build_phase(phase);
   tx=apb_seq_item::type_id::create("tx");
   mon_ap=new("mon_ap",this);
   
   if(!uvm_config_db#(virtual apb_if)::get(this,"","intf",vif))
 `uvm_error("MON","Unable to access Interface");
 endfunction



  task run_phase(uvm_phase phase);
 
            forever begin
              //repeat(3) 
              @(posedge vif.pclk);
                if(vif.psel && vif.penable && vif.presetn) begin
                   
                  tx.paddr  = vif.paddr;
                  tx.pwrite = vif.pwrite;
                    if (vif.pwrite)
                       begin
                        tx.pwdata = vif.pwdata;
                        @(posedge vif.pclk);
                         `uvm_info("MONITOR", $sformatf(" Write WDATA : %0h ADDR : %0h", vif.pwdata, vif.paddr), UVM_NONE);
                       end
                    else
                       begin
                                               @(posedge vif.pclk);
                        tx.prdata = vif.prdata;
                         
                         `uvm_info("MONITOR", $sformatf(" Read  ADDR : %0h RDATA : %0h",  vif.paddr, vif.prdata), UVM_NONE); 
                       end
                  mon_ap.write(tx);
                end 
            end
        
    endtask 
 
endclass    