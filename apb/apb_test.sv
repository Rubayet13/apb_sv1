class apb_test; 
	
	 apb_env env; 
	
	function new (string name = "apb_test", virtual apb_intf INTF); 
		$display ("%s is created", name); 
		env = new ("env",INTF);
	endfunction 
	
	task run_test(); 
		//reset
		env.agent.drv.reset();
		env.agent.drv.write(8'b0,32'd10);
		env.agent.drv.read(8'b0);
	endtask 
endclass 
