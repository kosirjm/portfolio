module textbox(
	input iCLK1,iCLK2,
	input [9:0] px,
	input [9:0] py,
	input [8:0]letter,
	input [7:0]recieved1,
	input [7:0]recieved2,
	input [7:0]recieved3,
	input [7:0]recieved4,
	input [7:0]recieved5,
	input [7:0]recieved6,
	input [7:0]recieved7,
	input [7:0]recieved8,
	input [7:0]recieved9,
	input [7:0]recieved10,
	input [7:0]recieved11,
	input [7:0]recieved12,
	input [7:0]recieved13,
	input [7:0]recieved14,
	input [7:0]recieved15,
	input [7:0]recieved16,
	input [7:0]recieved17,
	input [7:0]recieved18,
	input [7:0]recieved19,
	input [7:0]recieved20,
	input [7:0]recieved21,
	input [7:0]recieved22,
	input [7:0]recieved23,
	input [7:0]recieved24,
	input [7:0]recieved25,
	input [7:0]recieved26,
	input [7:0]recieved27,
	input [7:0]recieved28,
	input [7:0]recieved29,
	input [7:0]recieved30,
	input [7:0]recieved31,
	input [7:0]recieved32,
	input rst,
	input [30:0]count,
	output reg valid,
	output pixel,
	output reg [7:0]packet
);
parameter COLS = 64;
parameter ROWS = 16;

reg [7:0] numBytes[0:3];
reg [7:0] uniqueID[0:3];
reg [7:0] level[0:3];
reg [7:0] code[0:7];
reg [7:0] answer[0:7];

reg [3:0] second;
reg [3:0] first;

//Counting the button press and create packet every two was lyndons idea
always @(*)
begin
	case(count)
	30'b0:
	begin
		numBytes[1] = letter;
		numBytes[0] = " ";
		numBytes[2] = " ";
		numBytes[3] = " ";
		uniqueID[3] = " "; 
		uniqueID[2] = " ";
		uniqueID[1] = " ";
		uniqueID[0] = " ";
		level[3] = " ";
		level[2] = " ";
		level[1] = " ";
		level[0] = " ";
		code[0] = " ";
		code[1] = " ";
		code[2] = " ";
		code[3] = " ";
		code[4] = " ";
		code[5] = " ";
		code[6] = " ";
		code[7] = " ";
		answer[0] = " ";
		answer[1] = " ";
		answer[2] = " ";
		answer[3] = " ";
		answer[4] = " ";
		answer[5] = " ";
		answer[6] = " ";
		answer[7] = " ";
		
		first = second;
	end
		
	30'd2:
	begin
		numBytes[0] = letter;
		packet = {first,second};
	end
	
	30'd4:
	begin
		uniqueID[1] = letter;
		first = second;
	end
	
	30'd6:
	begin
		uniqueID[0] = letter;
		first = {first,second};
	end
	
	30'd8:
	begin
		level[1] = letter;
		first = second;
	end
	
	30'd10:
	begin
		level[0] = letter;
		first = {first,second};
	end
	
	30'd12:
	begin
		code[0] = letter;
		first = second;
	end
	
	30'd14:
	begin
		code[1] = letter;
		packet = {first,second};
	end
	
	30'd16:
	begin
		code[2] = letter;
		first = second;
	end
	
	30'd18:
	begin
		code[3] = letter;
		packet = {first,second};
	end
	
	30'd20:
	begin
		code[4] = letter;
		first = second;
	end
	
	30'd22:
	begin
		code[5] = letter;
		packet = {first,second};
	end
	
	30'd24:
	begin
		code[6] = letter;
		first = second;
	end
	
	30'd26:
	begin
		code[7] = letter;
		packet = {first,second};
	end
	
	30'd28:
	begin
		numBytes[3] = letter;
		first = second;
	end
	
	30'd30:
	begin
		numBytes[2] = letter;
		packet = {first,second};
	end
	
	30'd32:
	begin
		uniqueID[3] = letter;
		first = second;
	end
	
	30'd34:
	begin
		uniqueID[2] = letter;
		packet = {first,second};
	end
	
	30'd36:
	begin
		level[3] = letter;
		first = second;
	end
	
	30'd38:
	begin
		level[2] = letter;
		packet = {first,second};
	end
	
	30'd40:
	begin
		answer[0] = letter;
		first = second;
	end
	
	30'd42:
	begin
		answer[1] = letter;
		packet = {first,second};
	end
	
	30'd44:
	begin
		answer[2] = letter;
		first = second;
	end
	
	30'd46:
	begin
		answer[3] = letter;
		packet = {first,second};
	end
	
	30'd48:
	begin
		answer[4] = letter;
		first = second;
	end
	
	30'd50:
	begin
		answer[5] = letter;
		packet = {first,second};
	end
	
	30'd52:
	begin
		answer[6] = letter;
		first = second;
	end
	
	30'd54:
	begin
		answer[7] = letter;
		packet = {first,second};
	end
	endcase

case(letter)
	"0": second = 4'h0;
	"1": second = 4'h1;
	"2": second = 4'h2;
    "3": second = 4'h3;
	"4": second = 4'h4;
	"5": second = 4'h5;
	"6": second = 4'h6;
	"7": second = 4'h7;
	"8": second = 4'h8;
	"9": second = 4'h9;
	"A": second = 4'hA;
	"B": second = 4'hB;
	"C": second = 4'hC;
	"D": second = 4'hD;
	"E": second = 4'hE;
	"F": second = 4'hF;
endcase
end

// test that we are inside the textbox
always
	if (px>=COLS*8) valid <= 1'b0;
	else if (py>=ROWS*16) valid <= 1'b0;
	else valid <= 1'b1;

// instantiate sysfont memory
sysfont mem2(
	.address(address),
	.clock(iCLK2),
	.q(q)
	);
	
wire [10:0] address = {	qchar[6:0], py[3:0] };
wire [7:0] q;
reg [7:0] qchar;
reg rom_mux_output;
wire [9:0] character_address = {py[7:4],px[8:3]};

always @(*)
begin
	case(character_address)

		{6'd1, 6'd1} : qchar = "E";
		{6'd1, 6'd2} : qchar = "n";
		{6'd1, 6'd3} : qchar = "t";
		{6'd1, 6'd4} : qchar = "e";
		{6'd1, 6'd5} : qchar = "r";
		{6'd1, 6'd6} : qchar = " ";
		{6'd1, 6'd7} : qchar = "b";
		{6'd1, 6'd8} : qchar = "y";
		{6'd1, 6'd9} : qchar = "t";
		{6'd1, 6'd10} : qchar = "e";
		{6'd1, 6'd11} : qchar = "s";
		{6'd1, 6'd12} : qchar = ":";
		{6'd1, 6'd13} : qchar = numBytes[1];
		{6'd1, 6'd14} : qchar = numBytes[0];

		{6'd2, 6'd1} : qchar = "E";
		{6'd2, 6'd2} : qchar = "n";
		{6'd2, 6'd3} : qchar = "t";
		{6'd2, 6'd4} : qchar = "e";
		{6'd2, 6'd5} : qchar = "r";
		{6'd2, 6'd6} : qchar = " ";
		{6'd2, 6'd7} : qchar = "u";
		{6'd2, 6'd8} : qchar = "n";
		{6'd2, 6'd9} : qchar = "i";
		{6'd2, 6'd10} : qchar = "q";
		{6'd2, 6'd11} : qchar = "u";
		{6'd2, 6'd12} : qchar = "e";
		{6'd2, 6'd13} : qchar = " ";
		{6'd2, 6'd14} : qchar = "I";
		{6'd2, 6'd15} : qchar = "D";
		{6'd2, 6'd16} : qchar = ":";
		{6'd2, 6'd17} : qchar = uniqueID[1];
		{6'd2, 6'd18} : qchar = uniqueID[0];

		{6'd3, 6'd1} : qchar = "L";
		{6'd3, 6'd2} : qchar = "e";
		{6'd3, 6'd3} : qchar = "v";
		{6'd3, 6'd4} : qchar = "e";
		{6'd3, 6'd5} : qchar = "l";
		{6'd3, 6'd6} : qchar = ":";
		{6'd3, 6'd7} : qchar = level[1];
		{6'd3, 6'd8} : qchar = level[0];
	
		{6'd4, 6'd1} : qchar = "E";
		{6'd4, 6'd2} : qchar = "n";
		{6'd4, 6'd3} : qchar = "t";
		{6'd4, 6'd4} : qchar = "e";
		{6'd4, 6'd5} : qchar = "r";
		{6'd4, 6'd6} : qchar = " ";
		{6'd4, 6'd7} : qchar = "c";
		{6'd4, 6'd8} : qchar = "o";
		{6'd4, 6'd9} : qchar = "d";
		{6'd4, 6'd10} : qchar = "e";
		{6'd4, 6'd11} : qchar = ":";
		{6'd4, 6'd12} : qchar = code[0];
		{6'd4, 6'd13} : qchar = code[1];
		{6'd4, 6'd14} : qchar = code[2];
		{6'd4, 6'd15} : qchar = code[3];
		{6'd4, 6'd16} : qchar = code[4];
		{6'd4, 6'd17} : qchar = code[5];
		{6'd4, 6'd18} : qchar = code[6];
		{6'd4, 6'd19} : qchar = code[7];

		{6'd5, 6'd1} : qchar = recieved1;
		{6'd5, 6'd2} : qchar = recieved2;
		{6'd5, 6'd3} : qchar = recieved3;
		{6'd5, 6'd4} : qchar = recieved4;
		{6'd5, 6'd5} : qchar = recieved5;
		{6'd5, 6'd6} : qchar = recieved6;
		{6'd5, 6'd7} : qchar = recieved7;
		{6'd5, 6'd8} : qchar = recieved8;
		{6'd5, 6'd9} : qchar = recieved9;
		{6'd5, 6'd10} : qchar = recieved10;
		{6'd5, 6'd11} : qchar = recieved11;
		{6'd5, 6'd12} : qchar = recieved12;
		{6'd5, 6'd13} : qchar = recieved13;
		{6'd5, 6'd14} : qchar = recieved14;
		{6'd5, 6'd15} : qchar = recieved15;
		{6'd5, 6'd16} : qchar = recieved16;
		{6'd5, 6'd17} : qchar = recieved17;
		{6'd5, 6'd18} : qchar = recieved18;
		{6'd5, 6'd19} : qchar = recieved19;
		{6'd5, 6'd20} : qchar = recieved20;
		{6'd5, 6'd21} : qchar = recieved21;
		{6'd5, 6'd22} : qchar = recieved22;
		{6'd5, 6'd23} : qchar = recieved23;
		{6'd5, 6'd24} : qchar = recieved24;
		{6'd5, 6'd25} : qchar = recieved25;
		{6'd5, 6'd26} : qchar = recieved26;
		{6'd5, 6'd27} : qchar = recieved27;
		{6'd5, 6'd28} : qchar = recieved28;
		{6'd5, 6'd29} : qchar = recieved29;
		{6'd5, 6'd30} : qchar = recieved30;
		{6'd5, 6'd31} : qchar = recieved31;
		{6'd5, 6'd32} : qchar = recieved32;
		
		{6'd6, 6'd1} : qchar = "E";
		{6'd6, 6'd2} : qchar = "n";
		{6'd6, 6'd3} : qchar = "t";
		{6'd6, 6'd4} : qchar = "e";
		{6'd6, 6'd5} : qchar = "r";
		{6'd6, 6'd6} : qchar = " ";
		{6'd6, 6'd7} : qchar = "b";
		{6'd6, 6'd8} : qchar = "y";
		{6'd6, 6'd9} : qchar = "t";
		{6'd6, 6'd10} : qchar = "e";
		{6'd6, 6'd11} : qchar = "s";
		{6'd6, 6'd12} : qchar = ":";
		{6'd6, 6'd13} : qchar = numBytes[3];
		{6'd6, 6'd14} : qchar = numBytes[2];

		{6'd7, 6'd1} : qchar = "E";
		{6'd7, 6'd2} : qchar = "n";
		{6'd7, 6'd3} : qchar = "t";
		{6'd7, 6'd4} : qchar = "e";
		{6'd7, 6'd5} : qchar = "r";
		{6'd7, 6'd6} : qchar = " ";
		{6'd7, 6'd7} : qchar = "u";
		{6'd7, 6'd8} : qchar = "n";
		{6'd7, 6'd9} : qchar = "i";
		{6'd7, 6'd10} : qchar = "q";
		{6'd7, 6'd11} : qchar = "u";
		{6'd7, 6'd12} : qchar = "e";
		{6'd7, 6'd13} : qchar = " ";
		{6'd7, 6'd14} : qchar = "I";
		{6'd7, 6'd15} : qchar = "D";
		{6'd7, 6'd16} : qchar = ":";
		{6'd7, 6'd17} : qchar = uniqueID[3];
		{6'd7, 6'd18} : qchar = uniqueID[2];

		{6'd8, 6'd1} : qchar = "L";
		{6'd8, 6'd2} : qchar = "e";
		{6'd8, 6'd3} : qchar = "v";
		{6'd8, 6'd4} : qchar = "e";
		{6'd8, 6'd5} : qchar = "l";
		{6'd8, 6'd6} : qchar = ":";
		{6'd8, 6'd7} : qchar = level[3];
		{6'd8, 6'd8} : qchar = level[2];
	
		{6'd9, 6'd1} : qchar = "E";
		{6'd9, 6'd2} : qchar = "n";
		{6'd9, 6'd3} : qchar = "t";
		{6'd9, 6'd4} : qchar = "e";
		{6'd9, 6'd5} : qchar = "r";
		{6'd9, 6'd6} : qchar = " ";
		{6'd9, 6'd7} : qchar = "c";
		{6'd9, 6'd8} : qchar = "o";
		{6'd9, 6'd9} : qchar = "d";
		{6'd9, 6'd10} : qchar = "e";
		{6'd9, 6'd11} : qchar = ":";
		{6'd9, 6'd12} : qchar = answer[0];
		{6'd9, 6'd13} : qchar = answer[1];
		{6'd9, 6'd14} : qchar = answer[2];
		{6'd9, 6'd15} : qchar = answer[3];
		{6'd9, 6'd16} : qchar = answer[4];
		{6'd9, 6'd17} : qchar = answer[5];
		{6'd9, 6'd18} : qchar = answer[6];
		{6'd9, 6'd19} : qchar = answer[7];

		default: qchar="";
	endcase
end

	// Mux to pick off correct rom data bit from 8-bit word
	// for on screen character generation
	always
	case (px[2:0])
	0: rom_mux_output = q[0];
	1: rom_mux_output = q[7];
	2: rom_mux_output = q[6];
	3: rom_mux_output = q[5];
	4: rom_mux_output = q[4];
	5: rom_mux_output = q[3];
	6: rom_mux_output = q[2];
	7: rom_mux_output = q[1];
	endcase
	
	assign pixel = rom_mux_output;
	
endmodule



	