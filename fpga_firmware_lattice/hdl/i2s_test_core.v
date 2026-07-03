module i2s_test_core (
    input  wire clk,      // 22.5792 MHz
    output reg  bck  = 0,
    output reg  ws   = 0,
    output reg  data = 0
);

//////////////////////////////////////////////////////////////
// BCK generator (22.5792 MHz -> 2.1168 MHz)
//
// Half-periods:
// 5,5,6,5,5,6...
//////////////////////////////////////////////////////////////

reg [2:0] hp_state = 0;
reg [2:0] hp_count = 0;

wire hp_done =
    ((hp_state==0 || hp_state==1) && hp_count==4) ||
    ((hp_state==2)                && hp_count==5);

always @(posedge clk) begin

    if(hp_done) begin
        hp_count <= 0;
        hp_state <= (hp_state==2) ? 0 : hp_state+1;
        bck <= ~bck;
    end
    else
        hp_count <= hp_count + 1;

end

//////////////////////////////////////////////////////////////
// detect falling edge of BCK
//////////////////////////////////////////////////////////////

reg bck_d=0;

always @(posedge clk)
    bck_d <= bck;

wire bck_fall = bck_d && !bck;

//////////////////////////////////////////////////////////////
// 24-bit slot serializer
//////////////////////////////////////////////////////////////

reg [5:0] bitcnt = 0;

reg [15:0] left_sample  = 0;
reg [15:0] right_sample = 0;

//////////////////////////////////////////////////////////////
// phase accumulators
//////////////////////////////////////////////////////////////

reg [31:0] phaseL = 0;
reg [31:0] phaseR = 0;

localparam integer INC500 = 48545182;   // round(500*2^32/44100)
localparam integer INC300 = 29127109;   // round(300*2^32/44100)

//////////////////////////////////////////////////////////////
// 3 second state machine
//////////////////////////////////////////////////////////////

localparam integer THREESEC = 132300;

reg [17:0] sample_ctr = 0;
reg [1:0] mode = 0;

// mode:
// 0 silence
// 1 left saw
// 2 right saw

//////////////////////////////////////////////////////////////

always @(posedge clk) begin

if(bck_fall) begin

    //////////////////////////////////////////////////////////
    // shift output
    //////////////////////////////////////////////////////////

    if(bitcnt < 24) begin

        if(bitcnt < 8) begin

            data <= 0;

        end else begin

            if(!ws)
                data <= left_sample [15-(bitcnt-8)];
            else
                data <= right_sample[15-(bitcnt-8)];

        end

        bitcnt <= bitcnt + 1;

    end
    else begin

        bitcnt <= 0;

        ws <= ~ws;

        //////////////////////////////////////////////////////
        // new stereo sample
        //////////////////////////////////////////////////////

        if(ws) begin

            sample_ctr <= sample_ctr + 1;

            if(sample_ctr == THREESEC-1) begin

                sample_ctr <= 0;

                case(mode)
                    0: mode <= 1;
                    1: mode <= 2;
                    default: mode <= 0;
                endcase

            end

            case(mode)

            0: begin
                left_sample  <= 0;
                right_sample <= 0;
            end

            1: begin
                phaseL <= phaseL + INC500;
                left_sample  <= phaseL[31:16];
                right_sample <= 0;
            end

            2: begin
                phaseR <= phaseR + INC300;
                left_sample  <= 0;
                right_sample <= phaseR[31:16];
            end

            endcase

        end

    end

end

end

endmodule