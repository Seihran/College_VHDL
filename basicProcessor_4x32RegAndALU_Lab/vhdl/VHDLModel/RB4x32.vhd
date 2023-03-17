-- Complete all selections marked -- >> 

-- RB 4 x 32-bit Register Bank 
-- Created by: Ciarán McCarthy
-- National University of Ireland Galway
-- Create Date: 22/11/2020

-- synchronous write port
-- combinational read port 

-- Component signal dictionary
--  clk system clock strobe
--  rst high asserted asynchronous reset
--  RWr assertion (h) synchronously writes RB(rd) = WBDat
--  rs1 source register address
--  rd destination register address
--  WBDat 32-bit register write data 
--  rs1D source register data 

-- Internal signal dictionary
--  NS: next state  
--  CS: current state  
--  RB: register array: Note: not used outside the component.
--  Could include signals x*Wr, though it is possible to define NS as function of rs1 
--   WBDat, rd(1:0) and RWr signals, without using signals x*Wr

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.basicProcessor_4x32RegAndALU_package.ALL;

entity RB4x32 is
  Port (clk      : in  std_logic;
        rst      : in  std_logic;
		RWr      : in  std_logic;
        rs1 	 : in  std_logic_vector(1 downto 0);
        rd  	 : in  std_logic_vector(1 downto 0);
        WBDat  	 : in  std_logic_vector(31 downto 0);
        rs1D     : out std_logic_vector(31 downto 0)
		);
end RB4x32;

architecture RTL of RB4x32 is
signal RB : reg4x32Type;
signal CS : reg4x32Type;
signal NS : reg4x32Type;

begin

NSDecode_i:  process(rd, RWr, WBDat, CS, clk)
begin
    NS <= CS;
    if (RWr = '1' and rising_edge(clk)) then
        case rd is
           when "00"   => NS(0) <= X"00000000";               
           when "01"   => NS(1) <= WBDat;
           when "10"   => NS(2) <= WBDat;
           when "11"   => NS(3) <= WBDat;
           when others => NS <= CS;
        end case;
    end if;         
end process;

stateReg_i:  process(rst, NS)
begin
    if (rst = '1') then
        CS(0) <= X"00000000";
        CS(1) <= X"00000000";
        CS(2) <= X"00000000";
        CS(3) <= X"00000000";
    else
        CS <= NS;
    end if;   
end process;

asgnRB_i:    RB <= CS; -- assign register array RB = CS; -- though RB is not included in the entity 

asgn_rs1D_i: process(RB, rs1)
begin
    rs1D <= RB(0);
    case rs1 is
       when "01"   => rs1D <= RB(1);
       when "10"   => rs1D <= RB(2);
       when "11"   => rs1D <= RB(3);
       when others => rs1D <= RB(0);
    end case;
end process;

end RTL;