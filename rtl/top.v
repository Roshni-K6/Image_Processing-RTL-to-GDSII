module top(
input clk,
input [23:0] pixel_in,
input [2:0] mode,
input [7:0] brightness,
input [7:0] threshold,
output [7:0] pixel_out
);
  
wire [7:0] R, G, B;
wire [7:0] gray;
assign R = pixel_in[23:16];
assign G = pixel_in[15:8];
assign B = pixel_in[7:0];
  
grayscale u1 (.R(R), .G(G), .B(B), .gray(gray));
operation u2 (
.gray(gray),
.mode(mode),
.brightness(brightness),
.threshold(threshold),
.out(pixel_out)
);
endmodule
