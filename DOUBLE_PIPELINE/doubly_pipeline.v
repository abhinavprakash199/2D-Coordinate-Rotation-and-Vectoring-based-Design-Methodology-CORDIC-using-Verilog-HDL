module DOUBLY_PIPELINE(clk,xi,yi,r,ang,xf,yf);
input signed[15:0] xi,yi;
input clk;
//input signed [15:0] angle;
 
output reg signed [15:0] r,ang;
output reg signed [15:0] xf,yf;
 wire signed [15:0] ri,angi;
 wire  signed [15:0] xfi,yfi;
wire  signed [15:0] g1,g2,g3,g4,g5,g6,g7,g8;

ROTATING x1(clk,xi,yi,g1,g2,g3,g4,g5,g6,g7,g8,xfi,yfi);    // rotation mode cordic

VECTORING x2(clk,xi,yi,g1,g2,g3,g4,g5,g6,g7,g8,ri,angi); // vectoring mode cordic

always @(*)
begin 
   
xf<=xfi;
yf<=yfi;  
r<=ri;
ang<=angi;

end
endmodule

module ROTATING(clk,xi,yi,a1,a2,a3,a4,a5,a6,a7,a8,xf,yf);
input signed[15:0] xi,yi;
input   signed [15:0] a1,a2,a3,a4,a5,a6,a7,a8;
input clk;
//input signed [15:0] angle;
output reg  signed [15:0] xf,yf;

reg  signed [15:0] x1,x2,x3,x4,x5,x6,x7,x8;
reg  signed [15:0] y1,y2,y3,y4,y5,y6,y7,y8;
reg signed [15:0] angle45,angle26,angle14,angle7,angle3_5,angle1_79,angle0_89,angle0_44;
reg  signed [15:0] angle_i [8:0]; // for intermediate angle storage
reg signed [15:0] s = 16'd607;
//reg [7:0]angle_i[15:0];

// assigning defined angles 
always @(*) 
 begin
angle45 = 16'd4500;          //16'b01010111111001000;
angle26  = 16'd2657; // 16'b00110011111000010;
angle14  = 16'd1404;  //17'b0011011011011000;
angle7   = 16'd713;  //17'b0001101111011010;
angle3_5 = 16'd358;  //17'b0000110111111100;
angle1_79 = 16'd179; //17'b0000011011111110;
angle0_89 = 16'd89; //17'b0000001101111111;
angle0_44 = 16'd44; //17'b0000000111000000;

end

always @(posedge clk)
begin  
    angle_i[0] <= angle45 ;
	    x1<= xi + yi;  // intial addition 
		y1<= yi - xi;
		
	  // if (angle_i[0] > angle)
	   if (angle_i[0] > a2)
		begin 
		x2<= x1 - (y1>>>1);  
		y2<= y1 + (x1>>>1); 
		angle_i[1] <= angle_i[0] - angle26 ; 
       	//a1<=angle_i[0] ;	
		end 
	   else
		begin 
		x2<= x1+(y1>>>1); 
		y2<= y1-(x1>>>1);
	    angle_i[1] <= angle_i[0] + angle26 ;  
			//a1<=angle_i[0] ;
	   end
	 //if (angle_i[1] > angle)
	 if (angle_i[1] > a3)
	    begin 
		 angle_i[2] <= angle_i[1] - angle14 ;  
		  x3<= x2 - (y2>>>2); 
		  y3<= y2 +(x2>>>2);
		 // a2<=angle_i[1] ;
		end 
		else 
		begin 
	      angle_i[2] <= angle_i[1] + angle14 ;  
		  x3<= x2+(y2>>>2); 
		  y3<= y2-(x2>>>2);
		//  a2<=angle_i[1] ;
		end 
	//if (angle_i[2] > angle)
	if (angle_i[2] > a4)
	    begin 
		  angle_i[3] <= angle_i[2] - angle7 ;  
		  x4<= x3 - (y3>>>3); 
		  y4<= y3 +(x3>>>3);
		 // a3<=angle_i[2] ;
		 end 
		else 
		begin 
	     angle_i[3] <= angle_i[2] + angle7 ;  
		  x4<= x3+(y3>>>3); 
		  y4<= y3-(x3>>>3);
		 //  a3<=angle_i[2] ;
		end 
		//if (angle_i[3] > angle)
		if (angle_i[3] > a5)
	    begin 
			angle_i[4] <= angle_i[3] - angle3_5 ;  
			x5<= x4 - (y4>>>4); 
			y5<= y4 + (x4>>>4);
		  //  a4<=angle_i[3] ;
		 end 
		else 
		begin
			angle_i[4] <= angle_i[3] + angle3_5 ;  
			x5<= x4+(y4>>>4); 
			y5<= y4-(x4>>>4);
		//	a4<=angle_i[3] ;
		end 
	  // if (angle_i[4] > angle)
	   if (angle_i[4] > a6)
	    begin 
			angle_i[5] <= angle_i[4] - angle1_79 ;  
			x6<= x5 - (y5>>>5); 
			y6<= y5 +(x5>>>5);
			//a5<=angle_i[4] ;
		end
		else 
		begin 
	       angle_i[5] <= angle_i[4] + angle1_79 ;  
		   x6<= x5+(y5>>>5); 
		   y6<= y5-(x5>>>5);
		   //a5<=angle_i[4] ;
		end 
		//if (angle_i[5] > angle)
		if (angle_i[5] > a7)
	    begin 
			angle_i[6] <= angle_i[5] - angle0_89 ;  
			x7<= x6 - (y6>>>6); 
			y7<= y6 +(x6>>>6);
			//a6<=angle_i[5] ;
		end
		else 
		begin 
			angle_i[6] <= angle_i[5] + angle0_89;  
			x7<= x6+(y6>>>6); 
			y7<= y6-(x6>>>6);
			//a6<=angle_i[5] ;
		end 
		//if (angle_i[6] > angle)
		if (angle_i[6] > a8)
	     begin 
			angle_i[7] <= angle_i[6] - angle0_44 ;  
			x8<= x7 - (y7>>>7); 
			y8<= y7 +(x7>>>7);
			//a7<=angle_i[6] ;
		 end 
		 else 
         begin 	     
			angle_i[7] <= angle_i[6] + angle0_44 ;  
			x8<= x7+(y7>>>7); 
			y8<= y7-(x7>>>7);
			//a7<=angle_i[6] ;
		 end  
		 //a8<=angle_i[7] ;
      xf <=  (s*x8)/1000 ;
      yf <=  (s*y8)/1000 ;	  
end 
		
endmodule
	 
module VECTORING(clk,a0,b0,ang1,ang2,ang3,ang4,ang5,ang6,ang7,ang8,r,ang);
input signed[15:0]a0,b0;
//input signed[15:0] ang1,ang2,ang3,ang4,ang5,ang6,ang7,ang8;
input clk;
  output reg signed [15:0]r,ang; // norm and angle 
  output reg signed[15:0] ang1,ang2,ang3,ang4,ang5,ang6,ang7,ang8; // intermediate angles at each stage 
  reg signed [15:0] a1,a2,a3,a4,a5,a6,a7,a8;
//  reg signed [15:0] ang1,ang2,ang3,ang4,ang5,ang6,ang7,ang8;
  reg signed [15:0] b1,b2,b3,b4,b5,b6,b7,b8;
  reg signed[15:0] angle_x1,angle_x2,angle_x3,angle_x4,angle_x5,angle_x6,angle_x7,angle_x8;
reg signed [15:0] v;
always @(*)
begin
v<=16'd0607;
end
reg [15:0]angle[7:0];

always @(*)
begin
  angle[0]<=16'd4500;
  angle[1]<=16'd2657;
  angle[2]<=16'd1404;
  angle[3]<=16'd713;
  angle[4]<=16'd358;
  angle[5]<=16'd179;
  angle[6]<=16'd089;
  angle[7]<=16'd044;
end 

  always @ (posedge clk)
   begin
      a1<=a0+b0;
      b1<=b0-a0;
      angle_x1 <= angle[0];
	  ang1 <= angle_x1;
      //angle_x1 <=ang1 ;
    if(b1 < 0)  
   begin
      a2<= a1 - (b1>>>1);
      b2<= b1 + (a1>>>1);
     angle_x2<=angle_x1-angle[1];
     //angle_x2<=angle_x1-ang2;
	   ang2<= angle_x2;
     end
    else
   begin
      a2<=a1+(b1>>>1);
      b2<=b1-(a1>>>1);
      angle_x2<=angle_x1+angle[1];
     // angle_x2<=angle_x1+ ang2;
	  ang2<= angle_x2;
    end
     if(b2<0)
	begin
     a3<=a2-(b2>>>2);
     b3<=b2+(a2>>>2);
     angle_x3<=angle_x2-angle[2];
      //angle_x3<=angle_x2-ang3;
	  ang3<= angle_x3;
     end
  	else
  	begin
      a3<=a2+(b2>>>2);
      b3<=b2-(a2>>>2);
      angle_x3<=angle_x2+angle[2];
      //angle_x3<=angle_x2+ ang3;
	  ang3<= angle_x3;
	end
     if(b3<0)
	begin
     a4<=a3-(b3>>>3);
     b4<=b3+(a3>>>3);
     angle_x4<=angle_x3-angle[3];
	 ang4<=angle_x4;
      //angle_x4<=angle_x3-ang4;
     end
  	else
  	begin
      a4<=a3+(b3>>>3);
      b4<=b3-(a3>>>3);
     angle_x4<=angle_x3+angle[3];
	 ang4<=angle_x4;
      //angle_x4<=angle_x3 + ang4;
	end
     if(b4<0)
	begin
     a5<=a4-(b4>>>4);
     b5<=b4+(a4>>>4);
      angle_x5<=angle_x4-angle[4];
	   ang5<=angle_x5;
      //angle_x5<=angle_x4- ang5;
     end
  	else
  	begin
      a5<=a4+(b4>>>4);
      b5<=b4-(a4>>>4);
      angle_x5<=angle_x4+angle[4];
	   ang5<=angle_x5;
      //angle_x5<=angle_x4+ang5;
	end
     if(b5<0)
	begin
     a6<=a5-(b5>>>5);
     b6<=b5+(a5>>>5);
    angle_x6<=angle_x5-angle[5];
	 ang6<=angle_x6;
      //angle_x6<=angle_x5-ang6;
     end
  	else
  	begin
      a6<=a5+(b5>>>5);
      b6<=b5-(a5>>>5);
      angle_x6<=angle_x5+angle[5];
	  ang6<=angle_x6;
      //angle_x6<=angle_x5+ang6;
	end
     if(b6<0)
	begin
     a7<=a6-(b6>>>6);
     b7<=b6+(a6>>>6);
     angle_x7<=angle_x6-angle[6];
	 ang7<=angle_x7;
     // angle_x7<=angle_x6-ang7;
     end
  	else
  	begin
     a7<=a6+(b6>>>6);
     b7<=b6-(a6>>>6);
      angle_x7<=angle_x6+angle[6];
	  ang7<=angle_x7;
     // angle_x7<=angle_x6 + ang7;
 	 end
     if(b7<0)
	begin
      a8<=a7-(b7>>>7);
      b8<=b7+(a7>>>7);
      angle_x8<=angle_x7-angle[7];
	  ang8<=angle_x8;
     end
  	else
      begin
      a8<=a7+(b7>>>7);
      b8<=b7-(a7>>>7);
       angle_x8<=angle_x7-angle[7];
	   ang8<=angle_x8;
	   
     end
r<=v*a8/1000;
ang<=angle_x8;
end
  
endmodule
	 
	 
	 
	 
