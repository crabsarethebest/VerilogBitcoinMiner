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
    output logic [0:2] current_fsm_state,
    output logic [0:11] mosi_lower,
    output logic [0:11] mosi_upper,
    output logic [0:11] final_hash_lower,
    output logic [0:11] final_hash_upper,
    output logic in_send_result_stage
);
    logic [0:255] midstate;
    logic [0:511] block2;
    
    typedef enum {
        REQUEST_MIDSTATE_AND_BLOCK_2,
        WAIT_FOR_MIDSTATE_AND_BLOCK_2,
        COMPUTE_SHA256,
        SEND_RESULT
    } State;
    
    State state, next_state;
    
    logic [0:767] mosi_message;
    logic [0:255] final_hash;
    logic [0:6] count;
    logic spi_rst;
    
    assign mosi_lower = mosi_message[0:11];
    assign mosi_upper = mosi_message[756:767];
    assign final_hash_lower = final_hash[0:11];
    assign final_hash_upper = final_hash[244:255];
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= REQUEST_MIDSTATE_AND_BLOCK_2;
        end else begin
            state <= next_state;
            if (state == COMPUTE_SHA256) begin // give some time for sha256 to complete
                if (count < 100) begin
                    count <= count + 1;
                end else begin
                    count <= 0;
                end
            end else begin
                count <= 0;
            end
        end
    end
    
    always_comb begin
        case (state)
            REQUEST_MIDSTATE_AND_BLOCK_2: begin
                current_fsm_state[0] = 0;
                current_fsm_state[1] = 0;
                current_fsm_state[2] = 0;
                current_fsm_state[3] = 0;
                next_state = chip_enable ? REQUEST_MIDSTATE_AND_BLOCK_2: WAIT_FOR_MIDSTATE_AND_BLOCK_2;
            end
            WAIT_FOR_MIDSTATE_AND_BLOCK_2: begin
                current_fsm_state[0] = 1;
                current_fsm_state[1] = 0;
                current_fsm_state[2] = 0;
                current_fsm_state[3] = 0;
                next_state = chip_enable ? COMPUTE_SHA256 : WAIT_FOR_MIDSTATE_AND_BLOCK_2;
            end
            COMPUTE_SHA256: begin
                current_fsm_state[0] = 0;
                current_fsm_state[1] = 1;
                current_fsm_state[2] = 0;
                current_fsm_state[3] = 0;
                if (count == 100) begin
                    next_state = SEND_RESULT; // Transition from WAIT to NEXT after 100 clock pulses
                end else begin
                    next_state = COMPUTE_SHA256; // Stay in WAIT state
                end
            end
            SEND_RESULT: begin
                current_fsm_state[0] = 1;
                current_fsm_state[1] = 1;
                current_fsm_state[2] = 0;
                current_fsm_state[3] = 0;
                next_state = SEND_RESULT;   
            end
            default: begin
                next_state = REQUEST_MIDSTATE_AND_BLOCK_2;
            end
        endcase
    end
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            in_send_result_stage <= 0;
            midstate <= 0;
            block2 <= 0;
        end else begin
            case (state)
                REQUEST_MIDSTATE_AND_BLOCK_2: begin
                    spi_rst <= 1;
                    request_midstate_and_block_2 <= 1;
                end
                WAIT_FOR_MIDSTATE_AND_BLOCK_2: begin
                    spi_rst <= 0;
                    request_midstate_and_block_2 <= 0;
                end
                COMPUTE_SHA256: begin
                    spi_rst <= 1;
                    midstate <= mosi_message [0:255];
                    block2 <= mosi_message [256:767];
                end
                SEND_RESULT: begin
                    spi_rst <= 0;
                    request_midstate_and_block_2 <= 1;
                    in_send_result_stage <= 1;
                end           
            endcase
        end   
    end
    
    spi_slave spi_slave_interface(.clk(spi_clk), .rst(spi_rst), .chip_enable(chip_enable), .mosi_bit(mosi), .miso_bit(miso), .mosi_recieved(mosi_message), .miso_message(final_hash));
    sha256_wrapper sha256_wrapper_0(.clk(clk),.rst(rst), .midstate(midstate), .block2(block2), .sha256_1_hashed_value(final_hash));
endmodule
