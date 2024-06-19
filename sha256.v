module sha256 (
    input clk,
    input rst,
    input logic [0:255] hash_constants,
    input logic [0:511] unhashed_value,
    output logic [0:255] hashed_value
        );
    
    logic [0:31] a, b, c, d, e, f, g, h;
    assign a = hash_constants[0:31];
    assign b = hash_constants[32:63];
    assign c = hash_constants[64:95];
    assign d = hash_constants[96:127];
    assign e = hash_constants[128:159];
    assign f = hash_constants[160:191];
    assign g = hash_constants[192:223];
    assign h = hash_constants[224:255];
    
    logic [0:31] message_schedule [0:63];
    message_scheduler message_scheduler(.message_block(unhashed_value[0:511]), .message_schedule(message_schedule));
    
    hasher hasher0 (
                                        .clk(clk),
                                        .rst(rst),
                                        .message_schedule(message_schedule),
                                        .a(a),
                                        .b(b),
                                        .c(c),
                                        .d(d),
                                        .e(e),
                                        .f(f),
                                        .g(g),
                                        .h(h),      
                                        .hash_out(hashed_value)                                   
    );
endmodule
