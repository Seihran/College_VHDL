-- Complete all selections marked -- >> 

-- basicProcessor_4x32RegAndALU
-- basic processor with 4 x 32-bit registers and ALU
-- Created by: Ciarán McCarthy
-- National University of Ireland Galway
-- Create Date: 22/11/2020

-- Signal dictionary
--  clk system clock strobe
--  rst high asserted asynchronous reset
--  imm(11:0) 12-bit constant value (all or part of signal used in ALU B input)
--  f3(2:0) defines current function 
--  rs1 source register address 
--  rd destination register address
--  RWr assertion (h) synchronously writes register, addressed by rd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.basicProcessor_4x32RegAndALU_package.ALL;

entity basicProcessor_4x32RegAndALU is
  Port (clk                 : in  std_logic;
        rst                 : in  std_logic;
		imm                 : in  std_logic_vector(11 downto 0);		
 		f3   				: in  std_logic_vector( 2 downto 0);
 		rs1   				: in  std_logic_vector( 1 downto 0);		
 		rd   				: in  std_logic_vector( 1 downto 0);
		RWr     			: in  std_logic
		);
end basicProcessor_4x32RegAndALU;

architecture struct of basicProcessor_4x32RegAndALU is 

component ALU is
    port(A,B,selALUOp:in std_logic_vector;
         ALUOut:out std_logic_vector);
end component;

component RB4x32 is
    port(clk,rst,RWr:in std_logic;
         rs1,rd,WBDat:in std_logic_vector;
         rs1D:out std_logic_vector);
end component;

signal RB       : reg4x32Type;
signal A        : std_logic_vector(31 downto 0);
signal B        : std_logic_vector(31 downto 0);
signal extImm   : std_logic_vector(31 downto 0);
signal ALUOut   : std_logic_vector(31 downto 0);
signal rs1D     : std_logic_vector(31 downto 0);
signal selALUOp : std_logic_vector( 2 downto 0);
signal WBDat    : std_logic_vector(31 downto 0);

begin

asgnExtImm_i: extImm <= std_logic_vector(resize(signed(imm), extImm'length));

-- assign signals to other internal signal names
selALUOp_i:   selALUOp <= f3;
asgnA_i:      A        <= rs1D;
asgnB_i:      B        <= extImm;
asgnWBDat_i:  WBDat    <= ALUOut;

-- instantiate components 
ALU_i: ALU port map
            (A        => A,
             B        => B,
             selALUOp => selALUOp,
             ALUOut   => ALUOut
             );
	
RB4x32_i: RB4x32 port map
            (clk      => clk,
             rst      => rst,
             RWr      => RWr,
             rs1      => rs1,
             rd       => rd,
             WBDat    => WBDat,
             rs1D     => rs1D
             );
  
end struct;