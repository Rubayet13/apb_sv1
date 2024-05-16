class apb_env; 
	apb_scb scb;
	apb_agent agent;
	function new (string name = "apb_env", virtual apb_intf INTF); 
		$display ("%s is created", name); 
		scb = new ("scb",INTF);
		agent = new ("env",INTF);
	endfunction 

endclass
