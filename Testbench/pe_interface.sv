// INTERFACE

interface pe_interface();
  logic [7:0] in;   // 4-bit input
  logic [2:0] out;  // 2-bit encoded output
  logic valid;      // Valid signal
  logic clk,rst;
endinterface
