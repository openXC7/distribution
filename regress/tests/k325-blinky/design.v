// 24-bit counter on xc7k325tffg676. Constraints come from gen_xdc.py
// (a clock-capable pad and one output), the same blinky the E2E uses.
module k325_blinky (
    input  wire clk,
    output wire led
);
    reg [23:0] count = 0;

    always @(posedge clk)
        count <= count + 1;

    assign led = count[23];
endmodule
