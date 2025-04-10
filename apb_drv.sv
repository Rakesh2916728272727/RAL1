class apb_drv extends uvm_driver #(apb_seq_item);
  `uvm_component_utils(apb_drv)

 virtual apb_if vif;
 apb_seq_item tx;


  function new(string name="",uvm_component parent);
    super.new(name,parent);
 endfunction

  function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 tx = apb_seq_item::type_id::create("tx");

   uvm_config_db#(virtual apb_if)::get(this,"","intf",vif);
 
 endfunction


  task run_phase(uvm_phase phase);
        vif.psel <= 0;
        vif.penable <= 0;
        vif.pwrite <= 0;
        vif.paddr <= 0;
        vif.pwdata <= 0;
    forever begin 
        seq_item_port.get_next_item(tx);
        drive();
      seq_item_port.item_done();
    end
  endtask
    
  virtual task drive();
     
    if(tx.pwrite)
       
 begin
   @(posedge vif.pclk)
 vif.psel <= 1'b1;
 vif.paddr <= tx.paddr;
 vif.pwdata <= tx.pwdata;
 vif.pwrite <= 1'b1;
 @(posedge vif.pclk);
 vif.penable <= 1'b1;
   `uvm_info("driver Write ",$sformatf("WDATA =%0h ADDR : %0h",vif.pwdata, vif.paddr ),UVM_LOW);
   repeat(2)
  @(posedge vif.pclk); 
    vif.psel    <= 1'b0;
   vif.penable <= 1'b0;
 end
   
    else if(!tx.pwrite)
 begin
    @(posedge vif.pclk)
 vif.psel <= 1'b1;
 vif.paddr <= tx.paddr;
//
 //  tx.prdata<=vif.prdata;
 vif.pwrite <= 1'b0;
   
    @(posedge vif.pclk);
 vif.penable <= 1'b1;
   

   //
   repeat(2) 
  //
   @(posedge vif.pclk);
   //
   
   `uvm_info("driver Read",$sformatf(" ADDR : %0h", vif.paddr ),UVM_LOW);
   tx.prdata<=vif.prdata;
    //
   @(posedge vif.pclk)
   
    vif.psel    <= 1'b0;
    vif.penable <= 1'b0;
   // @(posedge vif.pclk);
 end
 endtask

endclass