// An ODDR on an HP bank of a Zynq: xc7z030, pad B5, bank 34.
// Based on openXC7/demo-projects regression/zynq-hp-oddr, with a toggling
// flip-flop driving D1 so the design has a register-to-register path on clk
// and --report carries an fmax.
module z030_hp_oddr (
    input  wire clk_in,
    output wire io
);
    wire clk;
    BUFG bufg_clk (.I(clk_in), .O(clk));

    reg d = 1'b0;
    always @(posedge clk) d <= ~d;

    wire q;
    ODDR #(.DDR_CLK_EDGE("OPPOSITE_EDGE"), .INIT(1'b0), .SRTYPE("SYNC")) oddr (
        .Q(q), .C(clk), .CE(1'b1), .D1(d), .D2(1'b0), .R(1'b0), .S(1'b0)
    );
    assign io = q;
endmodule
