module v_RSA_binary( 
		input clk,	
		input start,	 
		input key_ready,				
		input finished
		);

	parameter RESULT=3'b000, 
		  IDLE=3'b001, 
		  INIT=3'b010, 
		  LOAD1=3'b011, 
		  LOAD2=3'b100, 
		  MULT=3'b101, 
		  SQR=3'b110;

	property multSqrThenResult;
		@(posedge clk) (RSA_binary.FSM==RESULT) |-> 
		$past(RSA_binary.FSM==SQR,1) &&
		$past(RSA_binary.FSM==MULT,2);
	endproperty
	checkMultSqrThenResult: assert property(multSqrThenResult);

endmodule
