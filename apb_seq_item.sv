class apb_seq_item extends uvm_sequence_item;
  `uvm_object_utils(apb_seq_item)

rand bit pwrite;
rand bit psel;
rand bit penable;  
rand bit [31 : 0] pwdata;
rand bit [31 : 0] paddr;

bit[31: 0] prdata ;
 
 constraint addr_range { 
      paddr inside {0, 4, 8, 12, 16};
    }
  
  function new(string name = "apb_seq_item");
 super.new(name);
 endfunction
  
endclass