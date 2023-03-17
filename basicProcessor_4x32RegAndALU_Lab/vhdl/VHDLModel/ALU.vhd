-- Complete all selections marked -- >> 

-- Module Name: ALU arithmetic and logic unit module 
-- Engineer: Ciarán McCarthy
-- National University of Ireland Galway
-- Create Date: 22/11/2020
-- 
-- Generates ALUOut from ALU data inputs A, B and control input selALUOP(2:0)
-- Operations include ADD, AND, OR, XOR, SLL  
-- Operator data B 
--
-- Arithmetic + operation on std_logic_vector (slv) types
-- Requires 
--   1. Selection of arithmetic library, "use IEEE.NUMERIC_STD.ALL;" used in VHDL library section. 
--   IEEE.NUMERIC_STD.vhd https://www.csee.umbc.edu/portal/help/VHDL/packages/cieee/numeric_std.vhd supports -/+ functions 
--     Id: A.4
--      function "+" (L, R: SIGNED) return SIGNED;
--      Result subtype: SIGNED(MAX(L'LENGTH, R'LENGTH)-1 downto 0). Result: Adds two SIGNED vectors that may be of different lengths.
--   2. type conversion of slv, i.e, signed or unsigned
--   3. arithmetic operation, using arithmetic operator, e.g, +
--   4. type conversion of arithmetic result to slv 
--  Example:
--      signed addition:    std_logic_vector(signed(A) + signed(B));

-- Signal dictionary
-- A        32-bit ALU input A
-- B        32-bit ALU input B
-- selALUOp ALU operation select ADD, AND, XOR, OR, SLL
-- ALUOut   32-bit ALU output
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
  Port (A        : in  std_logic_vector(31 downto 0); 
        B        : in  std_logic_vector(31 downto 0); 
        selALUOp : in  std_logic_vector( 2 downto 0); 
		ALUOut   : out std_logic_vector(31 downto 0)  
        );        
end ALU;

architecture comb of ALU is

begin

ALUOut_i: process(selALUOp, A, B)
begin
    ALUOut <= STD_LOGIC_VECTOR(signed(A) + signed(B));
    case selALUOp is
        when "000"  => ALUOut <= STD_LOGIC_VECTOR(signed(A) + signed(B));
        when "001"  => ALUOut <= std_logic_vector(SHIFT_LEFT(signed(A), to_integer(signed(B))));
        when "100"  => ALUOut <= A xor B;
        when "110"  => ALUOut <= A or B;
        when "111"  => ALUOut <= A and B;
        when others => ALUOut <= X"00000000";
    end case;
end process;

end comb;