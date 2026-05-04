module grayscale(
input [7:0] R, G, B,
output [7:0] gray);
assign gray = (R+G+B)/3;
endmodule
