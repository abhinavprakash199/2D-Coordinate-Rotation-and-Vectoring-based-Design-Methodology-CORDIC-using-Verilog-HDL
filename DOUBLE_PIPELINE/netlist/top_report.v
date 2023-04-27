
// Generated by Cadence Genus(TM) Synthesis Solution 20.10-p001_1
// Generated on: Apr 27 2023 19:13:56 IST (Apr 27 2023 13:43:56 UTC)

// Verification Directory fv/top 

module top(clk, xi, yi, r, ang, xf, yf);
  input clk;
  input [15:0] xi, yi;
  output [15:0] r, ang, xf, yf;
  wire clk;
  wire [15:0] xi, yi;
  wire [15:0] r, ang, xf, yf;
  wire [15:0] g1;
  wire [15:0] g2;
  wire [15:0] g3;
  wire [15:0] g4;
  wire [15:0] g5;
  wire [15:0] g6;
  wire [15:0] g7;
  wire [15:0] g8;
  mycordic x1(clk, xi, yi, g1, g2, g3, g4, g5, g6, g7, g8, xf, yf);
  cordic_vec x2(clk, xi, yi, g1, g2, g3, g4, g5, g6, g7, g8, r, ang);
endmodule

