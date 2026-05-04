module tb;
reg clk;
reg [23:0] pixel_in;
reg [2:0] mode;
reg [7:0] brightness;
reg [7:0] threshold;
wire [7:0] pixel_out;
reg [23:0] mem [0:4095]; // for 64x64
integer i;
integer f;
  
top uut (
 .clk(clk),
 .pixel_in(pixel_in),
 .mode(mode),
 .brightness(brightness),
 .threshold(threshold),
 .pixel_out(pixel_out)
);
  
always #5 clk = ~clk;
initial begin
 $fsdbDumpfile("nova.fsdb");
 $fsdbDumpvars(0, tb);
end
initial begin
 clk = 0;
 $readmemh("../data/image.hex", mem); // Read image
// Set parameters
 mode = 3'b000; // grayscale
 brightness = 20;
 threshold = 100;
 f = $fopen("../data/out.hex", "w"); // Output file
 for(i = 0; i < 4096; i = i + 1) 
 begin
 pixel_in = mem[i]; #10;
 $fwrite(f, "%h\n", pixel_out);
 $display("IN=%h OUT=%h", pixel_in, pixel_out); 
 end
 $fclose(f);
 $finish;
end
endmodule
