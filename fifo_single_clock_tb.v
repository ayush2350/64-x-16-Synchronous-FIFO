`timescale 1ns / 1ps

module fifo_single_clock_tb();
  reg rst, clk, wr_en, rd_en;
  reg [15:0] buf_in;
  
  wire [15:0] buf_out;
  wire buf_empty, buf_full;
  
  fifo_single_clock dut( .clk(clk), .rst(rst), .buf_in(buf_in), 
  .buf_out(buf_out),   .wr_en(wr_en), .rd_en(rd_en), .buf_empty(buf_empty), 
  .buf_full(buf_full));
  integer x;
  initial begin
  
    //fifo reset
    clk = 1'b0;
    rst = 1'b1;
    #10 rst = 1'b0;
    
    wr_en = 1'b1;
    buf_in = 16'hFFFF;
    #10 wr_en = 1'b0;
    
    rd_en = 1'b1;
    #10 rd_en = 1'b0;
    
//    rst = 1'b1;
//    #10 rst = 1'b0;
    
    wr_en = 1'b1;
    for (x=0; x<11; x=x+1) #10 buf_in <= x;
    #10 wr_en = 1'b0;
    
    rd_en = 1'b1;
    #120 rd_en = 1'b0;
    
    wr_en = 1'b1;
    buf_in = 16'hFFFF;
    #10 wr_en = 1'b0;
    
    wr_en = 1'b1;
    rd_en = 1'b1;
    
    #20 rd_en = 1'b0; wr_en = 1'b0;
    rst = 1'b1;
    #10 rst = 1'b0;
    
    wr_en = 1'b1;
    for (x=0; x<11; x=x+1) #10 buf_in <= x;
    #10 wr_en = 1'b0;
    
    rd_en = 1'b1;
    #180 rd_en = 1'b0;
    
    rst = 1'b1;
    #10 rst = 1'b0;
    
    $finish;
  end
  
  always #5 clk = ~clk;
endmodule
