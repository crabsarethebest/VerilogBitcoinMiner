`include "sigma_functions.sv"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 04/08/2024 07:55:01 PM
// Design Name: 
// Module Name: message_schedule
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


module message_schedule(
    input [0:511] message_block,
    output [0:511] message_schedule
    );

initial begin  
    logic [0:31] x;
    logic [0:31] y;
    x = 32'b00000000000000001111111111111111;
    y = '0;
    
    $display("x is %b", x);
    y = sigma_functions::upper_sigma_one(x);
    $display("y is %b", y);
end
endmodule
