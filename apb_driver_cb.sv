//=========================================================================================
//=======================Topic:UVM CALL BACKS IN UVM=======================================
//=========================================================================================

//STEP1:Define the user define uvm_callback class and is extended from  the uvm_callback only moreover uvm_callback is object class.so you need to register with the uvm_object_utils(().
//-----------------------------------------------------------------------------------------------
//------------------user defind uvm_callback class for driver------------------------------------
//-----------------------------------------------------------------------------------------------

class apb_driver_cb extends uvm_callback;

//uvm_callback is object class so you need to register with the uvm_object_utils
  `uvm_object_utils(apb_driver_cb)
  
//default constructor.
  function  new(string name="apb_driver_cb");
    super.new(name);
  endfunction:new
  
  //dummy method1 for callbacks
  virtual task pre_drive();
    
  endtask:pre_drive
  
  //dummy method2 for the callbacks
  virtual task post_drive();
    
  endtask:post_drive
  
endclass:apb_driver_cb

//-----------------user defind uvm_callback class for driver completed----------------------------------
//------------------------------------------------------------------------------------------------------

//step2:Need to extend the user-defined callback class and write one more callback classes for implementation of methods according to the user requirement.this class extended from the user defined call back class.
//-----------------------------------------------------------------------------------------------------------
//-----------------------  user defined callback classs for the callback methods implemention----------------
//-----------------------------------------------------------------------------------------------------------

class apb_driver_cb1  extends apb_driver_cb;
  
//register with object utils
`uvm_object_utils(apb_driver_cb1)
  
//default constructor.
  function new(string name="apb_driver_cb1");
    super.new(name);
  endfunction:new
  
  //implementation of call back methods
  virtual task pre_drive();
    `uvm_info(get_type_name(),"\"=-=-=-=-=-=-=-=-=-= pre_drive task called -=-=-=-=-=-=-=-=-=-=-=-\"",UVM_NONE)
  endtask:pre_drive
  
  virtual task post_drive();
    `uvm_info(get_type_name(),"\"=-=-=-=-=-=-=-=-=-= post_drive task called -=-=-=-=-=-=-=-=-=-=-\"",UVM_NONE)
  endtask:post_drive
  
endclass:apb_driver_cb1


//--------------  user defined callback classs for the callback methods implemention completed---------------
//-----------------------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------------------
//-----------------------  user defined callback classs for the callback methods implemention----------------
//-----------------------------------------------------------------------------------------------------------

class apb_driver_cb2  extends apb_driver_cb;
  
//register with object utils
  `uvm_object_utils(apb_driver_cb2)
  
//default constructor.
  function new(string name="apb_driver_cb2");
    super.new(name);
  endfunction:new
  
  //implementation of call back methods
  virtual task pre_drive();
    `uvm_info(get_type_name(),"\n================================================================\n\"=-=-=-=-=-=-=-=-=-= pre_drive task called -=-=-=-=-=-=-=-=-=-=-=-\"\n================================================================",UVM_NONE)
 endtask:pre_drive
  
  virtual task post_drive();
    `uvm_info(get_type_name(),"\n================================================================\n\"=-=-=-=-=-=-=-=-=-= post_drive task called -=-=-=-=-=-=-=-=-=-=-=-\"\n================================================================",UVM_NONE)
  endtask:post_drive
  
endclass:apb_driver_cb2


//--------------  user defined callback classs for the callback methods implemention completed---------------
//-----------------------------------------------------------------------------------------------------------



//========================================================================================
//===================UVM CALL BACKS IN UVM END============================================
//========================================================================================