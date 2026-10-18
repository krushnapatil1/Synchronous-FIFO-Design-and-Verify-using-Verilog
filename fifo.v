module fifo(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [7:0] din,
    output reg [7:0] dout,
    output empty,
    output full
);

    //Internal declarations
    reg [7:0] mem [0:7];
    reg [2:0] wr_ptr;
    reg [2:0] rd_ptr;
    reg [3:0] count;


    //Empty and Full Flag Assign
    assign empty = (count == 0);
    assign full = (count == 8);


    always@(posedge clk) begin

        if(rst) begin

            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            dout <= 0;

        end

        else begin 
            
            //Write Operation
            if(wr_en == 1 && full == 0) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
            end

            //Read Operation
            if(rd_en == 1 && empty == 0) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
            end

            // Case 1: Write accepted, read not accepted
            // Increase count
            if((wr_en == 1 && full == 0) && !(rd_en == 1 && empty == 0)) begin
                count <= count + 1;
            end

            // Case 2: Read accepted, write not accepted
            // Decrease count
            else if(!(wr_en == 1 && full == 0) && (rd_en == 1 && empty == 0)) begin
                count <= count - 1;
            end

            // Case 3: Both write and read are accepted
            // Count remains unchanged
            else if((wr_en == 1 && full == 0) && (rd_en == 1 && empty == 0)) begin
                count <= count;
            end

            // Case 4: Neither write nor read is accepted
            // Count remains unchanged
            else begin
                count <= count;
            end
        end

    end

endmodule