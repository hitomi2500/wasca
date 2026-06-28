module i2s_test_core (
    input  wire clk,      // 22.5792 MHz MCLK
    output reg  bck = 0,  // I2S bit clock
    output reg  ws  = 0,  // I2S word select: 0=L, 1=R
    output reg  data = 0  // I2S serial data
);

assign ck = clk;

// 22.5792 MHz / 16 = 1.4112 MHz BCK
// BCK has 32 bits per stereo frame:
// Fs = 1.4112 MHz / 32 = 44.1 kHz
reg [2:0] bck_div = 0;

always @(posedge clk) begin
    bck_div <= bck_div + 1'b1;
    if (bck_div == 3'd7)
        bck <= ~bck;
end

// Work on falling edge of BCK, data valid for receiver on rising edge
reg [4:0] bit_cnt = 0;
reg [15:0] sample = 16'sd12000;
reg [5:0] sample_div = 0;

// 44.1 kHz / 88 ≈ 501 Hz square wave
always @(negedge bck) begin
    bit_cnt <= bit_cnt + 1'b1;

    if (bit_cnt == 5'd31) begin
        bit_cnt <= 0;

        sample_div <= sample_div + 1'b1;
        if (sample_div == 6'd43) begin
            sample_div <= 0;
            sample <= -sample;
        end
    end

    // I2S: WS changes one BCK before MSB
    if (bit_cnt == 5'd31)
        ws <= 0;
    else if (bit_cnt == 5'd15)
        ws <= 1;

    // 16-bit sample per channel, MSB first
    // one-bit I2S delay: MSB starts at bit_cnt 1 / 17
    if (bit_cnt >= 5'd1 && bit_cnt <= 5'd16)
        data <= sample[16 - bit_cnt];
    else if (bit_cnt >= 5'd17 && bit_cnt <= 5'd31)
        data <= sample[32 - bit_cnt];
    else
        data <= 0;
end

endmodule

/*module i2s_sine_500hz (
    input  wire mclk_22m58,
    input  wire rst,

    output reg  i2s_bclk,
    output reg  i2s_lrclk,
    output reg  i2s_dout
);

    // 22.5792 MHz / (2 * 4) = 2.8224 MHz BCLK
    // Fs = BCLK / 64 = 44.1 kHz
    localparam integer BCLK_DIV = 4;

    reg [2:0] bclk_div_cnt = 0;
    wire bclk_tick = (bclk_div_cnt == BCLK_DIV-1);

    reg [5:0] bit_cnt = 0;
    reg [31:0] phase = 0;

    // 500 Hz at Fs = 44100 Hz
    localparam [31:0] PHASE_INC = 32'd48695734;

    reg signed [15:0] sample;
    reg [31:0] shifter;

    wire [4:0] sine_addr = phase[31:27];

    always @(*) begin
        case (sine_addr)
            5'd0:  sample = 16'sd0;
            5'd1:  sample = 16'sd6393;
            5'd2:  sample = 16'sd12539;
            5'd3:  sample = 16'sd18204;
            5'd4:  sample = 16'sd23170;
            5'd5:  sample = 16'sd27245;
            5'd6:  sample = 16'sd30273;
            5'd7:  sample = 16'sd32137;
            5'd8:  sample = 16'sd32767;
            5'd9:  sample = 16'sd32137;
            5'd10: sample = 16'sd30273;
            5'd11: sample = 16'sd27245;
            5'd12: sample = 16'sd23170;
            5'd13: sample = 16'sd18204;
            5'd14: sample = 16'sd12539;
            5'd15: sample = 16'sd6393;
            5'd16: sample = 16'sd0;
            5'd17: sample = -16'sd6393;
            5'd18: sample = -16'sd12539;
            5'd19: sample = -16'sd18204;
            5'd20: sample = -16'sd23170;
            5'd21: sample = -16'sd27245;
            5'd22: sample = -16'sd30273;
            5'd23: sample = -16'sd32137;
            5'd24: sample = -16'sd32767;
            5'd25: sample = -16'sd32137;
            5'd26: sample = -16'sd30273;
            5'd27: sample = -16'sd27245;
            5'd28: sample = -16'sd23170;
            5'd29: sample = -16'sd18204;
            5'd30: sample = -16'sd12539;
            5'd31: sample = -16'sd6393;
        endcase
    end

    always @(posedge mclk_22m58) begin
        if (rst) begin
            bclk_div_cnt <= 0;
            i2s_bclk <= 0;
            i2s_lrclk <= 0;
            i2s_dout <= 0;
            bit_cnt <= 0;
            phase <= 0;
            shifter <= 0;
        end else begin
            if (bclk_tick) begin
                bclk_div_cnt <= 0;
                i2s_bclk <= ~i2s_bclk;

                // update data on falling BCLK edge
                if (i2s_bclk) begin
                    i2s_lrclk <= bit_cnt[5];

                    if (bit_cnt[4:0] == 5'd0) begin
                        shifter <= {sample, 16'd0};
                    end else begin
                        shifter <= {shifter[30:0], 1'b0};
                    end

                    i2s_dout <= shifter[31];

                    if (bit_cnt == 6'd63) begin
                        bit_cnt <= 0;
                        phase <= phase + PHASE_INC;
                    end else begin
                        bit_cnt <= bit_cnt + 1;
                    end
                end
            end else begin
                bclk_div_cnt <= bclk_div_cnt + 1;
            end
        end
    end

endmodule*/