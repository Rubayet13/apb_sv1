class monitor;
	virtual apb_intf INTF;
	function new (string name = "apb_monitor", virtual apb_intf INTF); 
		$display ("%s is created", name);	
		this.INTF = INTF;
		
		fork 
			capture_write(); 
			capture_read();
		join_none
	
	endfunction 

	task capture_write (); 
		forever begin 
			@(negedge INTF.pclk);
			if(INTF.psel && INTF.penable && INTF.pwrite) begin 
				$display ("[%0t] Write is captured:: Addr: %0h DATA:%0h", $time, INTF.paddr, INTF.pwdata);   
			end
		end 
	endtask 

	task capture_read (); 
		forever begin 
			@(negedge INTF.pclk);
			if(INTF.psel && INTF.penable && !INTF.pwrite) begin 
				$display ("[%0t] Read is captured:: Addr: %0h DATA:%0h", $time, INTF.paddr, INTF.prdata);   
			end
		end 
	endtask 

endclass
