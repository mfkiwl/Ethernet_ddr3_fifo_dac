`timescale 1ns / 1ps
module iprecieve
(
    input 				clk,                     //GMII receive clock
    input 				clr,                     //Clear/reset signal
    input 				e_rxdv,                  //GMII receive data valid signal
    input [7:0] 		datain,                  //GMII receives data			          
    input [15:0] 		PHYSR,
    
    input			    tx_en,
    output reg [7:0]    rx_state,			     //Receive state machine
    
    output reg 			data_ok,
    output reg [7:0]	IP4_type,
    output reg [31:0]	IP4_src,
    
    output reg [511:0]	ICMP_data,
    output reg [567:0]	UDP_data,
    
    output reg [47:0]  	eth_dest,
    output reg [47:0]  	eth_src,
    output reg [15:0]  	eth_type,
    output reg [47:0]  	sender_mac,
    output reg [31:0]  	sender_ip,
    output reg [31:0]  	target_ip,
    
    output reg [15:0] 	len_IPv4,
    output reg [15:0] 	len_ICMP,
    output reg [15:0] 	len_UDP,
    
    output reg [15:0]   UDP_SP,
    output reg [15:0]   UDP_DP,
    output reg [15:0]   UDP_DATA_LEN,
    
    output              fifo_dac_wr_clk,
    output reg          fifo_dac_wr_en,
    output reg [7:0]    fifo_dac_data
);

reg [31:0]	IP4_dest;
reg [223:0] ARP_layer;
reg [567:0] UDP_layer;
reg [567:0] UDP_layer_t;

reg [63:0]  UDP_temp;
reg [15:0]  DAC_temp;

reg [159:0] IPv4_layer;
reg [159:0] IPv4_layer_t;

reg [511:0] ICMP_layer;
reg [511:0] ICMP_layer_t;

reg [15:0]  state_counter;
reg [95:0]  mymac;

reg [31:0]  FPGA_IP;
reg [223:0] arp_request;

reg [15:0]  Tlen_IPv4;
reg [15:0]  Tlen_ICMP;
reg [15:0]  Tlen_UDP;

reg [31:0]  BROADCAST_IP;

reg [15:0]	udp_len_bit;

reg [7:0]	byte_cnt;
reg 		arp_en;

	 
parameter 	idle			=8'd0,
			rx_55			=8'd1,
			rx_D5			=8'd2,
            rx_MAC	   	    =8'd3,
			rx_ETH_type		=8'd4,
			rx_ARP_or_IPv4	=8'd5,
			rx_ICMP_or_UDP	=8'd6,
			rx_UDP_Data 	=8'd7;
				
parameter 	ICMP=8'h01, TCP=8'h06, UDP=8'h11;
			 
		 
parameter 	FPGA_IP1	= 8'd192;
parameter 	FPGA_IP2	= 8'd168;
parameter 	FPGA_IP3	= 8'd0;
parameter 	FPGA_IP4	= 8'd222;
			 		 
initial begin
	rx_state<=8'h00;
	data_ok<=1'b0;
	//mac_sender <= {MAC1, MAC2, MAC3, MAC4, MAC5, MAC6};
	FPGA_IP<= {FPGA_IP1, FPGA_IP2, FPGA_IP3, FPGA_IP4};
	BROADCAST_IP<={8'd255, 8'd255, 8'd255, 8'd255};
	
	Tlen_UDP<=16'd0;
	Tlen_ICMP<=16'd0;
	Tlen_IPv4<=16'd0;
	
	udp_len_bit<=16'd0;
	state_counter<=16'd0;
	byte_cnt<=8'd0;
	DAC_temp<=16'd0;
	
	fifo_dac_wr_en<=1'b0;
	arp_en<=1'b0;	
end

assign fifo_dac_wr_clk = (~clk);	


ila_1 eth_rx_dbg
(
    .clk(~clk),
    .probe0(rx_state),  //8bit
    .probe1(e_rxdv),    //1bit
    .probe2(datain)     //8bit
);

always@(negedge clk) begin	

    if(!clr) begin
        rx_state<=idle;
    end
    else begin
        //if(!tx_en) begin
		  case(rx_state)
			idle: begin
				state_counter<=16'd0;
				data_ok<=1'b0;
				arp_en<=1'b0;
				fifo_dac_wr_en<=1'b0;
				
				if(e_rxdv==1'b1) begin                       //Received data is valid high and starts receiving data
					if(datain[7:0]==8'h55) begin              //Received the first 55// 
						rx_state<=rx_55;
					end
				end
			end	
		  
			rx_55:	begin                                  //Receive 6 0x55//
				if ((datain[7:0]==8'h55)&&(e_rxdv==1'b1)) begin
					if (state_counter==16'd5) begin
						rx_state<=rx_D5;
					end
					else
					  	state_counter<=state_counter+1'b1;
				end
				else			
					rx_state<=idle;	
			end
		  
			rx_D5: 	begin                                  //Receive 1 0xd5//
				if((datain[7:0]==8'hD5)&&(e_rxdv==1'b1)) begin 
					state_counter<=16'd0;
					rx_state<=rx_MAC;	
				end  
				else 
					rx_state<=idle;	
			end	
		  
			rx_MAC: begin                    			   //Receive target mac address and source mac address
				if(e_rxdv==1'b1)	begin
					if(state_counter<16'd11)	begin
						mymac<={mymac[87:0],datain};
						state_counter<=state_counter+1'b1;
					end
					else begin
						eth_dest<=mymac[87:40];
						eth_src<={mymac[39:0],datain};
						state_counter<=16'd0;
						rx_state<=rx_ETH_type; 																			
					end
				end
				else
				   rx_state<=idle;				
			end
		  
			rx_ETH_type: begin                                            
				if(e_rxdv==1'b1) begin
					if(state_counter<16'd1) begin
						eth_type<={eth_type[7:0],datain[7:0]};
						state_counter<=state_counter+1'b1;
					end
					else begin
						eth_type<={eth_type[7:0],datain[7:0]};
						rx_state<=rx_ARP_or_IPv4;
						state_counter<=16'd0;
					end
				end																			
				else 
					rx_state<=idle;
			end
			
			rx_ARP_or_IPv4: begin
				case (eth_type)
					16'h0800: begin //Receive IPv4
						if(e_rxdv==1'b1) begin													
							if(state_counter<16'd19) begin
								IPv4_layer_t	<={IPv4_layer_t[151:0],datain[7:0]};
								state_counter	<=state_counter+1'b1;
							end
							else begin
								IPv4_layer		<={IPv4_layer_t[151:0],datain[7:0]};
								len_IPv4		<=IPv4_layer_t[135:120];
								Tlen_IPv4		<=IPv4_layer_t[135:120];
									
								IP4_type		<=IPv4_layer_t[79:72];
								IP4_src			<=IPv4_layer_t[55:24];
								IP4_dest		<={IPv4_layer_t[23:0],datain[7:0]};
								
								sender_ip		<=IPv4_layer_t[55:24];
								target_ip		<={IPv4_layer_t[23:0],datain[7:0]};

								case (IPv4_layer_t[79:72])
									8'd01: begin Tlen_ICMP	<=IPv4_layer_t[135:120] - 16'd20;	end	//ICMP
									8'd17: begin Tlen_UDP	<=IPv4_layer_t[135:120] - 16'd20; 	end	//UDP
									default: rx_state<=idle;
								endcase
								
								rx_state		<=rx_ICMP_or_UDP;
								state_counter	<=16'd0;
							end
						end
						else 
						   rx_state<=idle;
					end
					
					16'h0806: begin //Receive ARP
						if(e_rxdv==1'b1) begin											
							if(state_counter<16'd27) begin
								ARP_layer		<={ARP_layer[215:0],datain};
								state_counter	<=state_counter+1'b1;
							end
							else begin
								sender_mac		<=ARP_layer[151:104];
								sender_ip		<=ARP_layer[103:72];	
								target_ip		<={ARP_layer[23:0],datain};	
								state_counter	<=16'd0;
								if(FPGA_IP[31:0] == {ARP_layer[23:0],datain}) begin
									data_ok<=1'b1;
									arp_en<=1'b1;
								end
								rx_state<=idle;
							end
						end
						else
							rx_state<=idle;
					end

					default:  begin 
						rx_state<=idle;
					end
					
				endcase 
			end
			
			rx_ICMP_or_UDP: begin
				case (IP4_type)
					ICMP: begin 										//Receive ICMP
						if(FPGA_IP == IP4_dest) begin
							//led2<=~led2;
							if(e_rxdv==1'b1) begin	
								if(state_counter < (Tlen_ICMP[15:0]-1'b1))	begin //40 byte receive
									ICMP_layer_t	<={ICMP_layer_t[503:0],datain[7:0]};
									state_counter	<=state_counter+1'b1;
								end
								else begin
									ICMP_data		<={ICMP_layer_t[503:0],datain[7:0]};
									state_counter<=16'd0;	
									data_ok<=1'b1;
									rx_state<=idle;
								end
							end
							else 
								rx_state<=idle; 
						end
						else
							rx_state<=idle;
					end
					
					UDP: begin 	//Receive UDP
					   if( (FPGA_IP == IP4_dest) ) begin
					       if(e_rxdv==1'b1) begin	
						      if(state_counter < 16'd7)	begin 
							     UDP_temp        <= {UDP_temp[55:0],datain[7:0]};
								 state_counter	 <= state_counter+1'b1;
								 if(state_counter==16'd6) begin
								    UDP_SP          <=UDP_temp[47:32];
								    UDP_DP          <=UDP_temp[31:16];
								    UDP_DATA_LEN    <=UDP_temp[15:0];
								 end
							  end
							  else begin
								 state_counter<=16'd0;	
								 rx_state<=rx_UDP_Data;
							  end
						    end
							else 
							    rx_state<=idle; 
						end
						else
							rx_state<=idle;
					end

					default: rx_state<=idle;
				endcase 
			end

			rx_UDP_Data: begin
                if(e_rxdv==1'b1) begin	
                    if(UDP_DATA_LEN > 16'd9) begin
                        if(state_counter < (UDP_DATA_LEN - 16'd9)) begin 
                        //if(state_counter < 16'd1023) begin 
                            state_counter<=state_counter+1'b1;
                            fifo_dac_wr_en<=1'b1;
                            fifo_dac_data <= datain;  
                        end
                        
                        else begin
                            fifo_dac_data <= datain;  
                            state_counter<=16'd0;	
                            rx_state<=idle;
                        end
                        
                    end
                    else
                        rx_state<=idle;
                end
                else
                    rx_state<=idle; 		
			end

			default: rx_state<=idle;    
		endcase
	    //end
	end
	
end
endmodule











































/*if(!PHYSR[10])begin //Link not OK
	//led1<=1'b1;	
	led2<=1'b1;
	led3<=1'b1;
	led4<=1'b1;
	data_ok<=1'b0;
	
	eth_dest 	<=48'h000000000000;
	eth_src  	<=48'h000000000000;
	eth_type   	<=16'h0000;
	sender_mac 	<=48'h000000000000;
	sender_ip	<=32'h00000000;
	target_ip	<=32'h00000000;
end*/



/*			rx_ICMP: begin
				if(e_rxdv==1'b1) begin	
				
					if(state_counter < (Tlen_ICMP[7:0]-1'b1))	begin //40 byte receive
						myICMP_data<={myICMP_data[503:0],datain[7:0]};
						state_counter<=state_counter+1'b1;
					end
					
					else begin
						ICMP_data<={myICMP_data[503:0],datain[7:0]};
						state_counter<=8'd0;	
						data_ok<=1'b1;
						rx_state<=idle;
						led3<=~led3;
					end
					
				end
				else 
				   rx_state<=idle; 
			end*/


/*			parse_ip4: begin
				Tlen_IPv4	<=IP4_layer[151:136];
				Tlen_ICMP	<=IP4_layer[151:136] - 16'd20;
				//eth_type		<=IP4_layer[151:136] - 16'd20;			
				IP4_type		<=IP4_layer[95:88];
				IP4_src		<=IP4_layer[71:40];
				IP4_dest		<=IP4_layer[39:8];
				rx_state		<=check_ip4;
			end*/

/*			rx_arp: begin
				if(e_rxdv==1'b1) begin											
					if(state_counter<8'd27)	begin
						arp_request<={arp_request[215:0],datain};
						state_counter<=state_counter+1'b1;
					end
					else begin
						sender_mac<=arp_request[159:112];
						sender_ip<=arp_request[111:80];	
						target_ip<=arp_request[31:0];	
						if(FPGA_IP[31:0] == arp_request[31:0]) begin
							led4<=~led4;
							data_ok<=1'b1;
						end
						rx_state<=idle;
						state_counter<=8'd0;	
					end
				end
				else 
					rx_state<=idle;
			end*/
			
/*			rx_ip4: begin
				if(e_rxdv==1'b1) begin													
					if(state_counter<8'd19)	begin
						myIP4_layer<={myIP4_layer[151:0],datain[7:0]};
						state_counter<=state_counter+1'b1;
					end
					else begin
						IP4_layer	<={myIP4_layer[151:0],datain[7:0]};
						state_counter<=8'd0;	
						rx_state<=parse_ip4;
					end
				end
				else 
				   rx_state<=idle;
			end*/



			/*rx_IP_layer: begin               										//Receive 20-byte udp virtual header, ip address
				valid_ip_P<=1'b0;
				if(e_rxdv==1'b1) begin													//Receive target mac address and source mac address
					if(state_counter<5'd19)	begin
						myIP_layer<={myIP_layer[151:0],datain[7:0]};
						state_counter<=state_counter+1'b1;
					end
					else begin
						IP_layer<={myIP_layer[151:0],datain[7:0]};
						state_counter<=5'd0;
						rx_state<=rx_UDP_layer;
					end
				end
				else 
				   rx_state<=idle;
			end 
			
			rx_UDP_layer: begin                											//Receive 8-byte UDP port number and UDP packet length	  
		      rx_total_length<=IP_layer[143:128];
				pc_IP<=IP_layer[63:32];
				board_IP<=IP_layer[31:0];
				if(e_rxdv==1'b1) begin
					if(state_counter<5'd7)	begin
						myUDP_layer<={myUDP_layer[55:0],datain[7:0]};
						state_counter<=state_counter+1'b1;
					end
					else begin
						UDP_layer<={myUDP_layer[55:0],datain[7:0]};
                  rx_data_length<= myUDP_layer[23:8];                		//The length of the UDP packet					
						state_counter<=5'd0;
						rx_state<=rx_data;
					end
				end
				else 
				   rx_state<=idle;
			end  
			
  		   rx_data: begin                                             			//Receive UDP data      
					if(e_rxdv==1'b1) begin
					   if (data_counter==rx_data_length-9) begin         			//Save the last data, the real UDP data need to subtract 8 bytes of UDP header
						    data_counter<=0;
  					       rx_state<=rx_finish;
							 ram_wr_addr<=ram_wr_addr+1'b1;	
							 data_o_valid<=1'b1;               							//Write RAM							 
						    if(byte_counter==3'd3) begin
								  data_o<={mydata[23:0],datain[7:0]};
								  byte_counter<=0;
							 end
						    else if(byte_counter==3'd2) begin
						        data_o<={mydata[15:0],datain[7:0],8'h00};       	//Under 32bit, fill 0
								  byte_counter<=0;
							 end
						    else if(byte_counter==3'd1) begin
						        data_o<={mydata[7:0],datain[7:0],16'h0000};     	//Under 32bit, fill 0
								  byte_counter<=0;
							 end
						    else if(byte_counter==3'd0) begin
						        data_o<={datain[7:0],24'h000000};              	//Under 32bit, fill 0
								  byte_counter<=0;
							 end
						end
						else begin
							 data_counter<=data_counter+1'b1;
						    if(byte_counter<3'd3)	begin
								  mydata<={mydata[23:0],datain[7:0]};
								  byte_counter<=byte_counter+1'b1;
					           data_o_valid<=1'b0;  
							 end
							 else begin
						        data_o<={mydata[23:0],datain[7:0]};
						        byte_counter<=3'd0;
								  data_o_valid<=1'b1;                        		//Accept 4byes data, write ram requests
                          ram_wr_addr<=ram_wr_addr+1'b1;							  
                      end	
                  end							 
               end
					else
  					    rx_state<=idle;
			 end 
			 
			 rx_finish: begin
   				 data_o_valid<=1'b0;           
					 data_receive<=1'b1;
                rx_state<=idle;
          end	*/

						//if((mymac[87:72]==16'he440)&&(mymac[71:56]==16'he9c9)&&(mymac[55:40]==16'h14da)) begin    //Received data is valid high and starts receiving data
						//if(pc_mac[47:0] == mac_sender[47:0]) begin  