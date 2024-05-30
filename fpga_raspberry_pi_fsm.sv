`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2024 04:05:24 PM
// Design Name: 
// Module Name: fpga_raspberry_pi_fsm
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


module fpga_raspberry_pi_fsm(
    input logic clk,
    input logic rst,
    input logic spi_clk,
    input logic chip_enable,
    input logic mosi, // mealy signal
    output logic miso,
    output logic request_midstate_and_block_2,
    input logic recieved_midstate_and_block_2,
    output logic [0:3] led_lower_mosi,
    output logic [0:3] led_upper_mosi
);
    
    typedef enum {
        REQUEST_MIDSTATE_AND_BLOCK_2,
        WAIT_FOR_MIDSTATE_AND_BLOCK_2,
        COMPUTE_SHA256,
        SEND_RESULT
    } State;
    
    State state, next_state;
    
    logic mosi_message;
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= REQUEST_MIDSTATE_AND_BLOCK_2;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case (state)
            REQUEST_MIDSTATE_AND_BLOCK_2: begin
                request_midstate_and_block_2 = 1;
                next_state = WAIT_FOR_MIDSTATE_AND_BLOCK_2;
            end
            WAIT_FOR_MIDSTATE_AND_BLOCK_2: begin
                request_midstate_and_block_2 = 0;
                next_state = recieved_midstate_and_block_2 ? COMPUTE_SHA256 : WAIT_FOR_MIDSTATE_AND_BLOCK_2;
            end
            COMPUTE_SHA256: begin
                $display("state is COMPUTE_SHA256");
            end
            SEND_RESULT: begin
                $display("state is SEND_RESULT");
            end
            default: begin
                $display("state is DEFAULT");
                next_state = REQUEST_MIDSTATE_AND_BLOCK_2;
                request_midstate_and_block_2 = 0;
            end
        endcase
    end
   
    spi_slave spi_slave_interface(.clk(spi_clk), .rst(rst), .chip_enable(chip_enable), .mosi_bit(mosi), .miso_bit(miso));
    sha256_wrapper sha256_wrapper_0();
endmodule
