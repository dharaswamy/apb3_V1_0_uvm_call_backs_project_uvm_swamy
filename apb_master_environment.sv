
class apb_master_environment extends uvm_env;

  //factory registration
`uvm_component_utils(apb_master_environment)
  
// apb maste config agent class handle declaration.
 apb_master_config_agent m_cfg_agt;

// apb master agent class handle declaration.
apb_master_agent m_agt;

//apb scoreboard class handle declaration.
apb_scoreboard apb_scb;
  
//apb functional coverage class handle declaration.
apb_functional_coverage apb_fc;
  

  function new(string name,uvm_component parent);
  
    super.new(name,parent);
    `uvm_info("TRACE",$sformatf("%m"),UVM_HIGH)
  endfunction:new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF ENVIRNOMENT IS STARTED ",UVM_NONE)

    super.build_phase(phase);
    m_cfg_agt = apb_master_config_agent::type_id::create("m_cfg_agt");
  //m_cfg_agt is pass to lower lever components
    uvm_config_db#(apb_master_config_agent)::set(this,"*","m_cfg_agt",m_cfg_agt);
  //master agent class instantiation
    m_agt = apb_master_agent::type_id::create("m_agt",this);
    //apb scoreboard class instantiation
    apb_scb = apb_scoreboard::type_id::create("apb_scb",this);
    //abp functional coverage instantiation
    apb_fc = apb_functional_coverage::type_id::create("apb_fc",this); 
    `uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF ENVIRNOMENT IS ENDED ",UVM_NONE)
  endfunction:build_phase
  
  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("CONNECT_PHASE_BOTTOMUP"," CONNECT_PHASE OF ENVIRONMENT IS STARTED ",UVM_NONE)

    super.connect_phase(phase);
    m_agt.analysis_port.connect(apb_scb.analysis_import);
    m_agt.analysis_port.connect(apb_fc.analysis_import);
    
    `uvm_info("CONNECT_PHASE_BOTTOMUP"," CONNECT_PHASE OF ENVIRONMENT IS ENDED ",UVM_NONE)

  endfunction:connect_phase
 
   virtual function void end_of_elaboration_phase(uvm_phase phase);
     `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF ENVIRONMENT IS STARTED ",UVM_NONE)
    super.end_of_elaboration_phase(phase);
     `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF ENVIRONMENT IS ENDED ",UVM_NONE)

  endfunction:end_of_elaboration_phase
  
   virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("START_OF_SIMULATION_BOTTOMUP"," START_OF_SIMULATION_PHASE ENVIRONMENT  IS STARTED ",UVM_NONE)
    super.start_of_simulation_phase(phase);
    `uvm_info("START_OF_SIMULATION_BOTTTOMUP","START_OF_SIMULATION_PHASE ENVIRONMENT IS ENDED ",UVM_NONE)
  endfunction:start_of_simulation_phase
  
  
    virtual function void extract_phase(uvm_phase phase);
    `uvm_info("EXTRACT_PHASE_BOTTOMUP"," EXTRACT_PHASE ENVIRONMENT  IS STARTED ",UVM_NONE)
    super.extract_phase(phase);
      `uvm_info("EXTRACT_PHASE_BOTTTOMUP"," EXTRACT_PHASE ENVIRONMENT  IS ENDED ",UVM_NONE)
  endfunction:extract_phase
  
  
  
  virtual function void check_phase(uvm_phase phase);
    `uvm_info("CHECK_PHASE_BOTTOMUP"," CHECK_PHASE ENVIRONMENT  IS STARTED ",UVM_NONE)
    super.check_phase(phase);
    `uvm_info("CHECK_PHASE_BOTTTOMUP"," CHECK_PHASE ENVIRONMENT IS ENDED ",UVM_NONE)
  endfunction:check_phase
  
  
   virtual function void report_phase(uvm_phase phase);
    `uvm_info("REPORT_PHASE_BOTTOMUP"," REPORT_PHASE ENVIRONMENT  IS STARTED ",UVM_NONE)
     super.report_phase(phase);
    `uvm_info("REPORT_PHASE_BOTTTOMUP"," REPORT_PHASE ENVIRONMENT IS ENDED ",UVM_NONE)
  endfunction:report_phase
  
  
   virtual function void final_phase(uvm_phase phase);
    
     `uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE ENVIRONMENT   IS STARTED ",UVM_NONE)
    super.final_phase(phase);
    `uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE ENVIRONMENT IS ENDED ",UVM_NONE)
  endfunction:final_phase
  
endclass:apb_master_environment