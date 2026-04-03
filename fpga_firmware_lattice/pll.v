`include "timescale.v"

module pll_25_133(input clk_in_25, output clk_out_50, output clk_out_133);
    (* ICP_CURRENT="6" *) (* LPF_RESISTOR="16" *) (* MFG_ENABLE_FILTEROPAMP="1" *) (* MFG_GMCREF_SEL="2" *)
    EHXPLLL #(
        .PLLRST_ENA("DISABLED"),
        .INTFB_WAKE("DISABLED"),
        .STDBY_ENABLE("DISABLED"),
        .DPHASE_SOURCE("DISABLED"),
        .CLKOP_FPHASE(0),
        .CLKOP_CPHASE(4),
        .OUTDIVIDER_MUXA("DIVA"),
        .CLKOP_ENABLE("ENABLED"),
        .CLKOS_ENABLE("ENABLED"),
        .CLKOP_DIV(6),//12//6
        .CLKOS_DIV(16),//20//16
        .CLKFB_DIV(15),//8//16
        .CLKI_DIV(3),
        .FEEDBK_PATH("CLKOP")
    ) pll_i (
        .CLKI(clk_in_25),
        .CLKFB(clk_out_133),
        .CLKOP(clk_out_133),
        .CLKOS(clk_out_50),
        .RST(1'b0),
        .STDBY(1'b0),
        .PHASESEL0(1'b0),
        .PHASESEL1(1'b0),
        .PHASEDIR(1'b0),
        .PHASESTEP(1'b0),
        .PLLWAKESYNC(1'b0),
        .ENCLKOP(1'b0)
    );
endmodule

/*module pll_25_133 (
    input  wire clki,    // example: 100 MHz
    output wire clko
);

    wire clkfb;
    wire clk_mmcm;

    MMCME2_BASE #(
        .BANDWIDTH("OPTIMIZED"),
        .CLKIN1_PERIOD(40.000),     // 25 MHz input
        .DIVCLK_DIVIDE(1),

        // VCO = 25 * 32 / 1 = 800 MHz
        .CLKFBOUT_MULT_F(32.0),

        // Target divide = 16/3 = 5.333..., not exactly possible on 7-series MMCM.
        // Nearest 1/8-step options:
        //   5.375 -> 800/5.375 = 148.837 MHz
        //   5.250 -> 800/5.250 = 152.381 MHz
        .CLKOUT0_DIVIDE_F(6),

        .CLKOUT0_PHASE(0.0),
        .CLKOUT0_DUTY_CYCLE(0.5)
    ) mmcm_i (
        .CLKIN1   (clki),
        .RST      (0),
        .CLKFBIN  (clkfb),
        .CLKFBOUT (clkfb),
        .CLKOUT0  (clk_mmcm),
        .LOCKED   ()
    );

    BUFG bufg_clk_out (
        .I(clk_mmcm),
        .O(clko)
    );

endmodule*/

/*module pll_25_133 (
    input  wire clki,
    //input  wire rst_n,
    output reg  clko = 0,
    //output reg  locked  = 0
);

    time last_ref_edge = 0;
    time ref_period    = 0;
    time out_half_per  = 0;
    reg  locked;

    initial begin
        clko = 0;
        locked  = 0;
    end

    // Measure reference clock period
    always @(posedge clki or negedge rst_n) begin
        //if (!rst_n) begin
        //    last_ref_edge <= 0;
        //    ref_period    <= 0;
        //    out_half_per  <= 0;
        //    locked        <= 0;
        //end else begin
            if (last_ref_edge != 0) begin
                ref_period   <= $time - last_ref_edge;
                // fout = fin * 16/3
                // Tout = Tref * 3/16
                // half period = Tref * 3/32
                out_half_per <= (($time - last_ref_edge) * 3) / 32;
                locked       <= 1;
            end
            last_ref_edge <= $time;
        //end
    end

    // Generate PLL output clock after lock
    initial begin
        forever begin
            wait(locked && out_half_per > 0);
            #(out_half_per) clko = ~clko;
        end
    end

endmodule */
