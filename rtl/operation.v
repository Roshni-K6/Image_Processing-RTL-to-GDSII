module operation(
input [7:0] gray,
input [2:0] mode,
input [7:0] brightness,
input [7:0] threshold,
output reg [7:0] out
);
  
always @(*) begin
case(mode)
3'b000: out = gray;
3'b001: out = 8'd255 - gray;
3'b010: out = gray + brightness;
3'b011: out = (gray > threshold) ? 8'd255 : 8'd0;
default: out = gray;
endcase
end
  
endmodule
