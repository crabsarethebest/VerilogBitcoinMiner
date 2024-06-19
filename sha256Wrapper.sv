
module sha256_wrapper (
    input clk,
    input rst,
    input logic [0:255] midstate,
    input logic [0:511] block2,
    output logic [0:255] sha256_1_hashed_value
    );
    
    logic [0:255] sha256_0_hashed_value_unpadded;
    logic [0:511] sha256_0_hashed_value_padded;
    logic sha256_0_rst, sha256_1_rst;
    logic [0:1] count;
    
    pad_bits padder(.unpadded_message(sha256_0_hashed_value_unpadded), .padded_message(sha256_0_hashed_value_padded));

    sha256 sha256_0(
        .clk(clk), 
        .rst(sha256_0_rst), 
        .hash_constants({
                            midstate[0:31],
                            midstate[32:63], 
                            midstate[64:95],
                            midstate[96:127],
                            midstate[128:159],
                            midstate[160:191],
                            midstate[192:223],
                            midstate[224:255]
                        }), 
        .unhashed_value(block2), 
        .hashed_value(sha256_0_hashed_value_unpadded)
    );
    
    sha256 sha256_1(
        .clk(clk), 
        .rst(sha256_1_rst), 
        .hash_constants({
                            sha256_constants::h_constants[0],
                            sha256_constants::h_constants[1], 
                            sha256_constants::h_constants[2],
                            sha256_constants::h_constants[3],
                            sha256_constants::h_constants[4],
                            sha256_constants::h_constants[5],
                            sha256_constants::h_constants[6],
                            sha256_constants::h_constants[7]
                        }), 
        .unhashed_value(sha256_0_hashed_value_padded), 
        .hashed_value(sha256_1_hashed_value)
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            sha256_0_rst <= 1; 
            sha256_1_rst <= 1;    
        end else begin
            if (count == 0) begin
                count <= count + 1;
                sha256_0_rst <= 0;
            end else if (count == 1) begin
                count <= count + 1;
            end else if (count == 2) begin
                count <= count + 1;
                sha256_1_rst <= 0;
            end
        end
    end
endmodule
