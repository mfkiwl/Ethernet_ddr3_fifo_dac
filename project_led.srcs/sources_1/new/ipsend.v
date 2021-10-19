`timescale 1ns / 1ps
module ipsend
(
    input              	    clk,                   
    input      	[31:0]	    crc,                   
    input      	[31:0]  	datain,              	
    
    input					e_rxdv,
    input 					data_ok,
    input		[7:0]       IP4_type,
    input		[31:0]      IP4_src,
    
    input      	[15:0]  	len_IPv4,       
    input      	[15:0]  	len_ICMP, 
    input      	[15:0]  	len_UDP, 
    
    input 		[511:0]     ICMP_data,
    input 		[567:0]	    UDP_data,
    
    input       [15:0]      UDP_SP,
    input       [15:0]      UDP_DP,
    input       [15:0]      UDP_DATA_LEN,    
    
    input 		[47:0]  	eth_dest,
    input 		[47:0]  	eth_src,
    input 		[15:0]  	eth_type,
    input 		[47:0]  	sender_mac,
    input 		[31:0]  	sender_ip, 
    input 		[31:0]  	target_ip,
    
    input      	[15:0]  	tx_data_length,       
    input      	[15:0]  	tx_total_length, 

    output reg			txen,                  
    output reg         	txer,                
    output reg [7:0]   	dataout,             
    output reg         	crcen,                 
    output reg        	crcre,                
    output reg [7:0]   	tx_state             
    //output reg [8:0]   	ram_rd_addr,      
    //output reg         	led1
);


	  
//reg [7:0]   state;	  
	  
reg [31:0]  datain_reg;

reg [31:0] ip_header [6:0];                  
reg [7:0]  preamble [7:0];                    //preamble
reg [7:0]  mac_addr [13:0];                   //mac address
reg [7:0]  i,j;

reg [31:0] check_buffer;
reg [31:0] time_counter;
reg [15:0] tx_data_counter;


reg [7:0] arp_reply [63:0]; 
reg [7:0] ip4_icmp [39:0]; 
reg [31:0] icmp_header [15:0]; //16*32=512bits
reg [7:0] eth_header[13:0];

reg [31:0] cnt_time;
reg [7:0] type_tx;

reg [7:0] alg_state;
reg [7:0] igp_cnt;

reg [7:0] udp_discovery [62:0]; 


parameter 	ICMP=8'd1, UDP=8'd17;

parameter 	IDLE				=8'd0,
			PREPARE_ARP			=8'd1,
			PREPARE_UDP			=8'd2,
			PREPARE_ICMP		=8'd3,
			SEND_ARP			=8'd4,
			SEND_ICMP			=8'd5,
			SEND_UDP			=8'd6,
			DELAY				=8'd255;


				
							
//FPGA MAC address
parameter MAC1	= 8'h00;
parameter MAC2	= 8'h1C;
parameter MAC3	= 8'h23;	
parameter MAC4	= 8'h17;	
parameter MAC5	= 8'h4A;	
parameter MAC6	= 8'hCC;
	
//FPGA IP address
parameter IP1	= 8'd192;
parameter IP2	= 8'd168;
parameter IP3	= 8'd0;
parameter IP4	= 8'd222;



initial begin
 tx_state<=8'h00;
 alg_state<=8'd0;
 igp_cnt<=8'd0;
 
 //led1<=1'b1;	
 cnt_time<=0;
 type_tx<=8'h00;
 
 preamble[0]<=8'h55;                 
 preamble[1]<=8'h55;
 preamble[2]<=8'h55;
 preamble[3]<=8'h55;
 preamble[4]<=8'h55;
 preamble[5]<=8'h55;
 preamble[6]<=8'h55;
 preamble[7]<=8'hD5;
 i<=0;
end


/*
ila_2 ila2_inst
(
    .clk(~clk),
    .probe0(dataout),
    .probe1(tx_state),
    .probe2(data_ok),
    .probe3(txen),
    .probe4(txer),
    .probe5(eth_type),
    .probe6(IP4_type),
    .probe7(alg_state)
);*/

ila_2 eth_tx_dbg
(
    .clk(~clk),
    .probe0(tx_state),  //8bit
    .probe1(alg_state), //8bit
    .probe2(data_ok),   //1bit
    .probe3(dataout)    //8bit
);

always@(posedge clk) begin	
	
	case(tx_state)
	
		IDLE: begin
			j<=0;
			i<=0;
			txer<=1'b0;
			txen<=1'b0;
			crcen<=1'b0;
			crcre<=1'b1;
			dataout[7:0]<=8'h00;	
			alg_state<=8'd0;
			
			if(data_ok) begin
			
				case(eth_type)
					16'h0800:	begin
						case(IP4_type)
							ICMP: begin	
								alg_state<=8'd0;
								tx_state<=PREPARE_ICMP;
							end
							
							UDP: begin 
								//alg_state<=8'd0;
								//tx_state<=PREPARE_UDP; 
								alg_state<=8'd0;
                                tx_state<=8'h00; 
							end
							
							default: begin 
								alg_state<=8'd0;
								tx_state<=8'h00; 
							end
						endcase end
						
					16'h0806: begin 
						alg_state<=8'd0;
						tx_state<=PREPARE_ARP; 
					end
					
					default: begin tx_state<=IDLE; end
				endcase
			end			
		end
		
		PREPARE_ARP: 		begin //Prepare ARP
			i<=0;
			j<=0;
			igp_cnt<=8'd0;
			alg_state<=8'd0;
			
			arp_reply[0]<=sender_mac[47:40];	//Dest              
			arp_reply[1]<=sender_mac[39:32];
			arp_reply[2]<=sender_mac[31:24];
			arp_reply[3]<=sender_mac[23:16];
			arp_reply[4]<=sender_mac[15:8];
			arp_reply[5]<=sender_mac[7:0];	
			
			arp_reply[6]<=MAC1;					//Source
			arp_reply[7]<=MAC2;
			arp_reply[8]<=MAC3;
			arp_reply[9]<=MAC4;
			arp_reply[10]<=MAC5;
			arp_reply[11]<=MAC6;		
			
			arp_reply[12]<=eth_type[15:8]; 	//TYPE 
			arp_reply[13]<=eth_type[7:0];
			
			arp_reply[14]<=8'h00;//HType
			arp_reply[15]<=8'h01;
			arp_reply[16]<=8'h08;//IPv4
			arp_reply[17]<=8'h00;
			arp_reply[18]<=8'h06;//Hsz
			arp_reply[19]<=8'h04;//Psz
			
			arp_reply[20]<=8'h00;//OPcode 0x0002 reply
			arp_reply[21]<=8'h02;
			
			arp_reply[22]<=MAC1;	//My MAC             
			arp_reply[23]<=MAC2;
			arp_reply[24]<=MAC3;
			arp_reply[25]<=MAC4;
			arp_reply[26]<=MAC5;
			arp_reply[27]<=MAC6;
			
			arp_reply[28]<=IP1;	//My IP             
			arp_reply[29]<=IP2;
			arp_reply[30]<=IP3;
			arp_reply[31]<=IP4;
			
			arp_reply[32]<=sender_mac[47:40];	//Target MAC             
			arp_reply[33]<=sender_mac[39:32];
			arp_reply[34]<=sender_mac[31:24];
			arp_reply[35]<=sender_mac[23:16];
			arp_reply[36]<=sender_mac[15:8];
			arp_reply[37]<=sender_mac[7:0];	
			
			arp_reply[38]<=sender_ip[31:24];	//Target IP             
			arp_reply[39]<=sender_ip[23:16];
			arp_reply[40]<=sender_ip[15:8];
			arp_reply[41]<=sender_ip[7:0];
			
			arp_reply[42]<=8'd00; //padding
			arp_reply[43]<=8'd00;
			arp_reply[44]<=8'd00;
			arp_reply[45]<=8'd00;
			arp_reply[46]<=8'd00;
			arp_reply[47]<=8'd00;
			arp_reply[48]<=8'd00;
			arp_reply[49]<=8'd00;
			arp_reply[50]<=8'd00;
			arp_reply[51]<=8'd00;
			arp_reply[52]<=8'd00;
			arp_reply[53]<=8'd00;
			arp_reply[54]<=8'd00;
			arp_reply[55]<=8'd00;
			arp_reply[56]<=8'd00;
			arp_reply[57]<=8'd00;
			arp_reply[58]<=8'd00;
			arp_reply[59]<=8'd00;
			
			tx_state<=SEND_ARP;
		end
		
		SEND_ARP: 			begin //Send ARP
			case(alg_state)
				8'd0: begin	//send preambule
					//if( (e_rxdv==1'b0) && (igp_cnt==8'd12)) begin
						txen<=1'b1;
						crcre<=1'b1; //reset crc  
						if(i==7) begin
							dataout[7:0]<=preamble[i][7:0];
							i<=0;
							j<=0;
							alg_state<=8'd1;
						end
						else begin                        
							dataout[7:0]<=preamble[i][7:0];
							i<=i+1;
						end
					//end
					//else alg_state<=8'd0;
				end
				
				8'd1: begin	//send arp
					crcen<=1'b1; //crc checksum is enabled, crc32 data check starts from target MAC)	
					crcre<=1'b0;  
					if(i==59) begin
						dataout[7:0]<=arp_reply[i][7:0];
						i<=0;
						alg_state<=8'd2;		
					end
					else begin                        
						dataout[7:0]<=arp_reply[i][7:0];
						i<=i+1'b1;
					end
				end
				
				8'd2: begin	//send 32bit crc
					crcen<=1'b0;
					if(i==0)	begin
						  dataout[7:0] <= {~crc[24], ~crc[25], ~crc[26], ~crc[27], ~crc[28], ~crc[29], ~crc[30], ~crc[31]};
						  i<=i+1'b1;
					end
					else begin
					  if(i==1) begin
							dataout[7:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19], ~crc[20], ~crc[21], ~crc[22], ~crc[23]};
							i<=i+1'b1;
					  end
					  else if(i==2) begin
							dataout[7:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11], ~crc[12], ~crc[13], ~crc[14], ~crc[15]};
							i<=i+1'b1;
					  end
					  else if(i==3) begin
							dataout[7:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3], ~crc[4], ~crc[5], ~crc[6], ~crc[7]};
							i<=0;
							alg_state<=8'd0;
							tx_state<=IDLE;
					  end
					  else begin
							txer<=1'b1;
					  end
					end
				end
				
				default: alg_state<=8'd0;
			endcase	
		end
			
		PREPARE_ICMP: 		begin
			igp_cnt<=8'd0;
			case(alg_state)
				8'd0: begin //Prepare icmp
					eth_header[0]	<=sender_mac[47:40];	//Dest              
					eth_header[1]	<=sender_mac[39:32];
					eth_header[2]	<=sender_mac[31:24];
					eth_header[3]	<=sender_mac[23:16];
					eth_header[4]	<=sender_mac[15:8];
					eth_header[5]	<=sender_mac[7:0];	
					
					eth_header[6]	<=MAC1;					//Source
					eth_header[7]	<=MAC2;
					eth_header[8]	<=MAC3;
					eth_header[9]	<=MAC4;
					eth_header[10]	<=MAC5;
					eth_header[11]	<=MAC6;	
					
					eth_header[12]	<=eth_type[15:8]; 	//TYPE 
					eth_header[13]	<=eth_type[7:0];
					
					ip_header[0]		<={16'h4500, len_IPv4};        						//Version number: 4; Header length: 20; IP packet length
					ip_header[1][31:16]	<=ip_header[1][31:16]+1'b1;   						//Package serial number
					ip_header[1][15:0]	<=16'h0000;                    						//Fragment offset
					ip_header[2]			<=32'h40010000;                      				//mema[2][15:0] Protocol: 01(ICMP))
					ip_header[3]			<= {IP1, IP2, IP3, IP4};								//source address
					//ip_header[4]			<= {IP1_DEST, IP2_DEST, IP3_DEST, IP4_DEST};		//destination address broadcast address
					ip_header[4]			<= sender_ip;
					
					
					icmp_header[0]	<={8'h00,8'h00,8'h00,8'h00}; 									// TYPE:1 byte, CODE:1 byte, CHECKSUM:2 byte
					icmp_header[1]	<=ICMP_data[479:448];											// SN BE:2 byte, SN LE:2 byte		
					
					//DEBUG				<={ICMP_data[511:432],80'd0};
					
					
					icmp_header[2]	<=ICMP_data[447:416];	// TIMESTAMP:8 bytes
					icmp_header[3]	<=ICMP_data[415:384];	
					
					icmp_header[4]	<=ICMP_data[383:352];		// DATA:48 bytes
					icmp_header[5]	<=ICMP_data[351:320];
					icmp_header[6]	<=ICMP_data[319:288];
					icmp_header[7]	<=ICMP_data[287:256];
					icmp_header[8]	<=ICMP_data[255:224];
					icmp_header[9]	<=ICMP_data[223:192];
					icmp_header[10]<=ICMP_data[191:160];
					icmp_header[11]<=ICMP_data[159:128];
					icmp_header[12]<=ICMP_data[127:96];
					icmp_header[13]<=ICMP_data[95:64];
					icmp_header[14]<=ICMP_data[63:32];
					icmp_header[15]<=ICMP_data[31:0];

					i<=0;
					j<=0;
					alg_state<=8'd1;
				end
				
				8'd1: begin //Generate crc for IPv4
					if(i==0) begin
						check_buffer<=ip_header[0][15:0]+ip_header[0][31:16]+ip_header[1][15:0]+ip_header[1][31:16]+ip_header[2][15:0]+
						ip_header[2][31:16]+ip_header[3][15:0]+ip_header[3][31:16]+ip_header[4][15:0]+ip_header[4][31:16];
						i<=i+1'b1;
					end
					else if(i==1) begin
						check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
						i<=i+1'b1;
					end
					else begin
						ip_header[2][15:0]<=~check_buffer[15:0];
						i<=0;
						j<=0;
						alg_state<=8'd2;
					end
				end
				
				8'd2: begin	//Generate CRC ICMP
					if(i==0) begin
						check_buffer<=		icmp_header[0][15:0]		+icmp_header[0][31:16]	+icmp_header[1][15:0]	+icmp_header[1][31:16]	+icmp_header[2][15:0]	+
												icmp_header[2][31:16]	+icmp_header[3][15:0]	+icmp_header[3][31:16]	+icmp_header[4][15:0]	+icmp_header[4][31:16]	+
												icmp_header[5][15:0]		+icmp_header[5][31:16]	+icmp_header[6][15:0]	+icmp_header[6][31:16]	+icmp_header[7][15:0]	+
												icmp_header[7][31:16]	+icmp_header[8][15:0]	+icmp_header[8][31:16]	+icmp_header[9][15:0]	+icmp_header[9][31:16]  +
												icmp_header[10][15:0]	+icmp_header[10][31:16]	+icmp_header[11][15:0]	+icmp_header[11][31:16]	+icmp_header[12][15:0]	+
												icmp_header[12][31:16]	+icmp_header[13][15:0]	+icmp_header[13][31:16]	+icmp_header[14][15:0]	+icmp_header[14][31:16]	+
												icmp_header[15][15:0]	+icmp_header[15][31:16];	
						i<=i+1'b1;
					end
					else if(i==1) begin
						check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
						i<=i+1'b1;
					end
					else begin
						icmp_header[0][15:0]<=~check_buffer[15:0];
						i<=0;
						j<=0;
						alg_state<=8'd0;
						tx_state<=SEND_ICMP;
					end
				end
				
				default: alg_state<=8'd0;
			endcase	
		end
		
		SEND_ICMP: 			begin
			case(alg_state)
				8'd0: begin	//send preambule
						txen<=1'b1;
						crcre<=1'b1; //reset crc  
						if(i==7) begin
							dataout[7:0]<=preamble[i][7:0];
							i<=0;
							j<=0;
							alg_state<=8'd1;
						end
						else begin                        
							dataout[7:0]<=preamble[i][7:0];
							i<=i+1;
						end
				end
				
				8'd1: begin //send eth
					crcen<=1'b1;   //crc checksum is enabled, crc32 data check starts from target MAC)	
					crcre<=1'b0; 	
					if(i==13) begin
						dataout[7:0]<=eth_header[i][7:0];
						i<=0;
						alg_state<=8'd2;
					end
					else begin                        
						dataout[7:0]<=eth_header[i][7:0];
						i<=i+1'b1;
					end
				end
				
				8'd2: begin	//send ip4 header
					if(j==4) begin                            
						if(i==0) begin
							dataout[7:0]<=ip_header[j][31:24];
							i<=i+1'b1;
						end
						else if(i==1) begin
							dataout[7:0]<=ip_header[j][23:16];
							i<=i+1'b1;
						end
						else if(i==2) begin
							dataout[7:0]<=ip_header[j][15:8];
							i<=i+1'b1;
						end
						else if(i==3) begin
							dataout[7:0]<=ip_header[j][7:0];
							i<=0;
							j<=0;
							alg_state<=8'd3;			 
						end
						else
							txer<=1'b1;
					end	
					
					else begin
						if(i==0) begin
							dataout[7:0]<=ip_header[j][31:24];
							i<=i+1'b1;
						end
						else if(i==1) begin
							dataout[7:0]<=ip_header[j][23:16];
							i<=i+1'b1;
						end
						else if(i==2) begin
							dataout[7:0]<=ip_header[j][15:8];
							i<=i+1'b1;
						end
						else if(i==3) begin
							dataout[7:0]<=ip_header[j][7:0];
							i<=0;
							j<=j+1'b1;
						end					
						else
							txer<=1'b1;
					end
				end
				
				8'd3: begin	//send icmp
					if(j==15) begin                            
						if(i==0) begin
							dataout[7:0]<=icmp_header[j][31:24];
							i<=i+1'b1;
						end
						else if(i==1) begin
							dataout[7:0]<=icmp_header[j][23:16];
							i<=i+1'b1;
						end
						else if(i==2) begin
							dataout[7:0]<=icmp_header[j][15:8];
							i<=i+1'b1;
						end
						else if(i==3) begin
							dataout[7:0]<=icmp_header[j][7:0];
							i<=0;
							j<=0;
							alg_state<=8'd4;		 
						end
						else
							txer<=1'b1;
					end	
					
					else begin
						if(i==0) begin
							dataout[7:0]<=icmp_header[j][31:24];
							i<=i+1'b1;
						end
						else if(i==1) begin
							dataout[7:0]<=icmp_header[j][23:16];
							i<=i+1'b1;
						end
						else if(i==2) begin
							dataout[7:0]<=icmp_header[j][15:8];
							i<=i+1'b1;
						end
						else if(i==3) begin
							dataout[7:0]<=icmp_header[j][7:0];
							i<=0;
							j<=j+1'b1;
						end					
						else
							txer<=1'b1;
					end
				end
				
				8'd4: begin //send 32bit crc
					crcen<=1'b0;
					if(i==0)	begin
						  dataout[7:0] <= {~crc[24], ~crc[25], ~crc[26], ~crc[27], ~crc[28], ~crc[29], ~crc[30], ~crc[31]};
						  i<=i+1'b1;
					end
					else begin
					  if(i==1) begin
							dataout[7:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19], ~crc[20], ~crc[21], ~crc[22], ~crc[23]};
							i<=i+1'b1;
					  end
					  else if(i==2) begin
							dataout[7:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11], ~crc[12], ~crc[13], ~crc[14], ~crc[15]};
							i<=i+1'b1;
					  end
					  else if(i==3) begin
							dataout[7:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3], ~crc[4], ~crc[5], ~crc[6], ~crc[7]};
							i<=0;
							alg_state<=8'd0;
							tx_state<=IDLE;
					  end
					  else begin
							txer<=1'b1;
					  end
					end
				end
				
				default: alg_state<=8'd0;
			endcase		
		end
		
		PREPARE_UDP:		begin	
			case(alg_state)
				8'd0: begin //Prepare udp
					eth_header[0]	<=eth_src[47:40];	//Dest              
					eth_header[1]	<=eth_src[39:32];
					eth_header[2]	<=eth_src[31:24];
					eth_header[3]	<=eth_src[23:16];
					eth_header[4]	<=eth_src[15:8];
					eth_header[5]	<=eth_src[7:0];	
					
					eth_header[6]	<=MAC1;					//Source
					eth_header[7]	<=MAC2;
					eth_header[8]	<=MAC3;
					eth_header[9]	<=MAC4;
					eth_header[10]	<=MAC5;
					eth_header[11]	<=MAC6;	
					
					eth_header[12]	<=eth_type[15:8]; 	//TYPE 
					eth_header[13]	<=eth_type[7:0];
					
					//ip_header[0]		<={16'h4500, 16'd20 + UDP_DATA_LEN};     //Version number: 4; Header length: 20; IP packet length
					ip_header[0]		<={16'h4500, 16'd20 + 16'd70};        	         //Version number: 4; Header length: 20; IP packet length
					ip_header[1][31:16]	<=ip_header[1][31:16]+1'b1;   			         //Package serial number
					ip_header[1][15:0]	<=16'h0000;                    			         //Fragment offset
					ip_header[2]		<=32'h40110000;                      	         //mema[2][15:0] Protocol: 17(UDP)) crc
					ip_header[3]		<={IP1, IP2, IP3, IP4};					         //source address
					//ip_header[4]		<={8'd192, 8'd168, 8'd2, 8'd10};
					ip_header[4]		<=sender_ip;
					
                    ip_header[5]<={UDP_SP, UDP_DP};                              //2 bytes of source port number and 2 bytes of destination port number
					ip_header[6]<={16'd70, 16'h0000};                            //2 bytes of data length and 2 bytes of checksum (none)
					//ip_header[5]<={16'd48000,16'd48000};                      //2 bytes of source port number and 2 bytes of destination port number
                    //ip_header[6]<={16'd70,   16'h0000};                       //2 bytes of data length and 2 bytes of checksum (none)
					
					/*udp_discovery[0]<=8'hEF;
					udp_discovery[1]<=8'hFE;
					udp_discovery[2]<=8'h02;			
					udp_discovery[3]<=MAC1;
					udp_discovery[4]<=MAC2;
					udp_discovery[5]<=MAC3;
					udp_discovery[6]<=MAC4;
					udp_discovery[7]<=MAC5;
					udp_discovery[8]<=MAC6;*/
					
					udp_discovery[0] <=UDP_SP[15:8];
					udp_discovery[1] <=UDP_SP[7:0];
					udp_discovery[2] <=UDP_DP[15:8];
					udp_discovery[3] <=UDP_DP[7:0];
					udp_discovery[4] <=UDP_DATA_LEN[15:8];
					udp_discovery[5] <=UDP_DATA_LEN[7:0];

					i<=0;
					j<=0;
					alg_state<=8'd1;
				end
				
				8'd1: begin	//Generate crc for IPv4
					if(i==0) begin
						check_buffer<=ip_header[0][15:0]+ip_header[0][31:16]+ip_header[1][15:0]+ip_header[1][31:16]+ip_header[2][15:0]+
						ip_header[2][31:16]+ip_header[3][15:0]+ip_header[3][31:16]+ip_header[4][15:0]+ip_header[4][31:16];
						//ip_header[5][15:0]+ip_header[5][31:16]+ip_header[6][15:0]+ip_header[6][31:16];
						i<=i+1'b1;
					end
					else if(i==1) begin
						check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
						i<=i+1'b1;
					end
					else begin
						ip_header[2][15:0]<=~check_buffer[15:0];
						i<=0;
						j<=0;
						alg_state<=8'd0;
						tx_state<=SEND_UDP;
					end
				end
				
				8'd2: begin
					if(igp_cnt<12)begin
						igp_cnt<=igp_cnt+1'b1;
					end
					else begin
						igp_cnt<=8'd0;
						tx_state<=SEND_UDP;
					end
				end
				
				default: alg_state<=8'd0;
			endcase	
		end
		
		SEND_UDP:			begin 
			case(alg_state)
				8'd0: begin	//send preambule
					txen<=1'b1;
					crcre<=1'b1; //reset crc  
					if(i==7) begin
						dataout[7:0]<=preamble[i][7:0];
						i<=0;
						j<=0;
						alg_state<=8'd1;
					end
					else begin                        
						dataout[7:0]<=preamble[i][7:0];
						i<=i+1;
					end
				end
				
				8'd1: begin //send eth
					crcen<=1'b1;   //crc checksum is enabled, crc32 data check starts from target MAC)	
					crcre<=1'b0; 	
					if(i==13) begin
						dataout[7:0]<=eth_header[i][7:0];
						i<=0;
						alg_state<=8'd2;
					end
					else begin                        
						dataout[7:0]<=eth_header[i][7:0];
						i<=i+1'b1;
					end
				end
				
				8'd2: begin	//send ip4 header
					if(j==6) begin                            
						if(i==0) begin
							dataout[7:0]<=ip_header[j][31:24];
							i<=i+1'b1;
						end
						else if(i==1) begin
							dataout[7:0]<=ip_header[j][23:16];
							i<=i+1'b1;
						end
						else if(i==2) begin
							dataout[7:0]<=ip_header[j][15:8];
							i<=i+1'b1;
						end
						else if(i==3) begin
							dataout[7:0]<=ip_header[j][7:0];
							i<=0;
							j<=0;
							alg_state<=8'd3;			 
						end
						else
							txer<=1'b1;
					end	
					
					else begin
						if(i==0) begin
							dataout[7:0]<=ip_header[j][31:24];
							i<=i+1'b1;
						end
						else if(i==1) begin
							dataout[7:0]<=ip_header[j][23:16];
							i<=i+1'b1;
						end
						else if(i==2) begin
							dataout[7:0]<=ip_header[j][15:8];
							i<=i+1'b1;
						end
						else if(i==3) begin
							dataout[7:0]<=ip_header[j][7:0];
							i<=0;
							j<=j+1'b1;
						end					
						else
							txer<=1'b1;
					end
				end
				
				8'd3: begin	//send udp
					crcen<=1'b1; //crc checksum is enabled, crc32 data check starts from target MAC)	
					crcre<=1'b0;  
					if(i==62) begin
						dataout[7:0]<=udp_discovery[i][7:0];
						i<=0;
						alg_state<=8'd4;		
					end
					else begin                        
						dataout[7:0]<=udp_discovery[i][7:0];
						i<=i+1'b1;
					end
				end
				
				8'd4: begin //send 32bit crc
					crcen<=1'b0;
					if(i==0)	begin
						  dataout[7:0] <= {~crc[24], ~crc[25], ~crc[26], ~crc[27], ~crc[28], ~crc[29], ~crc[30], ~crc[31]};
						  i<=i+1'b1;
					end
					else begin
					  if(i==1) begin
							dataout[7:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19], ~crc[20], ~crc[21], ~crc[22], ~crc[23]};
							i<=i+1'b1;
					  end
					  else if(i==2) begin
							dataout[7:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11], ~crc[12], ~crc[13], ~crc[14], ~crc[15]};
							i<=i+1'b1;
					  end
					  else if(i==3) begin
							dataout[7:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3], ~crc[4], ~crc[5], ~crc[6], ~crc[7]};
							i<=0;
							alg_state<=8'd0;
							//cnt_time<=32'd0;
							//tx_state<=DELAY;
							tx_state<=IDLE;
					  end
					  else begin
							txer<=1'b1;
					  end
					end
				end
				
				default: alg_state<=8'd0;
			endcase	
		end
		
		
		/*DELAY: begin
			j<=0;
			i<=0;
			txer<=1'b0;
			txen<=1'b0;
			crcen<=1'b0;
			crcre<=1'b1;
			dataout[7:0]<=8'h00;	
			
			
			if(cnt_time <= 32'd125000000) begin
				cnt_time<=cnt_time+1'b1;
			end
			else begin
				//tx_state<=SEND_UDP;
				cnt_time<=32'd0;
				alg_state<=8'd0;
				//tx_state<=PREPARE_UDP; 
				led1<=~led1;
			end
		end*/
	

		default: tx_state<=8'h00;	
	endcase
	
end
endmodule
	

		
		
		
		/*
		start:begin //IP header
					ip_header[0]<={16'h4500,tx_total_length};        				//Version number: 4; Header length: 20; IP packet length
				   ip_header[1][31:16]<=ip_header[1][31:16]+1'b1;   				// Package serial number
					ip_header[1][15:0]<=16'h4000;                    				//Fragment offset
				   ip_header[2]<=32'h80110000;                      				//mema[2][15:0] Protocol: 17(UDP))

					ip_header[3]<= {IP1, IP2, IP3, IP4};								//192.168.0.2 source address
					ip_header[4]<= {IP1_DEST, IP2_DEST, IP3_DEST, IP4_DEST};		//192.168.0.3 destination address broadcast address
					
					ip_header[5]<=32'h1f901f90;                      				//2 bytes of source port number and 2 bytes of destination port number
				   ip_header[6]<={tx_data_length,16'h0000};         				//2 bytes of data length and 2 bytes of checksum (none)
	   			tx_state<=make;
         end	
			
         make:begin            // Generate a checksum for the header
			    if(i==0) begin
					  check_buffer<=ip_header[0][15:0]+ip_header[0][31:16]+ip_header[1][15:0]+ip_header[1][31:16]+ip_header[2][15:0]+
					               ip_header[2][31:16]+ip_header[3][15:0]+ip_header[3][31:16]+ip_header[4][15:0]+ip_header[4][31:16];
                 i<=i+1'b1;
				   end
             else if(i==1) begin
					   check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
					   i<=i+1'b1;
				 end
			    else	begin
				      ip_header[2][15:0]<=~check_buffer[15:0];                 //header checksum
					   i<=0;
					   tx_state<=send55;
					end
		   end
			
			send55: begin                                      
 				 txen<=1'b1;                             //GMII���ݷ�����Ч
				 crcre<=1'b1;                            //reset crc  
				 if(i==7) begin
               dataout[7:0]<=preamble[i][7:0];
					i<=0;
				   tx_state<=sendmac;
				 end
				 else begin                        
				    dataout[7:0]<=preamble[i][7:0];
				    i<=i+1;
				 end
			end	
			
			sendmac: begin                           //����Ŀ��MAC address��ԴMAC address��IP������  
			 	 crcen<=1'b1;                         //crc checksum is enabled, crc32 data check starts from target MAC)	
				 crcre<=1'b0;                            			
             if(i==13) begin
               dataout[7:0]<=mac_addr[i][7:0];
					i<=0;
				   tx_state<=sendheader;
				 end
				 else begin                        
				    dataout[7:0]<=mac_addr[i][7:0];
				    i<=i+1'b1;
				 end
			end
			
			sendheader: begin                        //����7��32bit��IP ��ͷ
				datain_reg<=datain;                   //׼����Ҫ���͵�����	
			   if(j==6) begin                            
					  if(i==0) begin
						 dataout[7:0]<=ip_header[j][31:24];
						 i<=i+1'b1;
					  end
					  else if(i==1) begin
						 dataout[7:0]<=ip_header[j][23:16];
						 i<=i+1'b1;
					  end
					  else if(i==2) begin
						 dataout[7:0]<=ip_header[j][15:8];
						 i<=i+1'b1;
					  end
					  else if(i==3) begin
						 dataout[7:0]<=ip_header[j][7:0];
						 i<=0;
						 j<=0;
						 tx_state<=senddata;			 
					  end
					  else
						 txer<=1'b1;
				end		 
				else begin
					  if(i==0) begin
						 dataout[7:0]<=ip_header[j][31:24];
						 i<=i+1'b1;
					  end
					  else if(i==1) begin
						 dataout[7:0]<=ip_header[j][23:16];
						 i<=i+1'b1;
					  end
					  else if(i==2) begin
						 dataout[7:0]<=ip_header[j][15:8];
						 i<=i+1'b1;
					  end
					  else if(i==3) begin
						 dataout[7:0]<=ip_header[j][7:0];
						 i<=0;
						 j<=j+1'b1;
					  end					
					  else
						 txer<=1'b1;
				end
			 end
			 
			 senddata:begin                                      //����UDP���ݰ�
			   if(tx_data_counter==tx_data_length-9) begin       //��������������
				   tx_state<=sendcrc;	
					if(i==0) begin    
					  dataout[7:0]<=datain_reg[31:24];
					  i<=0;
					end
					else if(i==1) begin
					  dataout[7:0]<=datain_reg[23:16];
					  i<=0;
					end
					else if(i==2) begin
					  dataout[7:0]<=datain_reg[15:8];
					  i<=0;
					end
					else if(i==3) begin
			        dataout[7:0]<=datain_reg[7:0];
					  datain_reg<=datain;                       //׼������
					  i<=0;
					end
            end
            else begin                                     //�������������ݰ�
               tx_data_counter<=tx_data_counter+1'b1;			
					if(i==0) begin    
					  dataout[7:0]<=datain_reg[31:24];
					  i<=i+1'b1;
					  ram_rd_addr<=ram_rd_addr+1'b1;           //RAM��ַ��1, ��ǰ��RAM��������	
					end
					else if(i==1) begin
					  dataout[7:0]<=datain_reg[23:16];
					  i<=i+1'b1;
					end
					else if(i==2) begin
					  dataout[7:0]<=datain_reg[15:8];
					  i<=i+1'b1;
					end
					else if(i==3) begin
			        dataout[7:0]<=datain_reg[7:0];
					  datain_reg<=datain;                       //׼������					  
					  i<=0; 				  
					end
				end
			end	
			
			sendcrc: begin                              //����32λ��crcУ��
				crcen<=1'b0;
				if(i==0)	begin
					  dataout[7:0] <= {~crc[24], ~crc[25], ~crc[26], ~crc[27], ~crc[28], ~crc[29], ~crc[30], ~crc[31]};
					  i<=i+1'b1;
					end
				else begin
				  if(i==1) begin
					   dataout[7:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19], ~crc[20], ~crc[21], ~crc[22], ~crc[23]};
						i<=i+1'b1;
				  end
				  else if(i==2) begin
					   dataout[7:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11], ~crc[12], ~crc[13], ~crc[14], ~crc[15]};
						i<=i+1'b1;
				  end
				  else if(i==3) begin
					   dataout[7:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3], ~crc[4], ~crc[5], ~crc[6], ~crc[7]};
						i<=0;
						tx_state<=idle;
				  end
				  else begin
                  txer<=1'b1;
				  end
				end
			end		*/
		
	
	
	
		/*	

		PREPARE_ICMP: 		begin //Prepare ICMP
			eth_header[0]	<=sender_mac[47:40];	//Dest              
			eth_header[1]	<=sender_mac[39:32];
			eth_header[2]	<=sender_mac[31:24];
			eth_header[3]	<=sender_mac[23:16];
			eth_header[4]	<=sender_mac[15:8];
			eth_header[5]	<=sender_mac[7:0];	
			
			eth_header[6]	<=MAC1;					//Source
			eth_header[7]	<=MAC2;
			eth_header[8]	<=MAC3;
			eth_header[9]	<=MAC4;
			eth_header[10]	<=MAC5;
			eth_header[11]	<=MAC6;	
			
			eth_header[12]	<=eth_type[15:8]; 	//TYPE 
			eth_header[13]	<=eth_type[7:0];
			
			ip_header[0]			<={16'h4500, len_IPv4};        						//Version number: 4; Header length: 20; IP packet length
			ip_header[1][31:16]	<=ip_header[1][31:16]+1'b1;   						//Package serial number
			ip_header[1][15:0]	<=16'h0000;                    						//Fragment offset
			ip_header[2]			<=32'h40010000;                      				//mema[2][15:0] Protocol: 01(ICMP))
			ip_header[3]			<= {IP1, IP2, IP3, IP4};								//source address
			//ip_header[4]			<= {IP1_DEST, IP2_DEST, IP3_DEST, IP4_DEST};		//destination address broadcast address
			ip_header[4]			<= sender_ip;
			
			
			icmp_header[0]	<={8'h00,8'h00,8'h00,8'h00}; 									// TYPE:1 byte, CODE:1 byte, CHECKSUM:2 byte
			icmp_header[1]	<=ICMP_data[479:448];											// SN BE:2 byte, SN LE:2 byte		
			
			//DEBUG				<={ICMP_data[511:432],80'd0};
			
			
			icmp_header[2]	<=ICMP_data[447:416];	// TIMESTAMP:8 bytes
			icmp_header[3]	<=ICMP_data[415:384];	
			
			icmp_header[4]	<=ICMP_data[383:352];		// DATA:48 bytes
			icmp_header[5]	<=ICMP_data[351:320];
			icmp_header[6]	<=ICMP_data[319:288];
			icmp_header[7]	<=ICMP_data[287:256];
			icmp_header[8]	<=ICMP_data[255:224];
			icmp_header[9]	<=ICMP_data[223:192];
			icmp_header[10]<=ICMP_data[191:160];
			icmp_header[11]<=ICMP_data[159:128];
			icmp_header[12]<=ICMP_data[127:96];
			icmp_header[13]<=ICMP_data[95:64];
			icmp_header[14]<=ICMP_data[63:32];
			icmp_header[15]<=ICMP_data[31:0];
			
			tx_state<=CRC_IPv4;
			i<=0;
			j<=0;
		end*/
		
		/*CRC_IPv4: 			begin //Generate crc for IPv4
			if(i==0) begin
				check_buffer<=ip_header[0][15:0]+ip_header[0][31:16]+ip_header[1][15:0]+ip_header[1][31:16]+ip_header[2][15:0]+
				ip_header[2][31:16]+ip_header[3][15:0]+ip_header[3][31:16]+ip_header[4][15:0]+ip_header[4][31:16];
				i<=i+1'b1;
			end
			else if(i==1) begin
				check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
				i<=i+1'b1;
			end
			else begin
				ip_header[2][15:0]<=~check_buffer[15:0];
				i<=0;
				j<=0;
				tx_state<=CRC_ICMP;
			end
		end*/
		
		/*CRC_ICMP: 			begin //Generate CRC ICMP
			if(i==0) begin
				check_buffer<=		icmp_header[0][15:0]		+icmp_header[0][31:16]	+icmp_header[1][15:0]	+icmp_header[1][31:16]	+icmp_header[2][15:0]	+
										icmp_header[2][31:16]	+icmp_header[3][15:0]	+icmp_header[3][31:16]	+icmp_header[4][15:0]	+icmp_header[4][31:16]	+
										icmp_header[5][15:0]		+icmp_header[5][31:16]	+icmp_header[6][15:0]	+icmp_header[6][31:16]	+icmp_header[7][15:0]	+
										icmp_header[7][31:16]	+icmp_header[8][15:0]	+icmp_header[8][31:16]	+icmp_header[9][15:0]	+icmp_header[9][31:16]  +
										icmp_header[10][15:0]	+icmp_header[10][31:16]	+icmp_header[11][15:0]	+icmp_header[11][31:16]	+icmp_header[12][15:0]	+
										icmp_header[12][31:16]	+icmp_header[13][15:0]	+icmp_header[13][31:16]	+icmp_header[14][15:0]	+icmp_header[14][31:16]	+
										icmp_header[15][15:0]	+icmp_header[15][31:16];	
				i<=i+1'b1;
			end
			else if(i==1) begin
				check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
				i<=i+1'b1;
			end
			else begin
				icmp_header[0][15:0]<=~check_buffer[15:0];
				i<=0;
				j<=0;
				tx_state<SEND_PREAMBULE;
			end
		end*/
		
	
	
		/*
		PREPARE_ARP: 		begin //Prepare ARP
			arp_reply[0]<=sender_mac[47:40];	//Dest              
			arp_reply[1]<=sender_mac[39:32];
			arp_reply[2]<=sender_mac[31:24];
			arp_reply[3]<=sender_mac[23:16];
			arp_reply[4]<=sender_mac[15:8];
			arp_reply[5]<=sender_mac[7:0];	
			
			arp_reply[6]<=MAC1;					//Source
			arp_reply[7]<=MAC2;
			arp_reply[8]<=MAC3;
			arp_reply[9]<=MAC4;
			arp_reply[10]<=MAC5;
			arp_reply[11]<=MAC6;		
			
			arp_reply[12]<=eth_type[15:8]; 	//TYPE 
			arp_reply[13]<=eth_type[7:0];
			
			arp_reply[14]<=8'h00;//HType
			arp_reply[15]<=8'h01;
			arp_reply[16]<=8'h08;//IPv4
			arp_reply[17]<=8'h00;
			arp_reply[18]<=8'h06;//Hsz
			arp_reply[19]<=8'h04;//Psz
			
			arp_reply[20]<=8'h00;//OPcode 0x0002 reply
			arp_reply[21]<=8'h02;
			
			arp_reply[22]<=MAC1;	//My MAC             
			arp_reply[23]<=MAC2;
			arp_reply[24]<=MAC3;
			arp_reply[25]<=MAC4;
			arp_reply[26]<=MAC5;
			arp_reply[27]<=MAC6;
			
			arp_reply[28]<=IP1;	//My IP             
			arp_reply[29]<=IP2;
			arp_reply[30]<=IP3;
			arp_reply[31]<=IP4;
			
			arp_reply[32]<=sender_mac[47:40];	//Target MAC             
			arp_reply[33]<=sender_mac[39:32];
			arp_reply[34]<=sender_mac[31:24];
			arp_reply[35]<=sender_mac[23:16];
			arp_reply[36]<=sender_mac[15:8];
			arp_reply[37]<=sender_mac[7:0];	
			
			arp_reply[38]<=sender_ip[31:24];	//Target IP             
			arp_reply[39]<=sender_ip[23:16];
			arp_reply[40]<=sender_ip[15:8];
			arp_reply[41]<=sender_ip[7:0];
			
			arp_reply[42]<=8'd00; //padding
			arp_reply[43]<=8'd00;
			arp_reply[44]<=8'd00;
			arp_reply[45]<=8'd00;
			arp_reply[46]<=8'd00;
			arp_reply[47]<=8'd00;
			arp_reply[48]<=8'd00;
			arp_reply[49]<=8'd00;
			arp_reply[50]<=8'd00;
			arp_reply[51]<=8'd00;
			arp_reply[52]<=8'd00;
			arp_reply[53]<=8'd00;
			arp_reply[54]<=8'd00;
			arp_reply[55]<=8'd00;
			arp_reply[56]<=8'd00;
			arp_reply[57]<=8'd00;
			arp_reply[58]<=8'd00;
			arp_reply[59]<=8'd00;
			
			tx_state<=SEND_PREAMBULE;
			i<=0;
			j<=0;
		end
		
		SEND_PREAMBULE: 	begin //Send PREAMBULE
			txen<=1'b1;
			crcre<=1'b1; //reset crc  
			if(i==7) begin
				dataout[7:0]<=preamble[i][7:0];
				i<=0;
				j<=0;
				case(type_tx)
					tx_ARP: 	tx_state<=SEND_ARP; 
					tx_ICMP: tx_state<=SEND_ICMP;
					tx_UDP: 	tx_state<=SEND_UDP;
					default: tx_state<=IDLE;
				endcase
			end
			else begin                        
				dataout[7:0]<=preamble[i][7:0];
				i<=i+1;
			end
		end
				
		SEND_ARP: 			begin //Send ARP
			crcen<=1'b1; //crc checksum is enabled, crc32 data check starts from target MAC)	
			crcre<=1'b0;  
			if(i==59) begin
				dataout[7:0]<=arp_reply[i][7:0];
				i<=0;
				tx_state<=SEND_32CRC;		
			end
			else begin                        
				dataout[7:0]<=arp_reply[i][7:0];
				i<=i+1'b1;
			end
		end
		
		SEND_32CRC: 		begin //Send 32-bit crc checksum
				crcen<=1'b0;
				if(i==0)	begin
					  dataout[7:0] <= {~crc[24], ~crc[25], ~crc[26], ~crc[27], ~crc[28], ~crc[29], ~crc[30], ~crc[31]};
					  i<=i+1'b1;
				end
				else begin
				  if(i==1) begin
					   dataout[7:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19], ~crc[20], ~crc[21], ~crc[22], ~crc[23]};
						i<=i+1'b1;
				  end
				  else if(i==2) begin
					   dataout[7:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11], ~crc[12], ~crc[13], ~crc[14], ~crc[15]};
						i<=i+1'b1;
				  end
				  else if(i==3) begin
					   dataout[7:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3], ~crc[4], ~crc[5], ~crc[6], ~crc[7]};
						i<=0;
						tx_state<=8'h00;
				  end
				  else begin
                  txer<=1'b1;
				  end
				end
			end*/
		
/*
		SEND_ETH: 			begin //Send ETH
			crcen<=1'b1;   //crc checksum is enabled, crc32 data check starts from target MAC)	
			crcre<=1'b0; 
			
			if(i==13) begin
				dataout[7:0]<=eth_header[i][7:0];
				i<=0;
				tx_state<=8'h0C;	
			end
			else begin                        
				dataout[7:0]<=eth_header[i][7:0];
				i<=i+1'b1;
			end
		end
		
		SEND_IPv4: 			begin //Send IPv4 Header
			if(j==4) begin                            
				if(i==0) begin
					dataout[7:0]<=ip_header[j][31:24];
					i<=i+1'b1;
				end
				else if(i==1) begin
					dataout[7:0]<=ip_header[j][23:16];
					i<=i+1'b1;
				end
				else if(i==2) begin
					dataout[7:0]<=ip_header[j][15:8];
					i<=i+1'b1;
				end
				else if(i==3) begin
					dataout[7:0]<=ip_header[j][7:0];
					i<=0;
					j<=0;
					tx_state<=8'h0F;			 
				end
				else
					txer<=1'b1;
			end	
			
			else begin
				if(i==0) begin
					dataout[7:0]<=ip_header[j][31:24];
					i<=i+1'b1;
				end
				else if(i==1) begin
					dataout[7:0]<=ip_header[j][23:16];
					i<=i+1'b1;
				end
				else if(i==2) begin
					dataout[7:0]<=ip_header[j][15:8];
					i<=i+1'b1;
				end
				else if(i==3) begin
					dataout[7:0]<=ip_header[j][7:0];
					i<=0;
					j<=j+1'b1;
				end					
				else
					txer<=1'b1;
			end
		end
		
		SEND_ICMP: 			begin //Send ICMP
			if(j==15) begin                            
				if(i==0) begin
					dataout[7:0]<=icmp_header[j][31:24];
					i<=i+1'b1;
				end
				else if(i==1) begin
					dataout[7:0]<=icmp_header[j][23:16];
					i<=i+1'b1;
				end
				else if(i==2) begin
					dataout[7:0]<=icmp_header[j][15:8];
					i<=i+1'b1;
				end
				else if(i==3) begin
					dataout[7:0]<=icmp_header[j][7:0];
					i<=0;
					j<=0;
					tx_state<=SEND_32CRC;		 
				end
				else
					txer<=1'b1;
			end	
			
			else begin
				if(i==0) begin
					dataout[7:0]<=icmp_header[j][31:24];
					i<=i+1'b1;
				end
				else if(i==1) begin
					dataout[7:0]<=icmp_header[j][23:16];
					i<=i+1'b1;
				end
				else if(i==2) begin
					dataout[7:0]<=icmp_header[j][15:8];
					i<=i+1'b1;
				end
				else if(i==3) begin
					dataout[7:0]<=icmp_header[j][7:0];
					i<=0;
					j<=j+1'b1;
				end					
				else
					txer<=1'b1;
			end
		end*/	
	
	
	
	
	
	
	
	
	
		
		/*case(tx_state)
		  idle:begin
				 txer<=1'b0;
				 txen<=1'b0;
				 crcen<=1'b0;
				 crcre<=1;
				 j<=0;
				 dataout<=0;
				 ram_rd_addr<=1;
				 tx_data_counter<=0;
				 
             //if (time_counter==32'h00000110) begin   //800 Mbits
				 if (time_counter==32'h04000000) begin     
				     tx_state<=start;  
                 time_counter<=0;
             end
             else
                 time_counter<=time_counter+1'b1;
					  
			end
			
		   start:begin //IP header
					ip_header[0]<={16'h4500,tx_total_length};        				//Version number: 4; Header length: 20; IP packet length
				   ip_header[1][31:16]<=ip_header[1][31:16]+1'b1;   				// Package serial number
					ip_header[1][15:0]<=16'h4000;                    				//Fragment offset
				   ip_header[2]<=32'h80110000;                      				//mema[2][15:0] Protocol: 17(UDP))

					ip_header[3]<= {IP1, IP2, IP3, IP4};								//192.168.0.2 source address
					ip_header[4]<= {IP1_DEST, IP2_DEST, IP3_DEST, IP4_DEST};		//192.168.0.3 destination address broadcast address
					
					ip_header[5]<=32'h1f901f90;                      				//2 bytes of source port number and 2 bytes of destination port number
				   ip_header[6]<={tx_data_length,16'h0000};         				//2 bytes of data length and 2 bytes of checksum (none)
	   			tx_state<=make;
         end	
			
         make:begin            // Generate a checksum for the header
			    if(i==0) begin
					  check_buffer<=ip_header[0][15:0]+ip_header[0][31:16]+ip_header[1][15:0]+ip_header[1][31:16]+ip_header[2][15:0]+
					               ip_header[2][31:16]+ip_header[3][15:0]+ip_header[3][31:16]+ip_header[4][15:0]+ip_header[4][31:16];
                 i<=i+1'b1;
				   end
             else if(i==1) begin
					   check_buffer[15:0]<=check_buffer[31:16]+check_buffer[15:0];
					   i<=i+1'b1;
				 end
			    else	begin
				      ip_header[2][15:0]<=~check_buffer[15:0];                 //header checksum
					   i<=0;
					   tx_state<=send55;
					end
		   end
			
			send55: begin                                      
 				 txen<=1'b1;                             //GMII���ݷ�����Ч
				 crcre<=1'b1;                            //reset crc  
				 if(i==7) begin
               dataout[7:0]<=preamble[i][7:0];
					i<=0;
				   tx_state<=sendmac;
				 end
				 else begin                        
				    dataout[7:0]<=preamble[i][7:0];
				    i<=i+1;
				 end
			end	
			
			sendmac: begin                           //����Ŀ��MAC address��ԴMAC address��IP������  
			 	 crcen<=1'b1;                         //crc checksum is enabled, crc32 data check starts from target MAC)	
				 crcre<=1'b0;                            			
             if(i==13) begin
               dataout[7:0]<=mac_addr[i][7:0];
					i<=0;
				   tx_state<=sendheader;
				 end
				 else begin                        
				    dataout[7:0]<=mac_addr[i][7:0];
				    i<=i+1'b1;
				 end
			end
			
			sendheader: begin                        //����7��32bit��IP ��ͷ
				datain_reg<=datain;                   //׼����Ҫ���͵�����	
			   if(j==6) begin                            
					  if(i==0) begin
						 dataout[7:0]<=ip_header[j][31:24];
						 i<=i+1'b1;
					  end
					  else if(i==1) begin
						 dataout[7:0]<=ip_header[j][23:16];
						 i<=i+1'b1;
					  end
					  else if(i==2) begin
						 dataout[7:0]<=ip_header[j][15:8];
						 i<=i+1'b1;
					  end
					  else if(i==3) begin
						 dataout[7:0]<=ip_header[j][7:0];
						 i<=0;
						 j<=0;
						 tx_state<=senddata;			 
					  end
					  else
						 txer<=1'b1;
				end		 
				else begin
					  if(i==0) begin
						 dataout[7:0]<=ip_header[j][31:24];
						 i<=i+1'b1;
					  end
					  else if(i==1) begin
						 dataout[7:0]<=ip_header[j][23:16];
						 i<=i+1'b1;
					  end
					  else if(i==2) begin
						 dataout[7:0]<=ip_header[j][15:8];
						 i<=i+1'b1;
					  end
					  else if(i==3) begin
						 dataout[7:0]<=ip_header[j][7:0];
						 i<=0;
						 j<=j+1'b1;
					  end					
					  else
						 txer<=1'b1;
				end
			 end
			 
			 senddata:begin                                      //����UDP���ݰ�
			   if(tx_data_counter==tx_data_length-9) begin       //��������������
				   tx_state<=sendcrc;	
					if(i==0) begin    
					  dataout[7:0]<=datain_reg[31:24];
					  i<=0;
					end
					else if(i==1) begin
					  dataout[7:0]<=datain_reg[23:16];
					  i<=0;
					end
					else if(i==2) begin
					  dataout[7:0]<=datain_reg[15:8];
					  i<=0;
					end
					else if(i==3) begin
			        dataout[7:0]<=datain_reg[7:0];
					  datain_reg<=datain;                       //׼������
					  i<=0;
					end
            end
            else begin                                     //�������������ݰ�
               tx_data_counter<=tx_data_counter+1'b1;			
					if(i==0) begin    
					  dataout[7:0]<=datain_reg[31:24];
					  i<=i+1'b1;
					  ram_rd_addr<=ram_rd_addr+1'b1;           //RAM��ַ��1, ��ǰ��RAM��������	
					end
					else if(i==1) begin
					  dataout[7:0]<=datain_reg[23:16];
					  i<=i+1'b1;
					end
					else if(i==2) begin
					  dataout[7:0]<=datain_reg[15:8];
					  i<=i+1'b1;
					end
					else if(i==3) begin
			        dataout[7:0]<=datain_reg[7:0];
					  datain_reg<=datain;                       //׼������					  
					  i<=0; 				  
					end
				end
			end	
			
			sendcrc: begin                              //����32λ��crcУ��
				crcen<=1'b0;
				if(i==0)	begin
					  dataout[7:0] <= {~crc[24], ~crc[25], ~crc[26], ~crc[27], ~crc[28], ~crc[29], ~crc[30], ~crc[31]};
					  i<=i+1'b1;
					end
				else begin
				  if(i==1) begin
					   dataout[7:0]<={~crc[16], ~crc[17], ~crc[18], ~crc[19], ~crc[20], ~crc[21], ~crc[22], ~crc[23]};
						i<=i+1'b1;
				  end
				  else if(i==2) begin
					   dataout[7:0]<={~crc[8], ~crc[9], ~crc[10], ~crc[11], ~crc[12], ~crc[13], ~crc[14], ~crc[15]};
						i<=i+1'b1;
				  end
				  else if(i==3) begin
					   dataout[7:0]<={~crc[0], ~crc[1], ~crc[2], ~crc[3], ~crc[4], ~crc[5], ~crc[6], ~crc[7]};
						i<=0;
						tx_state<=idle;
				  end
				  else begin
                  txer<=1'b1;
				  end
				end
			end		
			
			default:tx_state<=idle;		
       endcase	*/  


