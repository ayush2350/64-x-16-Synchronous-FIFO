`timescale 1ns / 1ps

module fifo_single_clock(clk, rst, buf_in, buf_out, 
                         wr_en, rd_en, buf_empty, buf_full);
input rst, clk, wr_en, rd_en;
input [15:0] buf_in;
output reg [15:0] buf_out;
output reg buf_empty, buf_full;

reg [6:0] fifo_counter,rd_ptr, wr_ptr;
reg [15:0] buf_mem [63:0];

integer i;
always @(fifo_counter) begin
    buf_empty = (fifo_counter == 0);
    buf_full = (fifo_counter == 64);
   end

//resetting of counter and the fifo memory   
always @(posedge clk or posedge rst) begin
    if (rst) begin
        fifo_counter <= 7'b0000000;
        for (i=0; i<64; i=i+1) buf_mem[i] <= 16'd0;
    end
    
    // when read and write operation is initiated at the same time
    else if( (!buf_full && wr_en) && (!buf_empty && rd_en)) begin
        fifo_counter <= fifo_counter;
    end
    
    // WRITE OP: checking if buf is not full and write is enabled
    else if ( !buf_full && wr_en ) begin
        fifo_counter <= fifo_counter + 1;
    end
    
    // READ OP: checking if buf is not empty and read is enabled
    else if ( !buf_empty && rd_en ) begin
        fifo_counter <= fifo_counter - 1;
    end
    else begin
        fifo_counter <= fifo_counter;
    end
    end
   
// read operation    
always @(posedge clk or posedge rst) begin
    if (rst) begin
        buf_out <= 16'd0;
    end
    else begin
        if ( rd_en && !buf_empty ) begin
            buf_out <= buf_mem[rd_ptr];
        end
        else begin
            buf_out <= buf_out;
        end
    end
end

// write operation
always @(posedge clk) begin
    
        if ( wr_en && !buf_full ) begin
            buf_mem[wr_ptr] <= buf_in;
        end
        else begin
            buf_mem[wr_ptr] <= buf_mem[wr_ptr];
        end
    
end

// write and read pointer updation
always @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= 7'd0;
        rd_ptr <= 7'd0;
    end
    else begin
        if ( rd_en && !buf_empty ) begin
            rd_ptr <= rd_ptr + 1;
        end
        else begin
            rd_ptr <= rd_ptr;
        end
        
        if ( wr_en && !buf_full ) begin
                    wr_ptr <= wr_ptr + 1;
                end
                else begin
                    wr_ptr <= wr_ptr;
                end
    end
end

endmodule
