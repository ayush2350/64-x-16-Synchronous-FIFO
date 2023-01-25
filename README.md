# 64-x-16-Synchronous-FIFO

  A FIFO is a special type of buffer. The name FIFO stands for first in first out and means that the data written into the buffer first comes out of it first. 
  There are two types of FIFO:
    1. Synchronous FIFO : Read and Write Operations use same clock
    2. Asynchronous FIFO : Read and Write Operations use different clocks
  
  In this project I've designed a Synchronous 64 x 16 FIFO using Verilog & Verified the design using Test Bench. Here, 64 x 16 means that Width of one memory location is   16 bits and total memory locations are 64.
  The design has the following inputs: rst, clk, wr_en, rd_en, buf_in [15:0]. 
  The design has the following outputs: buf_empty, buf_full, buf_out [15:0]. 
  
  Operation of Synchronous FIFO:
  
    1. When rst = 1, buf_out [15:0] is assigned 0 and all the memory locations in the FIFO are assigned 0. Read and Write pointers are forced to point 0th memory                location.
  
    2. When wr_en = 1, the design checks buf_full signal. If buf_full is 1 (means no memory locations are available to write to), if buf_full = 0 then the data sent              through buf_in[15:0] is written to the memory location pointed by the Write Pointer
  
    3. When rd_en = 1, the design checks buf_empty signal. If buf_empty is 1 (means all memory locations are empty, there's no data available to read ), if buf_empty = 0        then the data is read and is received asm output through buf_out[15:0] from memory location pointed by the Read Pointer.
  
    4. When both rd_en & wr_en are 0 or 1 at the same time then nothing happens.  
