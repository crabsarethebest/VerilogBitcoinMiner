//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 01:57:48 PM
// Design Name: 
// Module Name: spi_slave
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spi_slave(
    input clk,
    input rst,
    input logic chip_enable,
    output logic miso_bit,
    input logic [0:255] miso_message, // computed sha256.  This will become MISO_WORD_TO_SEND
    input logic mosi_bit,
    output logic [0:767] mosi_recieved // for debug purposes only.  will remove
    //output logic [0:767] mosi_message // 256-bit midstate + 512-bit block_2
    );
    
    int bit_counter;
    
    //localparam logic [0:7] MISO_WORD_TO_SEND = 8'hA2; // debug purposes only
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_counter <= 0;
            miso_bit <= miso_message[0];
        end else if (!chip_enable) begin
            //mosi_message[bit_counter] <= mosi_bit; // add this back later.  for debug
            if (clk) begin
                mosi_recieved[bit_counter] <= mosi_bit;  // remove later. for debug
                miso_bit <= miso_message[bit_counter+1];
                bit_counter <= bit_counter + 1;
            end    
        end else begin
            bit_counter <= 0;
            miso_bit <= miso_message[0];   
            //mosi_recieved[0] <= mosi_bit;
        end 
    end   
    
endmodule
