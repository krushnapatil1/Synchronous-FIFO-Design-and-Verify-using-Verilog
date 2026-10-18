`timescale 1ns/1ps

module tb_fifo;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] din;
wire [7:0] dout;
wire empty;
wire full;


fifo dut(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .empty(empty),
    .full(full)
);


always #5 clk = ~clk;


//APPLY STIMMULUS TO FIFO
initial begin

    $dumpfile("fifo.vcd");
    $dumpvars(0, tb_fifo);

    //Initializes Inputs
    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    din = 0;

    //Apply Reset
    #20;
    rst = 0;

    //Write data into FIFO
    #10;
    wr_en = 1;
    din = 8'h45;
    
    #10;
    din = 8'hA8;

    #10;
    din = 8'hC2;

    #10;
    din = 8'h66;

    #10;
    wr_en = 0;
    din = 0;


    //Read data from FTFO
    #10;
    rd_en = 1;


    #40;
    rd_en = 0;

    //End Simulation
    #10;
    $finish;

end

initial begin
    
    $monitor("Time = %0t | clk = %b | rst = %b | wr_en = %b | rd_en = %b | din = %0h | dout = %0h | Full = %b | Empty = %b", $time, clk, rst, wr_en, rd_en, din, dout, full, empty);

end

endmodule