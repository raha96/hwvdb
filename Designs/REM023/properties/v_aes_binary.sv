module v_aes_binary( 
		input clk,	
		input data_stable,	 
		input key_ready,				
		input finished,		
		input [1:0] round_type_sel
		);

parameter WAIT_KEY = 3'b001, WAIT_DATA= 3'b010, INITIAL_ROUND= 3'b011, DO_ROUND= 3'b100, FINAL_ROUND= 3'b000;

property doRoundBeforeFinalRound;
	@(posedge clk)
	((aes_binary.FSM==WAIT_DATA) ##1(aes_binary.FSM==INITIAL_ROUND)) ##1 (!((aes_binary.FSM==DO_ROUND) & 
	!(aes_binary.FSM==FINAL_ROUND)))[*1:$] |-> 
	!(aes_binary.FSM==FINAL_ROUND);
endproperty
checkDoRoundBeforeFinalRound: assert property(doRoundBeforeFinalRound);


endmodule
