// Differential input on a high-range bank of xc7k325tffg676.
// Bank 14 pad D23/D24 is IO_L11P/N_T1_SRCC_14, tile LIOB33_X0Y127.
// The clock is a single-ended LVCMOS33 pad (F22, bank 14 MRCC) so the
// differential receiver is the thing under test, not the clock.
module k325_hr_diff (
    input  wire clk,
    input  wire din_p,
    input  wire din_n,
    output wire led
);
    wire d;
    IBUFDS ib (.I(din_p), .IB(din_n), .O(d));

    reg [23:0] count = 0;
    always @(posedge clk)
        count <= count + (d ? 24'd1 : 24'd0);

    assign led = count[23];
endmodule
