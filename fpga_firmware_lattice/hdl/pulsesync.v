`include "timescale.v"

module pulsesync (
    input  wire src_clk,
    input  wire src_pulse,   // 1-cycle pulse in src_clk domain

    input  wire dst_clk,
    output wire dst_pulse    // 1-cycle pulse in dst_clk domain
);

    // Source domain: toggle bit whenever a pulse arrives
    reg src_toggle = 1'b0;

    always @(posedge src_clk) begin
        if (src_pulse)
            src_toggle <= ~src_toggle;
    end

    // Destination domain: 2-flop synchronizer
    reg dst_sync_ff1 = 1'b0;
    reg dst_sync_ff2 = 1'b0;

    always @(posedge dst_clk) begin
        dst_sync_ff1 <= src_toggle;
        dst_sync_ff2 <= dst_sync_ff1;
    end

    // Edge detect in destination domain
    assign dst_pulse = dst_sync_ff1 ^ dst_sync_ff2;

endmodule