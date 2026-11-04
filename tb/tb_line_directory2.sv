module tb_line_directory2;
    reg clk=0; always #5 clk=~clk;
    reg rst_n=0;
    reg [1:0] req_valid=0,req_write=0,snoop_ack=0,rsp_ready=2'b11;
    reg [3:0] req_line=0;
    wire [1:0] req_ready,rsp_valid,snoop_target,snoop_line;
    wire snoop_valid;
    wire [31:0] grants,invalidations;
    line_directory2 dut(.*);
    task request(input master,input wr,input [1:0] line_id);
        begin
            @(negedge clk);
            while(!(req_ready==0)) @(negedge clk);
            req_valid[master]=1;
            req_write[master]=wr;
            req_line[master*2 +:2]=line_id;
            @(posedge clk);
            if(!req_ready[master]) $fatal(1,"Request not granted");
            @(negedge clk);req_valid[master]=0;
        end
    endtask
    task wait_response(input master);
        begin
            wait(rsp_valid[master]);
            @(negedge clk);
        end
    endtask
    task acknowledge(input [1:0] target);
        begin
            repeat(3) @(negedge clk);
            if(!snoop_valid || snoop_target!==target || snoop_line!==2'd1 || rsp_valid!=0)
                $fatal(1,"Snoop target or response-before-ack error");
            snoop_ack=target;
            @(negedge clk);snoop_ack=0;
        end
    endtask
    initial begin
        repeat(3) @(negedge clk);rst_n=1;
        request(0,0,1);wait_response(0);
        request(1,0,1);wait_response(1);
        request(0,1,1);
        wait(snoop_valid);
        acknowledge(2'b10);
        wait_response(0);
        request(1,1,1);
        wait(snoop_valid);
        acknowledge(2'b01);
        wait_response(1);
        if(grants!==4 || invalidations!==2) $fatal(1,"Directory counters");
        $display("PASS: shared reads, invalidate-and-ack, serialized write ownership");
        $finish;
    end
    initial begin #100000;$fatal(1,"Watchdog");end
endmodule
