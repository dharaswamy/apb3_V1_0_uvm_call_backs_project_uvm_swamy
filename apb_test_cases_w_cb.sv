

class apb_driver_cb1_callback_test extends apb_base_test;
  
//factory registration.
  `uvm_component_utils(apb_driver_cb1_callback_test)
  
//call back class
apb_driver_cb1 callback_cb1;


// apb maste config agent class handle declaration.
apb_master_config_agent m_cfg_agt;

//sequence class declaration.
apb_master_base_sequence b_sequ;

  
function new(string name,uvm_component parent);
super.new(name,parent);
endfunction:new
  
virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
  callback_cb1 = apb_driver_cb1::type_id::create("callback_cb1",this);
  m_cfg_agt = apb_master_config_agent::type_id::create("m_cfg_agt");
    //creationg base sequence
  b_sequ = apb_master_base_sequence::type_id::create("b_sequ",this);
endfunction:build_phase
  
  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    uvm_callbacks#(apb_master_driver,apb_driver_cb)::add(apb_m_env.m_agt.m_driv,callback_cb1);

  endfunction:start_of_simulation_phase
  
  
virtual task run_phase(uvm_phase phase);
  super.run_phase(phase);
  phase.raise_objection(this);

  if(m_cfg_agt.is_active == UVM_ACTIVE) begin
  b_sequ.start(apb_m_env.m_agt.m_seqr);
  end
  phase.drop_objection(this);
  phase.phase_done.set_drain_time(this,40);
endtask:run_phase
  

  
endclass:apb_driver_cb1_callback_test


//--------------------------------------------------------------------

class apb_driver_cb2_callback_test extends apb_base_test;
  
//factory registration.
  `uvm_component_utils(apb_driver_cb2_callback_test)
  
//call back class
apb_driver_cb2 callback_cb2;


// apb maste config agent class handle declaration.
apb_master_config_agent m_cfg_agt;

//sequence class declaration.
apb_master_base_sequence b_sequ;

  
function new(string name,uvm_component parent);
super.new(name,parent);
endfunction:new
  
virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
  callback_cb2 = apb_driver_cb2::type_id::create("callback_cb2",this);
  m_cfg_agt = apb_master_config_agent::type_id::create("m_cfg_agt");
    //creationg base sequence
  b_sequ = apb_master_base_sequence::type_id::create("b_sequ",this);
endfunction:build_phase
  
  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    uvm_callbacks#(apb_master_driver,apb_driver_cb)::add(apb_m_env.m_agt.m_driv,callback_cb2);

  endfunction:start_of_simulation_phase
  
  
virtual task run_phase(uvm_phase phase);
  super.run_phase(phase);
  phase.raise_objection(this);

  if(m_cfg_agt.is_active == UVM_ACTIVE) begin
  b_sequ.start(apb_m_env.m_agt.m_seqr);
  end
  phase.drop_objection(this);
  phase.phase_done.set_drain_time(this,40);
endtask:run_phase
  

  
endclass:apb_driver_cb2_callback_test