
class apb_master_agent extends uvm_agent;
  
//factory registration
`uvm_component_utils(apb_master_agent)
  
//apb_master sequencer class handle declaration.
apb_master_sequencer m_seqr;
//apb_master driver class handle declaration.
apb_master_driver m_driv;
//apb_slve monitor class handle declartion.
apb_master_monitor m_mntr;
  
//apb master config agent class handle declaration
apb_master_config_agent m_cfg_agt;

//analysis port declartion
  uvm_analysis_port#(apb_master_seq_item) analysis_port;
  
//default constructor
  function new(string name,uvm_component parent);
    super.new(name,parent);
    `uvm_info("TRACE",$sformatf("%m"),UVM_HIGH)
    analysis_port = new("analysis_port",this);
  endfunction:new
  
function void build_phase(uvm_phase phase);
super.build_phase(phase);
  `uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF AGENT IS STARTED ",UVM_NONE)
if(! uvm_config_db#(apb_master_config_agent)::get(this, " ","m_cfg_agt",m_cfg_agt)) begin
`uvm_fatal("apb_master_agent_CONFIG_FATAL","\n first set the \"m_cfg_agt \" apb master config agent class handle into the config db")
    end
    
if(m_cfg_agt.is_active == UVM_ACTIVE) begin
  `uvm_info(get_name()," APB_MASTER_AGENT IS CONFIGURED AS A ACTIVE AGENT",UVM_NONE)
 m_seqr = apb_master_sequencer::type_id::create("m_seqr",this);
  m_driv = apb_master_driver::type_id::create("m_driv",this);
end
  
  else `uvm_info(get_name()," APB_MASTER_AGENT IS CONFIGURED AS A PASSIVE AGENT",UVM_NONE);
m_mntr = apb_master_monitor::type_id::create("m_mntr",this); 
  `uvm_info("BUILD_PHASE_TOP_DOWN"," BUILD_PHASE OF AGENT IS ENDED ",UVM_NONE)
endfunction:build_phase
  
  
virtual function void connect_phase(uvm_phase phase);
  `uvm_info("CONNECT_PHASE_BOTTOMUP"," CONNECT_PHASE OF AGENT IS STARTED ",UVM_NONE)

  super.connect_phase(phase);
  if(m_cfg_agt.is_active == UVM_ACTIVE) begin
  m_driv.seq_item_port.connect(m_seqr.seq_item_export);
  end
  m_mntr.analysis_port.connect(this.analysis_port);
  `uvm_info("CONNECT_PHASE_BOTTOMUP"," CONNECT_PHASE OF AGENT IS ENDED ",UVM_NONE)

endfunction:connect_phase
  
   virtual function void end_of_elaboration_phase(uvm_phase phase);
     `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF AGENT IS STARTED ",UVM_NONE)
    super.end_of_elaboration_phase(phase);
     `uvm_info("END_OF_ELABORATION_PHASE_BOTTOMUP"," END_OF_ELABORATION_PHASE OF AGENT IS ENDED ",UVM_NONE)

  endfunction:end_of_elaboration_phase
  
   virtual function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info("START_OF_SIMULATION_BOTTOMUP"," START_OF_SIMULATION_PHASE AGENT  IS STARTED ",UVM_NONE)
    super.start_of_simulation_phase(phase);
    `uvm_info("START_OF_SIMULATION_BOTTTOMUP","START_OF_SIMULATION_PHASE AGENT IS ENDED ",UVM_NONE)
  endfunction:start_of_simulation_phase
  
    virtual function void extract_phase(uvm_phase phase);
    `uvm_info("EXTRACT_PHASE_BOTTOMUP"," EXTRACT_PHASE AGENT  IS STARTED ",UVM_NONE)
    super.extract_phase(phase);
    `uvm_info("EXTRACT_PHASE_BOTTTOMUP"," EXTRACT_PHASE AGENT IS ENDED ",UVM_NONE)
  endfunction:extract_phase
  
  
  virtual function void check_phase(uvm_phase phase);
    `uvm_info("CHECK_PHASE_BOTTOMUP"," CHECK_PHASE AGENT  IS STARTED ",UVM_NONE)
    super.check_phase(phase);
    `uvm_info("CHECK_PHASE_BOTTTOMUP"," CHECK_PHASE AGENT  IS ENDED ",UVM_NONE)
  endfunction:check_phase
  
  
   virtual function void report_phase(uvm_phase phase);
    `uvm_info("REPORT_PHASE_BOTTOMUP"," REPORT_PHASE AGENT  IS STARTED ",UVM_NONE)
     super.report_phase(phase);
     `uvm_info("REPORT_PHASE_BOTTTOMUP"," REPORT_PHASE AGENT  IS ENDED ",UVM_NONE)
  endfunction:report_phase
  
  
   virtual function void final_phase(uvm_phase phase);
    
`uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE AGENT  IS STARTED ",UVM_NONE)
    super.final_phase(phase);
     `uvm_info("FINAL_PHASE_TOPDOWN"," FINAL_PHASE AGENT  IS ENDED ",UVM_NONE)
  endfunction:final_phase
  
endclass:apb_master_agent