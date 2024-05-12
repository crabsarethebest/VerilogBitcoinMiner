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
    input logic chip_enable,
    //input logic send_byte,
    input logic mosi,
    output logic miso
    );
    
    logic [0:511] mosi_word;
    logic [0:255] mesi_word;
    logic [0:511] word_to_hash;
    logic clock_previously_low;
    logic clock_previously_low = 0;
    logic [0:5] byte_counter;
    logic [0:3] bit_counter;
    logic clock_previously_low;
    int bit_counter;
    logic send_byte;
    
    localparam logic [0:7] MISO_WORD_TO_SEND = 8'hA2;

always_ff @(posedge clk) begin
    if (chip_enable == 0) begin
        send_byte = 1;
        if (byte_counter == 0) begin
            mosi_word = 0;
            //mosi_word[byte_counter * 8: (byte_counter + 1) * 8 - 1] = mosi;
            byte_counter = byte_counter + 1;
            clock_previously_low = 1;
        end
        if (send_byte == 1) begin
            miso = MISO_WORD_TO_SEND[bit_counter];
            bit_counter = bit_counter + 1;
        end
    end else begin
        send_byte = 0;
        bit_counter = 0;
        byte_counter = 0;
        
        if (clock_previously_low == 1) begin
            word_to_hash = mosi_word;
            clock_previously_low = 0;
        end
    end 
end  
    
    
endmodule
