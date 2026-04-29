
// Priority Encoder (4-to-2)
module priority_encoder_4to2 (
  input  logic [7:0] in,clk,rst,
  output logic [2:0] out,
  output logic valid
  
);
  always @(posedge clk) begin
    if(rst==0) begin
       out = 3'b000; valid = 0;
    end
    else begin
      
        casez (in)
            8'b00000000: begin out = 3'b000; valid = 0; end
            8'b00000001: begin out = 3'b000; valid = 1; end
            8'b0000001?: begin out = 3'b001; valid = 1; end
            8'b000001??: begin out = 3'b010; valid = 1; end
            8'b00001???: begin out = 3'b011; valid = 1; end
            8'b0001????: begin out = 3'b100; valid = 1; end
            8'b001?????: begin out = 3'b101; valid = 1; end
            8'b01??????: begin out = 3'b110; valid = 1; end
            8'b1???????: begin out = 3'b111; valid = 1; end
            default: begin out = 4'b0000; valid = 0; end
        endcase
    end
  end
endmodule
