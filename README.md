# 2D-Coordinate-Rotating-and-Vectoring-based-Design-Methodology-CORDIC-using-Verilog-HDL

# Table of Contents
---
   * [2D Coordinate Rotating based Design Methodology CORDIC using Verilog HDL](#2D-Coordinate-Rotating-based-Design-Methodology-CORDIC-using-Verilog-HDL)
      + [SIMULATION OUTPUT of ROTATING](#SIMULATION-OUTPUT-of-ROTATING)
      + [SYNTHESIS of ROTATING using GENUS](#SYNTHESIS-of-ROTATING-using-GENUS)
   * [2D Coordinate Vectoring based Design Methodology CORDIC using Verilog HDL](#2D-Coordinate-Vectoring-based-Design-Methodology-CORDIC-using-Verilog-HDL)
      + [SIMULATION OUTPUT of VECTORING](#SIMULATION-OUTPUT-of-VECTORING)
      + [SYNTHESIS of VECTORING using GENUS](#SYNTHESIS-of-VECTORING-using-GENUS)
   * [Computing Transcendental Functions using Rotating and Vectoring based Design Methodology CORDIC](#Computing-Transcendental-Functions-using-Rotating-and-Vectoring-based-Design-Methodology-CORDIC)
      + [SIMULATION OUTPUT of ROTATING_VECTORING](#SIMULATION-OUTPUT-of-ROTATING_VECTORING)
      + [SYNTHESIS of ROTATING_VECTORING using GENUS](#SYNTHESIS-of-ROTATING_VECTORING-using-GENUS)
   * [Doubly Pipeline in Rotating and Vectoring based Design Methodology CORDIC](#Doubly-Pipeline-in-Rotating-and-Vectoring-based-Design-Methodology-CORDIC)
      + [SIMULATION OUTPUT of DOUBLY PIPELINE](#SIMULATION-OUTPUT-of-DOUBLY-PIPELINE)
      + [SYNTHESIS of DOUBLY PIPELINE using GENUS](#SYNTHESIS-of-DOUBLY-PIPELINE-using-GENUS)

    * [Acknowledgement](#Acknowledgement)
    * [Inquiries](#Inquiries)



## 2D Coordinate Rotating based Design Methodology CORDIC using Verilog HDL
---
### CODES
```verilog
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
```

### TESTBENCH
```verilog
module ROTATING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]x0,y0;
  reg [15:0]theta;
  wire [15:0]xf,yf;
  always @(*)begin
    #period clk<=~clk;
    end
  ROTATING dut(x0,y0,theta,xf,yf,clk);
  initial begin
    {x0,y0,theta}={16'd3, 16'd4, 16'd5300};
   end
endmodule
```
### SIMULATION OUTPUT of ROTATING
![image](https://user-images.githubusercontent.com/120498080/234830625-3d804203-44e0-4f9c-bed0-e1a2a6b7e655.png)

### SYNTHESIS of ROTATING using GENUS
- First login to server
```
ssh -X dic_lab_02@192.168.88.31
```
- Then create a working directory (ROTATING) at: 
> /DIG_DESIGN/INTERNS/dic_lab_02/ABHINAV/VECTORING/
- Then write the `ROTATING.v` and `ROTATING.tcl` file in the working directory.

- Now invoke CADENCE in the working directory.
#### Steps to invoke Cadence
```
tcsh
source /DIG_DESIGN02/APPLICATION_CMS/Cadence/cshrc_cadence
```
- Now invoke GENUS in the working directory.
```
genus -legacy_ui
```
- Now to runs synthesis run the `.tcl` file using followig command.
```
source ROTATING.tcl
```
#### `ROTATING.tcl` file 
```verilog
set_attribute hdl_search_path {/DIG_DESIGN/INTERNS/dic_lab_02/ABHINAV/ROTATING/} 
set_attribute lib_search_path {/DIG_DESIGN/INTERNS/PDK_DIC/}

set_attribute library {slow_vdd1v0_basicCells.lib}

set myFiles [list ROTATING.v]
set_attribute information_level 7

set basename ROTATING;
set myClk clk;

set myPeriod_ps 1000;
set myInDelay_ns 0.2;
set myOutDelay_ns 0.2;
set runname report;

read_hdl ${myFiles}
elaborate ${basename}

set_top_module  ${basename}

set clock [define_clock -period ${myPeriod_ps} -name ${myClk} [clock_ports]]	
external_delay -input $myInDelay_ns -clock ${myClk} [find / -port ports_in/*]
external_delay -output $myOutDelay_ns -clock ${myClk} [find / -port ports_out/*]

check_design -unresolved
report timing -lint

# Synthesize the design to the target library
synthesize -to_mapped -effort medium

# Write out the reports
report timing > genus_reports/${basename}_${runname}_timing.rep
report gates  > genus_reports/${basename}_${runname}_cell.rep
report power  > genus_reports/${basename}_${runname}_power.rep

# Write out the structural Verilog and sdc files
write_hdl -mapped >  netlist/${basename}_${runname}.v
write_sdc >  sdc/${basename}_${runname}.sdc

# show result
gui_raise

```

#### TERMINAL
![image](https://user-images.githubusercontent.com/120498080/234879918-a6eb292f-0ccb-44d3-9736-f72689cc95e7.png)

![image](https://user-images.githubusercontent.com/120498080/234887335-e3baa5c1-f26f-419e-aae1-8ec535a6b925.png)


#### SYNTHESIZED DESIGN
![image](https://user-images.githubusercontent.com/120498080/234886939-9161f19c-bb44-4d1f-a99d-ca062bdbd07f.png)

![image](https://user-images.githubusercontent.com/120498080/234887095-9a2987d6-a892-4410-885b-da87f1c57521.png)



## 2D Coordinate Vectoring based Design Methodology CORDIC using Verilog HDL
---
### CODES
```verilog

module VECTORING(clk,xi,yi,theta,R);
 input clk;
 input [15:0]xi,yi;
 output [15:0] R,theta;  
 reg[2:0]stage;
 wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8;
 wire [15:0]outangle0,outangle1,outangle2,outangle3,outangle4,outangle5,outangle6,outangle7;
 //stage 0
   itteration i0(clk,3'd0,xi,yi,16'd0,16'd45_00,x1,y1,outangle0);
 //stage 1
   itteration i1(clk,3'd1,x1,y1,outangle0,16'd26_57,x2,y2,outangle1); 
 //stage 2
   itteration i2(clk,3'd2,x2,y2,outangle1,16'd14_04,x3,y3,outangle2);
 //stage 3
   itteration i3(clk,3'd3,x3,y3,outangle2,16'd7_13,x4,y4,outangle3);
 //stage 4
   itteration i4(clk,3'd4,x4,y4,outangle3,16'd3_58,x5,y5,outangle4); 
 //stage 5
   itteration i5(clk,3'd5,x5,y5,outangle4,16'd1_79,x6,y6,outangle5); 
 //stage 6
   itteration i6(clk,3'd6,x6,y6,outangle5,16'd89,x7,y7,outangle6);
 //stage 7
   itteration i7(clk,3'd7,x7,y7,outangle6,16'd44,x8,y8,outangle7); 
   
    assign R = x8;
    assign theta = outangle7;
  // assign xf = (x8>>>1)+(x8>>>4)+(x8>>>5);
   //assign yf = (y8>>>1)+(y8>>>4)+(y8>>>5);    
 endmodule
  
module itteration(clk,stage,xi,yi,initial_angle,micro_angle,xf,yf,out_angle);
 input clk;
 input [2:0] stage;
  input [15:0]xi,yi,initial_angle,micro_angle;
  output reg [15:0] xf,yf,out_angle;
  
//assign micro_angle[7:0] ={16'd448,16'd895,16'd1790,16'd3580,16'd7130,16'd14040,16'd26570,16'd45000};
 
 always @(posedge clk)begin
  /* 
   if(yi==16'd0)begin    
     xf <= xi;
     yf <= 0;
     out_angle <= initial_angle;
     end
  */
   if (yi[15])begin 
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
         out_angle <= initial_angle-micro_angle;
   end

     else begin        //clockwise
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
    out_angle <= micro_angle+initial_angle;
   end

   end
   endmodule
```

### TESTBENCH
```verilog
module VECTORING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]xi,yi;
  wire [15:0]R,theta;
  always @(*)begin
    #period clk<=~clk;
    end
  VECTORING dut(clk,xi,yi,theta,R);
  initial begin
    {xi,yi}={16'd30, 16'd40};
   end
endmodule
```

### SIMULATION OUTPUT of VECTORING
![image](https://user-images.githubusercontent.com/120498080/234829624-069f476e-d320-4be5-9143-89d95a12d49c.png)

### SYNTHESIS of VECTORING using GENUS
![image](https://user-images.githubusercontent.com/120498080/234885994-24a27983-4c29-437c-be60-e19013ae9820.png)

![image](https://user-images.githubusercontent.com/120498080/234889509-cd0ce787-95d3-4834-822c-a290912bb953.png)

#### SYNTHESIZED DESIGN
![image](https://user-images.githubusercontent.com/120498080/234889801-510c0986-d9ba-4de5-aeda-af588c1b828e.png)

![image](https://user-images.githubusercontent.com/120498080/234889946-9359a9a6-4934-47c9-a955-9824e94a437d.png)

## Computing Transcendental Functions using Rotating and Vectoring based Design Methodology CORDIC
---
### CODES
```verilog
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
```
### TESTBENCH
```verilog
module ROTATING_VECTORING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]xi,yi;
  wire [15:0]xf,yf;
  always @(*)begin
    #period clk<=~clk;
    end
  ROTATING_VECTORING dut(clk,xi,yi,xf,yf);
  initial begin
    {xi,yi}={16'd20, 16'd20};
   end
endmodule
```
### SIMULATION OUTPUT of ROTATING_VECTORING
![image](https://user-images.githubusercontent.com/120498080/234833305-9252b1b2-a7bd-4746-92e8-40f0271179bf.png)

### SYNTHESIS of ROTATING_VECTORING using GENUS
![image](https://user-images.githubusercontent.com/120498080/234882531-b23e6c20-8edb-4b07-9c31-c4cf5ac2f48d.png)

![image](https://user-images.githubusercontent.com/120498080/234882157-28627f65-10fd-4028-910f-364f5cd086ba.png)

#### SYNTHESIZED DESIGN
![image](https://user-images.githubusercontent.com/120498080/234881437-31d5c5b1-561c-4b7b-a945-f4bc7afe9969.png)

## Doubly Pipeline in Rotating and Vectoring based Design Methodology CORDIC
---
### CODES
```verilog
module DOUBLY_PIPELINE(clk,xi,yi,xf,yf);
 input clk;
 input [15:0]xi,yi; 
 output [15:0] xf,yf;
 wire [15:0]theta,R;
 wire [7:0]dir;
 VECTORING first(clk,xi,yi,theta,R,dir);
 ROTATING second(clk,dir,xi,yi,theta,xf,yf);
endmodule

module ROTATING(clk,dir,xi,yi,theta,xf,yf);
 input clk;
 input [15:0]xi,yi;
 input [15:0] theta;
 input dir[7:0];
 output [15:0] xf,yf;  
 reg[2:0]stage;
 wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8;
   wire [15:0]outangle0,outangle1,outangle2,outangle3,outangle4,outangle5,outangle6,outangle7;
 //stage 0
   itteration_rot i0(clk,dir[0],3'd0,xi,yi,16'd0,theta,16'd45_00,x1,y1,outangle0);
 //stage 1
   itteration_rot i1(clk,dir[1],3'd1,x1,y1,outangle0,theta,16'd26_57,x2,y2,outangle1); 
 //stage 2
   itteration_rot i2(clk,dir[2],3'd2,x2,y2,outangle1,theta,16'd14_04,x3,y3,outangle2);
 //stage 3
   itteration_rot i3(clk,dir[3],3'd3,x3,y3,outangle2,theta,16'd7_13,x4,y4,outangle3);
 //stage 4
   itteration_rot i4(clk,dir[4],3'd4,x4,y4,outangle3,theta,16'd3_58,x5,y5,outangle4); 
 //stage 5
   itteration_rot i5(clk,dir[5],3'd5,x5,y5,outangle4,theta,16'd1_79,x6,y6,outangle5);
 //stage 6
   itteration_rot i6(clk,dir[6],3'd6,x6,y6,outangle5,theta,16'd89,x7,y7,outangle6);
 //stage 7
   itteration_rot i7(clk,dir[7],3'd7,x7,y7,outangle6,theta,16'd44,x8,y8,outangle7); 
   
    assign xf=x8;
    assign yf=y8;
  // assign xf = (x8>>>1)+(x8>>>4)+(x8>>>5);
   //assign yf = (y8>>>1)+(y8>>>4)+(y8>>>5);    
 endmodule
  
 

module itteration_rot(clk,dir_stage,stage,xi,yi,initial_angle,theta,micro_angle,xf,yf,out_angle);
 input clk;
 input [2:0] stage;
 input dir_stage;
  input [15:0]xi,yi,theta,initial_angle,micro_angle;
  output reg [15:0] xf,yf,out_angle;

 always @(posedge clk)begin
   if(!dir_stage)begin     //clockwise

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
    out_angle <= -micro_angle+initial_angle;
   end
   
   else begin 
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
         out_angle <= initial_angle+micro_angle;
   end
   end
   endmodule

module ROTATING(clk,xi,yi,theta,R,dir);
 input clk;
 input [15:0]xi,yi;
 output [15:0] R,theta;
 output reg dir[7:0];  
 reg[2:0]stage;
 wire dir0,dir1,dir2,dir3,dir4,dir5,dir6,dir7;
 wire [15:0]x1,x2,x3,x4,x5,x6,x7,x8,y1,y2,y3,y4,y5,y6,y7,y8;
 wire [15:0]outangle0,outangle1,outangle2,outangle3,outangle4,outangle5,outangle6,outangle7;
 //stage 0
   itteration_vec i0(clk,3'd0,xi,yi,16'd0,16'd45_00,x1,y1,outangle0,dir0);
 //stage 1
   itteration_vec i1(clk,3'd1,x1,y1,outangle0,16'd26_57,x2,y2,outangle1,dir1); 
 //stage 2
   itteration_vec i2(clk,3'd2,x2,y2,outangle1,16'd14_04,x3,y3,outangle2,dir2);
 //stage 3
   itteration_vec i3(clk,3'd3,x3,y3,outangle2,16'd7_13,x4,y4,outangle3,dir3);
 //stage 4
   itteration_vec i4(clk,3'd4,x4,y4,outangle3,16'd3_58,x5,y5,outangle4,dir4); 
 //stage 5
   itteration_vec i5(clk,3'd5,x5,y5,outangle4,16'd1_79,x6,y6,outangle5,dir5); 
 //stage 6
   itteration_vec i6(clk,3'd6,x6,y6,outangle5,16'd89,x7,y7,outangle6,dir6);
 //stage 7
   itteration_vec i7(clk,3'd7,x7,y7,outangle6,16'd44,x8,y8,outangle7,dir7); 

    assign dir[0] = dir0;
    assign dir[1] = dir1;
    assign dir[2] = dir2;
    assign dir[3] = dir3;
    assign dir[4] = dir4;
    assign dir[5] = dir5;
    assign dir[6] = dir6;
    assign dir[7] = dir7;
  
    assign R = x8;
    assign theta = outangle7;
  // assign xf = (x8>>>1)+(x8>>>4)+(x8>>>5);
   //assign yf = (y8>>>1)+(y8>>>4)+(y8>>>5);    
 endmodule
  
module itteration_vec(clk,stage,xi,yi,initial_angle,micro_angle,xf,yf,out_angle,dir_stage);
 input clk;
 input [2:0] stage;
  input [15:0]xi,yi,initial_angle,micro_angle;
  output reg [15:0] xf,yf,out_angle;
  output reg dir_stage;

 //assign micro_angle[7:0] ={16'd448,16'd895,16'd1790,16'd3580,16'd7130,16'd14040,16'd26570,16'd45000};
 
 always @(posedge clk)begin
  
   if (yi[15])begin 
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
         out_angle <= initial_angle-micro_angle;
         dir_stage <=1;
   end

     else begin        //clockwise
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
    out_angle <= micro_angle+initial_angle;
    dir_stage <=0;
   end

   end
   endmodule
```
### TESTBENCH 
```verilog
module ROTATING_VECTORING_TB #(parameter period=5);
  reg clk=0;
  reg [15:0]xi,yi;
  wire [15:0]xf,yf;
  always @(*)begin
    #period clk<=~clk;
    end
  double_pipe dut(clk,xi,yi,xf,yf);
  initial begin
    {xi,yi}={16'd20, 16'd20};
   end
endmodule
```
### SIMULATION OUTPUT of DOUBLY PIPELINE

![image](https://user-images.githubusercontent.com/120498080/234903628-18ade448-d2e3-4021-8d43-7fc7e0cd7b6d.png)

### SYNTHESIS of DOUBLY PIPELINE using GENUS
![image](https://user-images.githubusercontent.com/120498080/234931535-f41f9392-ca92-41dd-8a6f-20a08d98dd90.png)

![image](https://user-images.githubusercontent.com/120498080/234933426-eb93eac7-518b-42e9-b0da-1c2a92fe1085.png)

#### SYNTHESIZED DESIGN

## Acknowledgement
---
- [Dr. Amit Acharyya](https://people.iith.ac.in/amit_acharyya/)

## Inquiries
---
- Connect with me at [LinkedIn](https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile)

