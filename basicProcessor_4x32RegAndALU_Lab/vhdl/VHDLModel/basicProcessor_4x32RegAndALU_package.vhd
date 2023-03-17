-- package for basicProcessor_4x32RegAndALU
-- declares type reg4x32Type used in the basicProcessor_4x32RegAndALU design for register array declaration
-- Created by: Fearghal Morgan 
-- National University of Ireland Galway
-- Creation Date: 5 Nov 2020

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package basicProcessor_4x32RegAndALU_package is
 type reg4x32Type is array (3 downto 0) of std_logic_vector(31 downto 0);
end basicProcessor_4x32RegAndALU_package;

package body basicProcessor_4x32RegAndALU_package is
end basicProcessor_4x32RegAndALU_package;