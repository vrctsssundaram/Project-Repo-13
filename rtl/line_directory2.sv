module line_directory2 (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [1:0]  req_valid,
    output reg  [1:0]  req_ready,
    input  wire [1:0]  req_write,
    input  wire [3:0]  req_line,
    output reg  [1:0]  rsp_valid,
    input  wire [1:0]  rsp_ready,
    output reg         snoop_valid,
    output reg  [1:0]  snoop_target,
    output reg  [1:0]  snoop_line,
    input  wire [1:0]  snoop_ack,
    output reg  [31:0] grants,
    output reg  [31:0] invalidations
);
    localparam [1:0] IDLE=0, SNOOP=1, RESPONSE=2;
    reg [1:0] state;
    reg [1:0] sharers [0:3];
    reg round_robin;
    reg pending_master;
    reg [1:0] pending_line;
    reg [1:0] pending_target;
    reg chosen_master;
    reg chosen_valid;
    reg [1:0] chosen_line;
    reg [1:0] self_mask;
    reg [1:0] other_sharers;
    integer i;

    always @* begin
        chosen_valid = |req_valid;
        chosen_master = round_robin ? (req_valid[1] ? 1'b1 : 1'b0)
                                    : (req_valid[0] ? 1'b0 : 1'b1);
        chosen_line = chosen_master ? req_line[3:2] : req_line[1:0];
        self_mask = chosen_master ? 2'b10 : 2'b01;
        other_sharers = sharers[chosen_line] & ~self_mask;
        req_ready = 0;
        if (state == IDLE && chosen_valid) req_ready[chosen_master] = 1;
        rsp_valid = 0;
        if (state == RESPONSE) rsp_valid[pending_master] = 1;
        snoop_valid = (state == SNOOP);
        snoop_target = pending_target;
        snoop_line = pending_line;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            round_robin <= 0;
            pending_master <= 0;
            pending_line <= 0;
            pending_target <= 0;
            grants <= 0;
            invalidations <= 0;
            for (i=0;i<4;i=i+1) sharers[i] <= 0;
        end else begin
            case (state)
                IDLE: if (chosen_valid) begin
                    round_robin <= ~chosen_master;
                    pending_master <= chosen_master;
                    pending_line <= chosen_line;
                    if (req_write[chosen_master] && other_sharers != 0) begin
                        pending_target <= other_sharers;
                        state <= SNOOP;
                    end else begin
                        if (req_write[chosen_master]) sharers[chosen_line] <= self_mask;
                        else sharers[chosen_line] <= sharers[chosen_line] | self_mask;
                        grants <= grants + 1'b1;
                        state <= RESPONSE;
                    end
                end
                SNOOP: if ((snoop_ack & pending_target) == pending_target) begin
                    sharers[pending_line] <= pending_master ? 2'b10 : 2'b01;
                    invalidations <= invalidations + 1'b1;
                    grants <= grants + 1'b1;
                    state <= RESPONSE;
                end
                RESPONSE: if (rsp_ready[pending_master]) state <= IDLE;
                default: state <= IDLE;
            endcase
        end
    end
endmodule
