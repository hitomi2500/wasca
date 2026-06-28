module i2s_test_core (
    input  wire clk,      // 22.5792 MHz MCLK
    output reg  bck = 0,  // 2.8224 MHz
    output reg  ws  = 0,  // 0=L, 1=R
    output reg  data = 0
);

    localparam integer CLK_DIV_BCK_HALF = 4;      // MCLK / (2*4) = 2.8224 MHz
    localparam integer FRAMES_3SEC      = 132300; // 44100 * 3

    localparam [31:0] PHASE_INC_500 = 32'h02E709DE;
    localparam [31:0] PHASE_INC_250 = 32'h017384EF;

    localparam signed [15:0] AMP_POS = 16'sh6000;
    localparam signed [15:0] AMP_NEG = -16'sh6000;

    reg [2:0]  clkdiv = 0;
    reg [5:0]  bitpos = 0;       // 0..63
    reg [17:0] frame_count = 0;
    reg [1:0]  mode = 0;         // 0=silence, 1=L 500Hz, 2=R 250Hz

    reg [31:0] phase_l = 0;
    reg [31:0] phase_r = 0;

    reg signed [15:0] sample_l = 0;
    reg signed [15:0] sample_r = 0;

    always @(posedge clk) begin
        if (clkdiv == CLK_DIV_BCK_HALF-1) begin
            clkdiv <= 0;
            bck <= ~bck;

            // update I2S signals on BCK falling edge
            if (bck == 1'b1) begin
                bitpos <= bitpos + 1'b1;
                ws <= bitpos[5]; // 0 for left slot, 1 for right slot

                // New audio frame at start of left slot
                if (bitpos == 6'd63) begin
                    if (frame_count == FRAMES_3SEC-1) begin
                        frame_count <= 0;
                        mode <= (mode == 2) ? 0 : mode + 1'b1;
                    end else begin
                        frame_count <= frame_count + 1'b1;
                    end

                    phase_l <= phase_l + PHASE_INC_500;
                    phase_r <= phase_r + PHASE_INC_250;

                    case (mode)
                        2'd0: begin
                            sample_l <= 16'sd0;
                            sample_r <= 16'sd0;
                        end

                        2'd1: begin
                            sample_l <= phase_l[31] ? AMP_NEG : AMP_POS;
                            sample_r <= 16'sd0;
                        end

                        2'd2: begin
                            sample_l <= 16'sd0;
                            sample_r <= phase_r[31] ? AMP_NEG : AMP_POS;
                        end

                        default: begin
                            sample_l <= 16'sd0;
                            sample_r <= 16'sd0;
                        end
                    endcase
                end

                // I2S: one-bit delay after WS transition.
                // 16-bit sample in upper part of each 32-bit slot.
                if (bitpos >= 6'd0 && bitpos <= 6'd15)
                    data <= sample_l[15 - bitpos];
                else if (bitpos >= 6'd32 && bitpos <= 6'd47)
                    data <= sample_r[47 - bitpos];
                else
                    data <= 1'b0;
            end
        end else begin
            clkdiv <= clkdiv + 1'b1;
        end
    end

endmodule