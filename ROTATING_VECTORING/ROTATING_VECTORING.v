module ROTATING_VECTORING(clk,xi,yi,xf,yf);
 input clk;
 input [15:0]xi,yi; 
 output [15:0] xf,yf;
 wire [15:0]theta,norm;
 VECTORING first(clk,xi,yi,theta,norm);
 ROTATING second(xi,yi,theta,xf,yf,clk);
endmodule

/////////////////////////Rotation////////////////////////////////////////////////
module ROTATING(x0, y0, theta, xf, yf, clk);
  input clk;
  input [15:0] x0, y0;
  input [15:0] theta;
  output [15:0] xf, yf;
  wire [15:0] xi [0:7]; 
  wire [15:0] yi [0:7];
  reg [2:0] stage;
  wire [15:0] outangle [0:7];
  
  
  // instantiating
  
  //stage0
  cordics r0(clk, 3'd0, x0, y0, theta, 16'd45_00, 16'd0, xi[0], yi[0], outangle[0]);
  //stage1
  cordics r1(clk, 3'd1, xi[0], yi[0], theta, 16'd26_57, outangle[0], xi[1], yi[1], outangle[1]);
  //stage2
  cordics r2(clk, 3'd2, xi[1], yi[1], theta, 16'd14_04, outangle[1], xi[2], yi[2], outangle[2]); 
  //stage3
  cordics r3(clk, 3'd3, xi[2], yi[2], theta, 16'd7_13, outangle[2], xi[3], yi[3], outangle[3]);
  //stage4
  cordics r4(clk, 3'd4, xi[3], yi[3], theta, 16'd3_58, outangle[3], xi[4], yi[4], outangle[4]);  
  //stage5
  cordics r5(clk, 3'd5, xi[4], yi[4], theta, 16'd1_79, outangle[4], xi[5], yi[5], outangle[5]);
  //stage6
  cordics r6(clk, 3'd6, xi[5], yi[5], theta, 16'd89, outangle[5], xi[6], yi[6], outangle[6]);
  //stage7
  cordics r7(clk, 3'd7, xi[6], yi[6], theta, 16'd44, outangle[6], xi[7], yi[7], outangle[7]);
  assign xf = xi[7];
  assign yf = yi[7];
  // assign xf <= (xi[7]>>>1)+(xi[7]>>>4)+(xi[7]>>>5);
  //assign yf <= (yi[7]>>>1)+(yi[7]>>>4)+(yi[7]>>>5);
  
endmodule
  
  
module cordics(clk,stage,xi,yi,theta,uangle,inangle,xf,yf,outangle);
 input clk;
 input [2:0] stage;
 input [15:0] xi,yi,theta,inangle,uangle;
 output reg [15:0] xf,yf,outangle;

 always @(posedge clk)begin
   if((inangle)>theta)begin                                   //clockwise

    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    outangle <= inangle-uangle;
   end
   
   else begin 
    case({xi[15],yi[15]})
       2'b00 : begin                                        //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         outangle <= inangle+uangle;
   end
  end
endmodule

/////////////////////////Vectoring////////////////////////////////////////////////

module VECTORING(clk, xi, yi, theta, norm);
input clk;
input [15:0] xi, yi;
output [15:0] theta, norm;
reg [2:0] stage;
wire [15:0] x [0:7];
wire [15:0] y [0:7];
wire [15:0] outangle [0:7];

 //stage 0
   cordicvec v0(clk,3'd0,xi,yi,16'd0,x[0],y[0],outangle[0],16'd45_00);
 //stage 1
   cordicvec v1(clk,3'd1,x[0],y[0],outangle[0],x[1],y[1],outangle[1],16'd26_57); 
 //stage 2
   cordicvec v2(clk,3'd2,x[1],y[1],outangle[1],x[2],y[2],outangle[2],16'd14_04);
 //stage 3
   cordicvec v3(clk,3'd3,x[2],y[2],outangle[2],x[3],y[3],outangle[3],16'd7_13);
 //stage 4
   cordicvec v4(clk,3'd4,x[3],y[3],outangle[3],x[4],y[4],outangle[4],16'd3_58); 
 //stage 5
   cordicvec v5(clk,3'd5,x[4],y[4],outangle[4],x[5],y[5],outangle[5],16'd1_79); 
 //stage 6
   cordicvec v6(clk,3'd6,x[5],y[5],outangle[5],x[6],y[6],outangle[6],16'd89);
 //stage 7
   cordicvec v7(clk,3'd7,x[6],y[6],outangle[6],x[7],y[7],outangle[7],16'd44); 
   
    assign norm = x[7];
    assign theta = outangle[7];
  // assign xf = (x[7]>>>1)+(x[7]>>>4)+(x[7]>>>5);
   //assign yf = (y[7]>>>1)+(y[7]>>>4)+(y[7]>>>5);    
endmodule


module cordicvec (clk, stage, xi, yi, inangle, xf, yf, outangle, uangle);

input clk;
input [2:0] stage;
input [15:0] xi, yi, inangle, uangle;
output reg [15:0] xf, yf, outangle;

 always @(posedge clk)
 
 begin
 
  if (yi[15])
   begin
   case({xi[15],yi[15]})
       2'b00 : begin                              //anticlockwise
          xf <= xi-(yi>>stage);
          yf <= yi + (xi>>stage);
        end
       2'b01 : begin
            xf <= xi + ((16'hffff-yi+1)>>stage);
            yf <= -(16'hffff-yi+1) + (xi>>stage);
        end 
       2'b10 : begin
          xf <= -((16'hffff-xi+1))-(yi>>stage);
          yf <= yi - ((16'hffff-xi+1)>>stage);
        end 
       2'b11 : begin
          xf <= -(16'hffff-xi+1)+((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - ((16'hffff-xi+1)>>stage);
        end
    endcase
         outangle <= inangle-uangle;
   end

     else begin                                    //clockwise
    case({xi[15],yi[15]})
       2'b00 : begin
          xf <= xi+(yi>>stage);
            yf <= yi - (xi>>stage);
       end
       2'b01 : begin
          xf <= xi-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) - (xi>>stage);
       end 
      2'b10 : begin
          xf <= -(16'hffff-xi+1)+(yi>>stage);
          yf <= yi +((16'hffff-xi+1)>>stage);
       end
      2'b11 : begin 
          xf <= -(16'hffff-xi+1)-((16'hffff-yi+1)>>stage);
          yf <= -(16'hffff-yi+1) + ((16'hffff-xi+1)>>stage);
       end
    endcase
    outangle <= inangle+uangle;
   end
 end
 endmodule