module top(input clk,
	input [1:0] in,
	output [4:0] out );

reg [1:0] cnt = 0;
//wire [4:1] out;
wire clk_int_1, clk_int_2;
IBUF ibuf_proxy(.I(clk), .O(ibuf_proxy_out));
IBUF ibuf_inst(.I(ibuf_proxy_out), .O(ibuf_out));
//IBUF ibuf_inst_2(.I(ibuf_out_1), .O(ibuf_out_2));
assign clk_int_1 = ibuf_out;
assign clk_int_2 = clk_int_1;
//assign do = out[0];

always @(posedge clk_int_2) begin
	cnt <= cnt + 1;
end

middle middle_inst_1(.clk(ibuf_out), .out(out[2]));
middle middle_inst_2(.clk(clk_int_1), .out(out[3]));
middle middle_inst_3(.clk(clk_int_2), .out(out[4]));

assign out[1:0] = {cnt[0], in[0]};
endmodule

module middle(input clk,
	output out);

reg [1:0] cnt = 0;
wire clk_int;
assign clk_int = clk;
always @(posedge clk_int) begin
	cnt <= cnt + 1;
end

assign out = cnt[0];
endmodule
/*
module dut();
reg clk;
wire [1:0] out;

top dut(.clk(clk), .in(2'b11), .out(out));
initial begin
	$dumpfile("test.vcd");
	$dumpvars(0,dut);
	clk = 0;
end

always
begin
	clk = #5 !clk;
end
endmodule
*/