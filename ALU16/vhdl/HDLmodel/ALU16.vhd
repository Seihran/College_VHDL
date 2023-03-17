-- Title / Description / Signal dictionary
-- Description: 16-bit ALU (ALU16), including 16-to-1 Multiplexer for output select
-- Authors: Ciarán McCarthy, National University of Ireland, Galway 
-- Date: 03/11/2020
-- Change History: Original
-- 
-- Specification, including context diagram, signal dictionary and function tables
--   http://vicilogic.com/static/ext/FODS/ALU16/ALU16%20Design%20Specification.pdf
-- Design docs
--   https://vicilogic.com/static/ext/FODS/ALU16/ALU16%20Design%20Data%20Flow%20Diagram%20Level%200%20(DFD0).pdf
--   https://vicilogic.com/static/ext/FODS/ALU16/ALU16%20Design%20Functional%20Partition%20(FP).pdf
-- vicilogic ALU16 lesson
--   Course https://www.vicilogic.com/vicilearn/run_step/?c_id=22, Section 9


-- Reference: https://tinyurl.com/vicilogicVHDLTips   	Part A: VHDL IEEE library source code VHDL code
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ALU16 is
-- Describes the ALU16 component symbol and input / output signals 
	    Port ( opCode          : in  STD_LOGIC_VECTOR(4 downto 0);
	           A               : in  STD_LOGIC_VECTOR(15 downto 0);
	           B               : in  STD_LOGIC_VECTOR(15 downto 0);
	           carryIn         : in  STD_LOGIC;
	           ALUOut          : out STD_LOGIC_VECTOR(15 downto 0);
	           carryOut        : out STD_LOGIC
		  ); 
end ALU16;

architecture combinational of ALU16 is
-- Reference: https://tinyurl.com/vicilogicVHDLTips  	Part C: Signal declaration examples
-- declare the ALU16 internal signals. Refer to the ALU16 functional partition
signal selLogical    :  STD_LOGIC;
signal logicalOut    :  STD_LOGIC_VECTOR(15 downto 0);
signal arithOut17    :  STD_LOGIC_VECTOR(16 downto 0);

begin
-- Reference: https://tinyurl.com/vicilogicVHDLTips  	Part E: example 2: Combinational VHDL process examples mux21_1 models

-- Create efficient VHDL
-- Refer to the ALU16 functional partition (FP)
-- Use exactly the same process/concurrent statement labels and signal names as those in the FP 
-- Describe each FP element using concurrent statement or process, with short, clear code being the goal. 
-- Don't include process when it is not necessary, e.g, an assignment statement
-- This VHDL template includes default assignment for each signal generated in each  process/concurrent statement.  
-- Using this approach enables earlier (and repeated) syntax checking, 
-- enabling incremental capturing/checking of each VHDL process/concurrent statement 
-- All ALU16 processes are combinational, so include all process input signals in the sensitivity list
-- Always use indentation in VHDL code

asgnSelLogical_i: selLogical <= opCode(4);

logicalUnit_i: process(opCode, A, B)
begin
    logicalOut <= X"0000";
    case opCode(3 downto 0) is
       when "0001" => logicalOut <= B;
       when "0010" => logicalOut <= not A;
       when "0011" => logicalOut <= not B;
       when "0100" => logicalOut <= A and B;
       when "0101" => logicalOut <= A or B;
       when "0110" => logicalOut <= A xor B;
       when "0111" => logicalOut <= A nand B;
       when "1000" => logicalOut <= A nor B;
       when "1001" => logicalOut <= A xnor B;
       when others => logicalOut <= A;
    end case;
end process;

arithUnit_i:  process(opCode, A, B, carryIn)
begin
    arithOut17 <= "00000000000000000";
    case opCode(3 downto 0) is
       when "0001" => arithOut17 <= STD_LOGIC_VECTOR(unsigned('0' & A) + unsigned('0' & B) + (X"0000" & carryIn));
       when "0010" => arithOut17 <= STD_LOGIC_VECTOR(unsigned('0' & A) - 1);
       when "0011" => arithOut17 <= STD_LOGIC_VECTOR(unsigned('0' & A) + 1);
       when "0100" => arithOut17 <= STD_LOGIC_VECTOR(unsigned('0' & A) - unsigned('0' & B));
       when others => arithOut17 <= STD_LOGIC_VECTOR(unsigned('0' & A));
    end case;
end process;

selALUOut_i:  process(selLogical, logicalOut, arithOut17)
begin
    ALUOut <= arithOut17(15 downto 0);
    if selLogical = '1' then ALUOut <= logicalOut;
    end if;
end process;

asgnCarryOut_i:  carryOut <= arithOut17(16);

end combinational;