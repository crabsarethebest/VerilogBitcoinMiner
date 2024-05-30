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
    input logic mosi,
    output logic miso,
    output logic mosi_message,
    output logic [0:767] mosi_recieved // 256-bit midstate + 512-bit block_2
    );
    

    int bit_counter;
    
    localparam logic [0:7] MISO_WORD_TO_SEND = 8'hA2;
    
    always_ff @(posedge clk or posedge rst) begin
        if (chip_enable == 0) begin
            mosi_recieved[bit_counter] = mosi;
            miso = MISO_WORD_TO_SEND[bit_counter + 1];
            bit_counter += 1;
        
        end else begin
            bit_counter = 0;
            miso = MISO_WORD_TO_SEND[0];       
        end 
    end  
    
    
endmodule
