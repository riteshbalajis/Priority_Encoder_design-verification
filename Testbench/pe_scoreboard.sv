// SCOREBOARD

// Class declaration
class pe_scoreboard extends uvm_scoreboard;
  
  // Factory registration
  `uvm_component_utils(pe_scoreboard)
  
  // Declaring analysis export
  uvm_analysis_imp#(pe_seq_item, pe_scoreboard) sb_port; // Connects to monitor
  
  //----------------------------------Default constructor--------------------------------------//
  function new(string name = "pe_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction
  //-------------------------------------------------------------------------------------------//
  
  //---------------------------------------Build phase-----------------------------------------//
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);    
    sb_port = new("sb_port", this);
  endfunction: build_phase
  //-------------------------------------------------------------------------------------------//
  
  //-------------------------------------Write method------------------------------------------//
  function void write(pe_seq_item txn);
    // `uvm_info("SCOREBOARD", "This is for testing", UVM_MEDIUM);

    // Expected output for a priority encoder
    logic [2:0] expected_out;
    bit expected_valid;
    
    casez (txn.in)
   	
      8'b00000000: begin expected_out = 3'b000; expected_valid = 0; end
      8'b00000001: begin expected_out = 3'b000; expected_valid = 1; end
      8'b0000001?: begin expected_out = 3'b001; expected_valid = 1; end
      8'b000001??: begin expected_out = 3'b010; expected_valid = 1; end
      8'b00001???: begin expected_out = 3'b011; expected_valid = 1; end
      8'b0001????: begin expected_out = 3'b100; expected_valid = 1; end
      8'b001?????: begin expected_out = 3'b101; expected_valid = 1; end
      8'b01??????: begin expected_out = 3'b110; expected_valid = 1; end
      8'b1???????: begin expected_out = 3'b111; expected_valid = 1; end
endcase

    if (txn.out == expected_out && txn.valid == expected_valid) begin
      //`uvm_info("SCOREBOARD", $sformatf("Test case passed at t=%0t", $time), UVM_MEDIUM);
      `uvm_info("SCOREBOARD","Test Case Passed Successfully",UVM_MEDIUM);
    end 
    else begin
      //`uvm_error("SCOREBOARD","Test Case Failed",UVM_MEDIUM);
      //`uvm_error("SCOREBOARD", $sformatf("Test case failed: in=%0b, expected_out=%0b, got_out=%0b, expected_valid=%0b, got_valid=%0b at t=%0t",txn.in, expected_out, txn.out, expected_valid, txn.valid, $time));
    end
  endfunction: write 
  //---------------------------------------------------------------------------------------------//
  
endclass: pe_scoreboard
