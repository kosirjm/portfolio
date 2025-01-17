/*

This software/hardware design was originally created by Peter Jamieson
jamiespa@muohio.edu  http://www.users.muohio.edu/jamiespa/

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

*/ 
module student_prototype
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_DAT3,						//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
		TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_27;				//	27 MHz
input			CLOCK_50;				//	50 MHz
input			EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input			UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
//output			IRDA_TXD;				//	IRDA Transmitter
//input			IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	[15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output	[11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	[7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output	[21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output	[17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	[15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output	[1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			OTG_INT0;				//	ISP1362 Interrupt 0
input			OTG_INT1;				//	ISP1362 Interrupt 1
input			OTG_DREQ0;				//	ISP1362 DMA Request 0
input			OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	[7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout			SD_DAT;					//	SD Card Data
inout			SD_DAT3;				//	SD Card Data 3
inout			SD_CMD;					//	SD Card Command Signal
output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	PS2_DAT;				//	PS2 Data
input			PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	[7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			TD_HS;					//	TV Decoder H_SYNC
input			TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
////////////////////////	GPIO	////////////////////////////////
input	[35:0]	GPIO_0;					//	GPIO Connection 0
output	[35:0]	GPIO_1;					//	GPIO Connection 1

/*-----------------------Our Code-Non Dr. Jamieson Code------------------
This is the code that was created by us.  We used John Loomis' ps2lab1
code to help with the key board and his vgalab2 code the help
with the discplay.  Also lynden helped us with ideas and allowed us 
to look at his code to see how he did certain things that we were having
troubles with*/
wire [7:0] scan_code;
wire [7:0]packet; 
reg [8:0]scanToHex = 9'b0;
reg [8:0] history = 9'h0;
reg [7:0] code;
reg enter;
reg temp;
reg [9:0]counter = 10'd0; 


//John Loomis's ps2lab1 code(modified)-----------------------------------
wire read, scan_ready;

oneshot pulser(
   .pulse_out(read),
   .trigger_in(scan_ready),
   .clk(CLOCK_50)
);

keyboard kbd(
  .keyboard_clk(PS2_CLK),
  .keyboard_data(PS2_DAT),
  .clock50(CLOCK_50),
  .reset(reset),
  .read(read),
  .scan_ready(scan_ready),
  .scan_code(scan_code)
);

//-------------------------End of ps2lab1--------------------------------

//-------------------------John Loomis' vgalab2(modified)--------------------------
wire DLY_RST;
Reset_Delay r0(	.iCLK(CLOCK_50),.oRESET(DLY_RST) );

wire		VGA_CTRL_CLK;
wire		AUD_CTRL_CLK;
wire [9:0]	mVGA_R;
wire [9:0]	mVGA_G;
wire [9:0]	mVGA_B;
wire [9:0]	mCoord_X;
wire [9:0]	mCoord_Y;

assign	TD_RESET = 1'b1; // Enable 27 MHz

VGA_Audio_PLL 	p (	
	.areset(~DLY_RST),
	.inclk0(CLOCK_27),
	.c0(VGA_CTRL_CLK),
	.c1(AUD_CTRL_CLK),
	.c2(VGA_CLK)
);

textbox u3(
	.iCLK1(VGA_CLK),
	.iCLK2(VGA_CTRL_CLK),
	.px(mCoord_X),
	.py(mCoord_Y),
	.valid(valid),
	.pixel(pixel),
	.packet(packet),
	.letter(history),
	.recieved1(received_message[255:248]),
	.recieved2(received_message[247:240]),
	.recieved3(received_message[239:232]),
	.recieved4(received_message[231:224]),
	.recieved5(received_message[223:216]),
	.recieved6(received_message[215:208]),
	.recieved7(received_message[207:200]),
	.recieved8(received_message[199:192]),
	.recieved9(received_message[191:184]),
	.recieved10(received_message[183:176]),
	.recieved11(received_message[175:168]),
	.recieved12(received_message[167:160]),
	.recieved13(received_message[159:152]),
	.recieved14(received_message[151:144]),
	.recieved15(received_message[143:136]),
	.recieved16(received_message[135:128]),
	.recieved17(received_message[127:120]),
	.recieved18(received_message[119:112]),
	.recieved19(received_message[111:104]),
	.recieved20(received_message[103:96]),
	.recieved21(received_message[95:88]),
	.recieved22(received_message[87:80]),
	.recieved23(received_message[79:72]),
	.recieved24(received_message[71:64]),
	.recieved25(received_message[63:56]),
	.recieved26(received_message[55:48]),
	.recieved27(received_message[47:40]),
	.recieved28(received_message[39:32]),
	.recieved29(received_message[31:24]),
	.recieved30(received_message[23:16]),
	.recieved31(received_message[15:8]),
	.recieved32(received_message[7:0]),
	.rst(rst_n),
	.count(counter)
);

wire valid, pixel;
wire s = valid & pixel;

parameter GREEN = 10'h255;
parameter BLACK = 10'h010;

assign mVGA_R = (s? BLACK: BLACK);
assign mVGA_G = (s? GREEN: BLACK);
assign mVGA_B = (s? BLACK: BLACK);

vga_sync u1(
   .iCLK(VGA_CTRL_CLK),
   .iRST_N(DLY_RST&KEY[0]),	
   .iRed(mVGA_R),
   .iGreen(mVGA_G),
   .iBlue(mVGA_B),
   // pixel coordinates
   .px(mCoord_X),
   .py(mCoord_Y),
   // VGA Side
   .VGA_R(VGA_R),
   .VGA_G(VGA_G),
   .VGA_B(VGA_B),
   .VGA_H_SYNC(VGA_HS),
   .VGA_V_SYNC(VGA_VS),
   .VGA_SYNC(VGA_SYNC),
   .VGA_BLANK(VGA_BLANK)
);
//-----------------------End John Loomis' vgalab2--------------------------

//-----------------------Our code------------------------------------------
//got help with scan code
always @(posedge scan_ready)
begin
	if(code != {4'h5,4'hA})
	begin
		enter = 1'b1;
		case(code)
		4'h4,4'h5:scanToHex = "0";
		4'h1,4'h6:scanToHex = "1";
		4'h1,4'hE:scanToHex = "2";
		4'h2,4'h6:scanToHex = "3";
		4'h2,4'h5:scanToHex = "4";
		4'h2,4'hE:scanToHex = "5";
		4'h3,4'h6:scanToHex = "6";
		4'h3,4'hD:scanToHex = "7";
		4'h3,4'hE:scanToHex = "8";
		4'h4,4'h6:scanToHex = "9";
		4'h1,4'hC:scanToHex = "A";
		4'h3,4'h2:scanToHex = "B";
		4'h2,4'h1:scanToHex = "C";
		4'h2,4'h3:scanToHex = "D";
		4'h2,4'h4:scanToHex = "E";
		4'h2,4'hB:scanToHex = "F";
		endcase
	end
	
	else
	begin
		enter = 1'b0;
	end
	
	if(code == {4'h2,4'h9})
			temp = 1'b1;
	else
		temp=1'b0;
		
end

//Counter on space bar lyndens idea
always @(posedge scan_ready)
begin
	code = scan_code; //takes in the scan code from the keyboard
	if(temp == 1'b1)
		counter = counter+1'b1;
	history = scanToHex;
end

//-------------------End of our code--------------------------------

//-------------------Dr. Jamieson' Code(slightly modified)----------
//	Turn on all display
assign	HEX4		=	7'h00;
assign	HEX5		=	7'h00;
assign	HEX6		=	7'h00;
assign	HEX7		=	7'h00;
assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;

//	All inout port turn to tri-state
assign	DRAM_DQ		=	16'hzzzz;
assign	FL_DQ		=	8'hzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	OTG_DATA	=	16'hzzzz;
assign	LCD_DATA	=	8'hzz;
assign	SD_DAT		=	1'bz;
assign	I2C_SDAT	=	1'bz;
assign	AUD_ADCLRCK	=	1'bz;
assign	AUD_DACLRCK	=	1'bz;
assign	AUD_BCLK	=	1'bz;

// reset delay gives some time for peripherals to initialize

wire clk;
assign clk = CLOCK_50;

wire rst_n;
assign rst_n = KEY[0];

wire [17:0]SWdebounced;
/* This debounces your switches as SW into SWO */
debounce_DE2_SW debSW(clk, rst_n, toSend, SWdebounced);


/* This is a module that does sending of a single packet for you.  It sends the values from SW7 through SW0 (A Byte) when "send pulse" is high */
reg send_a_packet_pulse;
sender sender1(
				.clk(clk),//Clock
				.rst_n(rst_n),//Reset
				.send_data(packet), //Packet to be sent
				.do_now(send_a_packet_pulse),//Sends packet
				.rdy_o(GPIO_1[0]),//?
				.data_o(GPIO_1[8:1]),//?
				.ack_o(GPIO_0[9]),//?
				.done_pulse(LEDG[1])//Ready for new send
			);

/* This is a module to receive the information from the master.  The packet is in "packet_received" and received_a_packet_pulse goes high for a clock pulse every time
it receives a packet */
wire [7:0]packet_received;
wire received_a_packet_pulse;
reg [7:0]received_bytes;
receiver receiver1(
				.clk(clk),//Clock
				.rst_n(rst_n),//Reset
				.sent_data(packet_received),//Packet data being sent to slave
				.rdy_i(GPIO_0[0]),//?
				.data_i(GPIO_0[8:1]),//?
				.ack_i(GPIO_1[9]),//?
				.pulse_got(received_a_packet_pulse)//Tells to send
			);

// holds 32bytes of the encrypted message
reg [255:0]received_message;

// Display the packets received on the seven segments
wire [3:0]packet_choice;
assign packet_choice = SWdebounced[11:8];

reg [15:0]hex_message;
seg7 h0(hex_message[3:0],HEX0);
seg7 h1(hex_message[7:4],HEX1);
seg7 h2(hex_message[11:8],HEX2);
seg7 h3(hex_message[15:12],HEX3);

// multiplexes between the packet parts to show on the HEX numbers 
always@(packet_choice or received_message)
begin
	if (packet_choice == 4'd0)
	begin
		hex_message = received_message[15:0];
	end
	else if (packet_choice == 4'd1)
	begin
		hex_message = received_message[31:16];
	end
	else if (packet_choice == 4'd2)
	begin
		hex_message = received_message[47:32];
	end
	else if (packet_choice == 4'd3)
	begin
		hex_message = received_message[63:48];
	end
	else if (packet_choice == 4'd4)
	begin
		hex_message = received_message[79:64];
	end
	else if (packet_choice == 4'd5)
	begin
		hex_message = received_message[95:80];
	end
	else if (packet_choice == 4'd6)
	begin
		hex_message = received_message[111:96];
	end
	else if (packet_choice == 4'd7)
	begin
		hex_message = received_message[127:112];
	end
	else if (packet_choice == 4'd8)
	begin
		hex_message = received_message[143:128];
	end
	else if (packet_choice == 4'd9)
	begin
		hex_message = received_message[159:144];
	end
	else if (packet_choice == 4'd10)
	begin
		hex_message = received_message[175:160];
	end
	else if (packet_choice == 4'd11)
	begin
		hex_message = received_message[191:176];
	end
	else if (packet_choice == 4'd12)
	begin
		hex_message = received_message[207:192];
	end
	else if (packet_choice == 4'd13)
	begin
		hex_message = received_message[223:208];
	end
	else if (packet_choice == 4'd14)
	begin
		hex_message = received_message[239:224];
	end
	else 
	begin
		hex_message = received_message[255:240];
	end
end

// sends a packet to the other board through the GPIO and waits 2^26 / 50000000 seconds for count until next send possible...this could be optimized
// To send your message to the master you need to press KEY[3] 7 times with the proper encoded messages.  You can press KEY[3] when the LEDG[0] is lit. 
// After the seventh byte the Master will send you 32 Bytes which is the encrypted message.  
// Next, you will need to decode that message and send the 4 Byte Code back to the master to show you've decoded it

// Send packets are of the form (each "| |" seperates 8 bits | --> | number of packets in message | your id | level | code | code | code | code |
// Therefore the code should be: 00000111 XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
// since there are 7 packets

// return packet is of the form 32 bytes where the MSbit of each packet 8 bit byte is a parity bit for error checking 
// This is the 7 bits after the MSbit are an ASCII code (that has been encrypted in level 1 and above)

//assign LEDR[7:0] = received_bytes;
assign LEDG[0] = (delay_count != 0) ? 1'b0 : 1'b1;
reg [26:0]delay_count;
always @(posedge clk or negedge rst_n)
begin
	if (rst_n == 1'b0)
	begin
		send_a_packet_pulse <= 1'b0;
		delay_count <= 26'd0;
		received_bytes <= 8'd0;
		received_message <= 255'd0;
	end
	else
	begin
		/* pulse sending system */
		if (delay_count == 26'd0)
		begin
			if ((code == {4'h5,4'hA}) && (enter == 1'b0))//Changed so sends on enter
			begin
				delay_count <= 26'd1;
				send_a_packet_pulse <= 1'b1;
			end
		end	
		else
		begin
			send_a_packet_pulse <= 1'b0;
			delay_count <= delay_count + 1'b1;
		end

		/* receive packets */
		if (received_a_packet_pulse == 1'b1)
		begin
			received_bytes <= received_bytes + 1'b1;
			
			if (received_bytes == 8'd0)
			begin
				received_message[7:0] <= packet_received;
			end
			else if (received_bytes == 8'd1)
			begin
				received_message[15:8] <= packet_received;
			end
			else if (received_bytes == 8'd2)
			begin
				received_message[23:16] <= packet_received;
			end
			else if (received_bytes == 8'd3)
			begin
				received_message[31:24] <= packet_received;
			end
			else if (received_bytes == 8'd4)
			begin
				received_message[39:32] <= packet_received;
			end
			else if (received_bytes == 8'd5)
			begin
				received_message[47:40] <= packet_received;
			end
			else if (received_bytes == 8'd6)
			begin
				received_message[55:48] <= packet_received;
			end
			else if (received_bytes == 8'd7)
			begin
				received_message[63:56] <= packet_received;
			end
			else if (received_bytes == 8'd8)
			begin
				received_message[71:64] <= packet_received;
			end
			else if (received_bytes == 8'd9)
			begin
				received_message[79:72] <= packet_received;
			end
			else if (received_bytes == 8'd10)
			begin
				received_message[87:80] <= packet_received;
			end
			else if (received_bytes == 8'd11)
			begin
				received_message[95:88] <= packet_received;
			end
			else if (received_bytes == 8'd12)
			begin
				received_message[103:96] <= packet_received;
			end
			else if (received_bytes == 8'd13)
			begin
				received_message[111:104] <= packet_received;
			end
			else if (received_bytes == 8'd14)
			begin
				received_message[119:112] <= packet_received;
			end
			else if (received_bytes == 8'd15)
			begin
				received_message[127:120] <= packet_received;
			end
			else if (received_bytes == 8'd16)
			begin
				received_message[135:128] <= packet_received;
			end
			else if (received_bytes == 8'd17)
			begin
				received_message[143:136] <= packet_received;
			end
			else if (received_bytes == 8'd18)
			begin
				received_message[151:144] <= packet_received;
			end
			else if (received_bytes == 8'd19)
			begin
				received_message[159:152] <= packet_received;
			end
			else if (received_bytes == 8'd20)
			begin
				received_message[167:160] <= packet_received;
			end
			else if (received_bytes == 8'd21)
			begin
				received_message[175:168] <= packet_received;
			end
			else if (received_bytes == 8'd22)
			begin
				received_message[183:176] <= packet_received;
			end
			else if (received_bytes == 8'd23)
			begin
				received_message[191:184] <= packet_received;
			end
			else if (received_bytes == 8'd24)
			begin
				received_message[199:192] <= packet_received;
			end
			else if (received_bytes == 8'd25)
			begin
				received_message[207:200] <= packet_received;
			end
			else if (received_bytes == 8'd26)
			begin
				received_message[215:208] <= packet_received;
			end
			else if (received_bytes == 8'd27)
			begin
				received_message[223:216] <= packet_received;
			end
			else if (received_bytes == 8'd28)
			begin
				received_message[231:224] <= packet_received;
			end
			else if (received_bytes == 8'd29)
			begin
				received_message[239:232] <= packet_received;
			end
			else if (received_bytes == 8'd30)
			begin
				received_message[247:240] <= packet_received;
			end
			else if (received_bytes == 8'd31)
			begin
				received_message[255:248] <= packet_received;
			end
		end
	end
end

// check the parity ... not done for all bytes in the message...
//parity_bit_check p1(received_message[7:0], LEDR[16]);
//parity_bit_check p2(received_message[15:8], LEDR[17]);

endmodule
