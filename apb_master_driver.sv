
`define DRIVE_IF  m_vintf.driver_mdp

class apb_master_driver extends uvm_driver#(apb_master_seq_item);
  
   //factory registration.
  `uvm_component_utils(apb_master_driver)
  
 //INTERFACE Handle declaration.
  virtual apb_master_interface m_vintf;
  
  //apb_master_seq_item req;
  
   
// Callback class has to be registered with the object/component where callbacks are going to be used.
// Callback class can be registered by using macro `uvm_register_cb
  `uvm_register_cb(apb_master_driver,apb_driver_cb)
  
  //default constructor.
  function new(string name,uvm_component parent);
    super.new(name,parent);
  `uvm_info("TRACE",$sformatf("%m"),UVM_HIGH)
  endfunction:new
  
  
  //uvm_config_db#(virtual apb_master_interface)::set(     uvm_root::get,  " * ","slv_vintf",slv_vintf);

function void build_phase(uvm_phase phase);
`uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF DRIVER IS STARTED ",UVM_NONE);
super.build_phase(phase);
  if(!uvm_config_db#(virtual apb_master_interface)::get(this," ","m_vintf",m_vintf)) begin
    `uvm_fatal("APB_MASTER_DRIVER_CONFIG_FATAL"," \n First set the \" slv_vintf \" virtual master interface handle into config db")
  end
  `uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF DRIVER IS ENDED ",UVM_NONE);
  
endfunction:build_phase
  
  
  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("CONNECT_PHASE_BOTTOMUP"," CONNECT_PHASE OF DRIVER IS STARTED ",UVM_NONE)
    super.connect_phase(phase);
    `uvm_info("CONNECT_PHASE_BOTTOMUP","  CONNECT_PHASE OF DRIVER IS ENDED ",UVM_NONE)

 endfunction:connect_phase
  
  
   virtual function void end_of_elaboration_phase(uvm_phase phase);
     `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF DRIVER IS STARTED ",UVM_NONE)
    super.end_of_elaboration_phase(phase);
     `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF DRIVER IS ENDED ",UVM_NONE)

  endfunction:end_of_elaboration_phase
  
 virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("START_OF_SIMULATION_BOTTOMUP"," START_OF_SIMULATION_PHASE DRIVER   IS STARTED ",UVM_NONE)
    super.start_of_simulation_phase(phase);
    `uvm_info("START_OF_SIMULATION_BOTTTOMUP","START_OF_SIMULATION_PHASE DRIVER  IS ENDED ",UVM_NONE)
  endfunction:start_of_simulation_phase
  
    virtual function void extract_phase(uvm_phase phase);
      `uvm_info("EXTRACT_PHASE_BOTTOMUP"," EXTRACT_PHASE DRIVER    IS STARTED ",UVM_NONE)
    super.extract_phase(phase);
    `uvm_info("EXTRACT_PHASE_BOTTTOMUP"," EXTRACT_PHASE DRIVER  IS ENDED ",UVM_NONE)
  endfunction:extract_phase
  
  virtual function void check_phase(uvm_phase phase);
    `uvm_info("CHECK_PHASE_BOTTOMUP"," CHECK_PHASE DRIVER    IS STARTED ",UVM_NONE)
    super.check_phase(phase);
    `uvm_info("CHECK_PHASE_BOTTTOMUP"," CHECK_PHASE DRIVER  IS ENDED ",UVM_NONE)
  endfunction:check_phase
  
  
   virtual function void report_phase(uvm_phase phase);
    `uvm_info("REPORT_PHASE_BOTTOMUP"," REPORT_PHASE DRIVER   IS STARTED ",UVM_NONE)
     super.report_phase(phase);
    `uvm_info("REPORT_PHASE_BOTTTOMUP"," REPORT_PHASE DRIVER  IS ENDED ",UVM_NONE)
  endfunction:report_phase
  
  
   virtual function void final_phase(uvm_phase phase);
    
`uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE DRIVER   IS STARTED ",UVM_NONE)
    super.final_phase(phase);
     `uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE DRIVER IS ENDED ",UVM_NONE)
  endfunction:final_phase
  
  
virtual task run_phase(uvm_phase phase);
super.run_phase(phase);
  `uvm_info("get_name():",$sformatf("-----%0s ------",get_name()),UVM_NONE)
  `uvm_info("get_type():",$sformatf("-----%0D-------",get_type()),UVM_NONE)
  `uvm_info("get_type_name():",$sformatf("-----%0s ------",get_type_name()),UVM_NONE)
  `uvm_info("get_full_name():",$sformatf("-----%0s ------",get_full_name()),UVM_NONE)
  `uvm_info("get_inst_id():",$sformatf("-----%0d ------",get_inst_id()),UVM_NONE)
  `uvm_info("get_inst_count:",$sformatf("-----%0d ------",get_inst_count()),UVM_NONE)
  wait( `DRIVE_IF.preset_n);
 forever begin:forever_begin
   
   seq_item_port.get_next_item(req);
   
 //calling the callback methods .
`uvm_do_callbacks(apb_master_driver,apb_driver_cb,pre_drive)
`uvm_info("driver_debug",$sformatf(" req.PWADAT=%H",req.pwdata),UVM_NONE);
   if(apb_master_seq_item::WRITE == req.pwrite)
     `uvm_info("MASTER_DRV_RUN",{" \"WRITE TRANSACTION \"\n",req.sprint()},UVM_DEBUG);
   if(apb_master_seq_item::READ == req.pwrite)
     `uvm_info("MASTER_DRV_RUN",{" \"READ TRANSACTION \"\n",req.sprint()},UVM_DEBUG);
     drive();
    //calling the callback methods .
   `uvm_do_callbacks(apb_master_driver,apb_driver_cb,post_drive)

  seq_item_port.item_done();
 
  end:forever_begin
endtask:run_phase
 
  
  protected task drive();
    `uvm_info("start_driver","debug driver",UVM_NONE);
    idle_state();
    setup_state();
    access_state();
    
  endtask:drive
  
  //we are writting the one task for the idle state behaviour.
  protected task idle_state();
    @(posedge `DRIVE_IF.pclk);
    `DRIVE_IF.pselx <= 1'b0;
    `DRIVE_IF.penable <= 1'b0;
  endtask:idle_state
 
  //we are writting the one task for the setup state behaviour.
  protected task setup_state();
    @(posedge `DRIVE_IF.pclk);
    `DRIVE_IF.pselx <= req.pselx;
    `DRIVE_IF.penable <= 1'b0;
    if(apb_master_seq_item::WRITE == req.pwrite) begin
    `DRIVE_IF.paddr <= req.paddr;
    `DRIVE_IF.pwdata <= req.pwdata;
    `DRIVE_IF.pwrite <= req.pwrite;
    end
    if(apb_master_seq_item::READ == req.pwrite) begin
     `DRIVE_IF.paddr <= req.paddr;
     `DRIVE_IF.pwrite <= req.pwrite; 
    end
    
  endtask:setup_state
  
  //we are writting the one task for the access state behaviour.
  protected task access_state();
    @(posedge `DRIVE_IF.pclk);
    `DRIVE_IF.penable <= 1'b1;
    wait(`DRIVE_IF.pready);
   `uvm_info("APB_MASTER_DRV_ACCESS_STATE_DONE",$sformatf(" \n signal pready=%b",`DRIVE_IF.pready),UVM_FULL);
   // @(posedge `DRIVE_IF.pclk);
   //`DRIVE_IF.pwrite <= 1'b0; 
    // `DRIVE_IF.pselx <= 1'b0;
  //`DRIVE_IF.penable <= 1'b0;
  endtask:access_state
  
endclass:apb_master_driver