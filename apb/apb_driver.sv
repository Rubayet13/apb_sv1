class driver; 
	virtual apb_intf  INTF;
	function new (string name, virtual apb_intf INTF); 
		$display ("%s is created", name);	
		this.INTF = INTF;
	endfunction 
	
	task reset();
		repeat (2)@(negedge INTF.pclk);
		INTF.rst_n  <= 1'b0; 
		INTF.pwrite <= 1'b0; 
		INTF.psel	<= 1'b0;
		INTF.paddr	<= 8'd0;
		INTF.pwdata	<= 32'd0;
		INTF.penable <= 1'b0;
		@(negedge INTF.pclk);
		INTF.rst_n  <= 1'b1;
		@(negedge INTF.pclk);	
	endtask
	
	task write(logic [7:0] addr, logic [31:0] data); 
		//setup
		@(negedge INTF.pclk); //writing only pclk will not work, cause drive knows only INTF)
			INTF.pwrite <= 1'b1; 
			INTF.psel	<= 1'b1;
			INTF.paddr	<= addr;
			INTF.pwdata	<= data;
		//Enable
 
		@(negedge INTF.pclk);
			INTF.penable <= 1'b1;
		//Idle
		@(negedge INTF.pclk);
			INTF.pwrite 	<= 1'b0; 
			INTF.psel		<= 1'b0;
			INTF.penable 	<= 1'b0;
	endtask 

	task read(logic [7:0] addr); 
		//setup
		@(negedge INTF.pclk); //writing only pclk will not work, cause drive knows only INTF)
			INTF.pwrite <= 1'b0; 
			INTF.psel	<= 1'b1;
			INTF.paddr	<= addr;
			//INTF.pwdata	<= data;
		//Enable
 
		@(negedge INTF.pclk);
			INTF.penable <= 1'b1;
		//Idle
		@(negedge INTF.pclk);
			INTF.pwrite 	<= 1'b0; 
			INTF.psel		<= 1'b0;
			INTF.penable 	<= 1'b0;
		@(negedge INTF.pclk);
		@(negedge INTF.pclk);
	endtask
	
endclass
