-- Model name: datapathGenerator  
-- Description: Data generation component

-- Complete all sections marked >>
-- Authors: Ciarán McCarthy
-- Date: 19/10/2020

-- Signal dictionary 
-- Inputs
--   selCtrl      deassert (l) to select ctrlA as DPMux select signal 
--                assert   (h) to select ctrlB as DPMux select signal 
--   ctrlA        2-bit control bus
--   ctrlB        2-bit control bus
--   sig0Dat      1-bit data  
--   sig1Dat      3-bit bus data
--   sig2Dat      8-bit bus data
--   sig3Dat      4-bit bus data
-- Outputs         
--   datA         8-bit data 
--   datB         8-bit data. 2s complement of datA 
--   datC         8-bit data. datA + datB

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
 
entity datapathGenerator is
    Port ( selCtrl     : in  std_logic;
           ctrlA       : in  STD_LOGIC_VECTOR(1 downto 0);
           ctrlB       : in  STD_LOGIC_VECTOR(1 downto 0);  
           sys0Dat     : in  STD_LOGIC;   
           sys1Dat     : in  STD_LOGIC_VECTOR(2 downto 0);   
           sys2Dat     : in  STD_LOGIC_VECTOR(7 downto 0);
           sys3Dat     : in  STD_LOGIC_VECTOR(3 downto 0);
           datA        : out STD_LOGIC_VECTOR(7 downto 0);
           datB        : out STD_LOGIC_VECTOR(7 downto 0);
           datC        : out STD_LOGIC_VECTOR(7 downto 0)
          );
end datapathGenerator;

architecture combinational of datapathGenerator is
-- declare internal signals  
signal intDatA, intDatB   : STD_LOGIC_VECTOR (7 downto 0);
signal ctrl      : STD_LOGIC_VECTOR (1 downto 0);

begin

ctrlMux_i: process(ctrlA, ctrlB, selCtrl)
begin
    ctrl <= ctrlA;
    if selCtrl = '1' then ctrl <= ctrlB;
    end if;
end process;

DPMux_i: process(sys0Dat, sys1Dat, sys2Dat, sys3Dat, ctrl)
begin
    intDatA <= "0000" & sys3Dat;
    case ctrl is
       when "01" => intDatA <= sys2Dat;
       when "10" => intDatA <= "11110100";
       when "11" => intDatA <= sys0Dat & sys1Dat & sys2Dat(4 downto 1);
       when others => null;
    end case;
end process;

datA    <= intDatA;
intDatB <= std_logic_vector(unsigned(not intDatA) + 1);
datB    <= intDatB;
datC    <= intDatB + intDatA;

end combinational;