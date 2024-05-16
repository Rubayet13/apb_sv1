interface apb_intf(input wire pclk);
	//logic 			pclk; 
	logic 			rst_n; 
	logic [31:0]	paddr; 
	logic 			psel; 
	logic 			penable; 
	logic 		 	pwrite; 
	logic [31:0] 	pwdata; 
	logic [31:0] 	prdata; 
endinterface 
