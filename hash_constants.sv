//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2024 04:19:32 PM
// Design Name: 
// Module Name: hash_constants
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


module hasher(
    input logic clk,
    input logic rst,
    input logic [0:31] message_schedule[0:63],
    input logic [0:31] a,
    input logic [0:31] b,
    input logic [0:31] c,
    input logic [0:31] d,
    input logic [0:31] e,
    input logic [0:31] f,
    input logic [0:31] g,
    input logic [0:31] h,
    output logic [0:255] hash_out
    );

    logic [0:31] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in;
    logic [0:31] a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out;
    logic [0:31] k_constants_in [0:31];
    logic [0:31] message_schedule_in [0:31];
    logic [0:31] a_mid_out, b_mid_out, c_mid_out, d_mid_out, e_mid_out, f_mid_out, g_mid_out, h_mid_out;
    logic [0:1] count;
    
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 1;
        a_in <= a;
        b_in <= b;
        c_in <= c;
        d_in <= d;
        e_in <= e;
        f_in <= f;
        g_in <= g;
        h_in <= h;
        k_constants_in <= sha256_constants::k_constants[0:31];
        message_schedule_in <= message_schedule[0:31];
    end else begin
        if (count == 1) begin
            count <= count + 1;
            a_in <= a_mid_out;
            b_in <= b_mid_out;
            c_in <= c_mid_out;
            d_in <= d_mid_out;
            e_in <= e_mid_out;
            f_in <= f_mid_out;
            g_in <= g_mid_out;
            h_in <= h_mid_out;
            k_constants_in <= sha256_constants::k_constants[32:63];
            message_schedule_in <= message_schedule[32:63];
        end
    end
end    

    hash_block hash_block0(
        .clk(clk),
        .rst(rst),
        .a(a_in),
        .b(b_in),
        .c(c_in),
        .d(d_in),
        .e(e_in),
        .f(f_in),
        .g(g_in),
        .h(h_in),
        .message_schedule(message_schedule_in),
        .k_constants(k_constants_in),
        .a_out(a_mid_out),
        .b_out(b_mid_out),
        .c_out(c_mid_out),
        .d_out(d_mid_out),
        .e_out(e_mid_out),
        .f_out(f_mid_out),
        .g_out(g_mid_out),
        .h_out(h_mid_out)    
    );


    always_comb begin
        if (rst) begin
            a_out = 0;
            b_out = 0;
            c_out = 0;
            d_out = 0;
            e_out = 0;
            f_out = 0;
            g_out = 0;
            h_out = 0;
            hash_out = 0;
         end else begin
            if (count == 2) begin
                a_out = a + a_mid_out;
                b_out = b + b_mid_out;
                c_out = c + c_mid_out;
                d_out = d + d_mid_out;
                e_out = e + e_mid_out;
                f_out = f + f_mid_out;
                g_out = g + g_mid_out;
                h_out = h + h_mid_out;
                hash_out = {a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out};
            end else begin
                a_out = 0;
                b_out = 0;
                c_out = 0;
                d_out = 0;
                e_out = 0;
                f_out = 0;
                g_out = 0;
                h_out = 0;
                hash_out = 0;           
            end
        end
   end 
   
endmodule
