module DoorLockProject(Reset, SetPass, PassIn, Enter, Access, Count, Alarm);
	input Reset, Enter;
	input [11:0]SetPass, PassIn;
	output Access, Alarm;
	output [1:0] Count;
	wire Check;
	
	assign Check = !(SetPass ^ PassIn);
	modN_ctr Counter(Enter, !Check, Reset, Count, Access, Alarm);
endmodule

module modN_ctr(clk, E, rstn, cnt, Access, Alarm);
parameter N = 4;
parameter WIDTH = 2;
input clk, rstn, E;
output reg Access, Alarm;
output reg [WIDTH-1:0]cnt;

always @ (posedge clk, posedge rstn)
	if(rstn) begin
	Alarm <= 0;
	cnt <= 0;
	end
	else if(E & cnt == N-2) begin
	Access <= 0;
	Alarm <= 1;
	cnt <= cnt+1;
	end
	else if(cnt == N-1) begin
	Access <= 0;
	Alarm <= 1;
	end
	else if(E) begin
	cnt <= cnt+1;
	Access <= 0;
	Alarm <= 0;
	end
	else begin
	cnt <= 0;
	Access <= 1;
	Alarm <= 0;
	end
	
endmodule

