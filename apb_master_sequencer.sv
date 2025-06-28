

class apb_master_sequencer extends uvm_sequencer#(apb_master_seq_item);
 
int unsigned item_count=1;//by default item_count is 1;
  
//factory registration
`uvm_component_utils(apb_master_sequencer)
  
  //default constructor.
  function new(string name ,uvm_component parent);
    super.new(name,parent);
    `uvm_info("TRACE",$sformatf("%m"),UVM_HIGH)
  endfunction:new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF SEQR IS STARTED ",UVM_NONE);
    super.build_phase(phase);
    if( !uvm_config_db#(int unsigned)::get(this, " ","item_count",item_count)) begin
      `uvm_info(get_name()," CONFIG DB GET FATAL ERROR ,SO FIRST SET THE \" item_count \" INTO THE config db from top",UVM_NONE);
      `uvm_info(get_name(),$sformatf("\n so sequencer no the get the item_count from the top/test,so the default item_cout=%0d is passed to the required sequence ",item_count),UVM_NONE);
    end
    else `uvm_info(get_name(),$sformatf(" apb_master_sequecer got the item_count=%0d",item_count),UVM_NONE);
    `uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF SEQR IS ENDED ",UVM_NONE);
  endfunction:build_phase
  
  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("CONNECT_PHASE_BOTTOMUP"," CONNECT_PHASE OF SEQUENCER IS STARTED ",UVM_NONE)
    super.connect_phase(phase);
    `uvm_info("CONNECT_PHASE_BOTTOMUP","  CONNECT_PHASE OF SEQUENCER IS ENDED ",UVM_NONE)

 endfunction:connect_phase
  
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF SEQUENCER IS STARTED ",UVM_NONE)
    super.end_of_elaboration_phase(phase);
    `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF SEQUENCER IS ENDED ",UVM_NONE)

  endfunction:end_of_elaboration_phase
  
  
  virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("START_OF_SIMULATION_BOTTOMUP"," START_OF_SIMULATION_PHASE SEQUENCER  IS STARTED ",UVM_NONE)
    super.start_of_simulation_phase(phase);
    `uvm_info("START_OF_SIMULATION_BOTTTOMUP","START_OF_SIMULATION_PHASE SEQUENCER  IS ENDED ",UVM_NONE)
  endfunction:start_of_simulation_phase
  
  
  virtual function void extract_phase(uvm_phase phase);
    `uvm_info("EXTRACT_PHASE_BOTTOMUP"," EXTRACT_PHASE SEQUENCER  IS STARTED ",UVM_NONE)
    super.extract_phase(phase);
    `uvm_info("EXTRACT_PHASE_BOTTTOMUP"," EXTRACT_PHASE SEQUENCER IS ENDED ",UVM_NONE)
  endfunction:extract_phase
 
  virtual function void check_phase(uvm_phase phase);
    `uvm_info("CHECK_PHASE_BOTTOMUP"," CHECK_PHASE SEQUENCER  IS STARTED ",UVM_NONE)
    super.check_phase(phase);
    `uvm_info("CHECK_PHASE_BOTTTOMUP"," CHECK_PHASE SEQUENCER IS ENDED ",UVM_NONE)
  endfunction:check_phase
  
  
   virtual function void report_phase(uvm_phase phase);
    `uvm_info("REPORT_PHASE_BOTTOMUP"," REPORT_PHASE SEQUENCER  IS STARTED ",UVM_NONE)
     super.report_phase(phase);
    `uvm_info("REPORT_PHASE_BOTTTOMUP"," REPORT_PHASE SEQUENCER IS ENDED ",UVM_NONE)
  endfunction:report_phase
  
  
   virtual function void final_phase(uvm_phase phase);
    
`uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE SEQUENCER  IS STARTED ",UVM_NONE)
    super.final_phase(phase);
    `uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE SEQUENCER IS ENDED ",UVM_NONE)
  endfunction:final_phase
  
  
  
  
  
endclass:apb_master_sequencer