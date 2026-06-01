module sniff_fifo (
    input  wire        clock,
    input  wire [15:0] data,
    input  wire        rdreq,
    input  wire        wrreq,
    output wire        empty,
    output wire        full,
    output reg  [15:0] q,
    output wire [9:0]  usedw
);

    localparam DEPTH = 1024;
    localparam AW    = 10;

    reg [15:0] mem [0:DEPTH-1];

    reg [AW-1:0] wr_ptr = {AW{1'b0}};
    reg [AW-1:0] rd_ptr = {AW{1'b0}};
    reg [AW:0]   count  = {(AW+1){1'b0}};  // internal count: 0..1024

    wire do_write = wrreq && !full;
    wire do_read  = rdreq && !empty;

    assign empty = (count == 0);
    assign full  = (count == DEPTH);

    // usedw is 10 bits to match a 1K FIFO interface.
    // Note: when FIFO is completely full (1024 words), usedw rolls over to 0
    // because 10 bits cannot represent 1024. If exact full count is required,
    // widen this port to 11 bits.
    assign usedw = count[AW-1:0];

    always @(posedge clock) begin
        // write
        if (do_write) begin
            mem[wr_ptr] <= data;
            wr_ptr <= wr_ptr + 1'b1;
        end

        // read
        if (do_read) begin
            q <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        end

        // count update
        case ({do_write, do_read})
            2'b10: count <= count + 1'b1; // write only
            2'b01: count <= count - 1'b1; // read only
            default: count <= count;      // no change or simultaneous read/write
        endcase
    end

endmodule