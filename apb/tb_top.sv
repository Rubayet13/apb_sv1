`timescale 1ns/10ps
`include "apb_pkg.sv"
module tb_top; 
	bit pclk=0;
	apb_test test; 

 	
	//clock generation 
	initial forever begin 
		#5 pclk  =~ pclk; 
	end 

	apb_intf INTF(pclk);

	//DUT connection
	apb_slave DUT (
		.pclk (INTF.pclk),
		.rst_n(INTF.rst_n), 
		.paddr(INTF.paddr), 
		.psel(INTF.psel), 
		.penable(INTF.penable), 
		.pwrite(INTF.pwrite), 
		.pwdata(INTF.pwdata), 
		.prdata(INTF.prdata) 
	);


	initial begin 
		test = new ("test",INTF); 
		test.run_test();
		//$stop();
		$finish();
	end 

endmodule 