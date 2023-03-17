-- Complete all selections marked -- >> 

-- testbench for basicProcessor_4x32RegAndALU
-- Created by: Ciarán McCarthy
-- National University of Ireland Galway
-- Create Date: 22/11/2020

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.basicProcessor_4x32RegAndALU_package.ALL;

ENTITY basicProcessor_4x32RegAndALU_TB IS END basicProcessor_4x32RegAndALU_TB;

ARCHITECTURE behavior OF basicProcessor_4x32RegAndALU_TB IS 

component basicProcessor_4x32RegAndALU is
  Port (clk                 : in  std_logic;
        rst                 : in  std_logic;
		imm                 : in  std_logic_vector(11 downto 0);		
 		f3   				: in  std_logic_vector( 2 downto 0);
 		rs1   				: in  std_logic_vector( 1 downto 0);		
 		rd   				: in  std_logic_vector( 1 downto 0);
		RWr     			: in  std_logic
		);

end component; 

SIGNAL clk   			: std_logic := '0';
SIGNAL rst   			: std_logic := '1';
signal imm              : std_logic_vector(11 downto 0);		
signal f3   			: std_logic_vector( 2 downto 0);
signal rs1   			: std_logic_vector( 1 downto 0);		
signal rd   			: std_logic_vector( 1 downto 0);
signal RWr     			: std_logic;

signal testNo		    : integer;
constant clkPeriod      : time := 20 ns;	      -- 50MHz clk

signal endOfSim :        boolean := false;
 
BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: basicProcessor_4x32RegAndALU port map
       (clk    => clk,  
        rst    => rst,  
		imm    => imm,  	
 		f3     => f3,   
 		rs1    => rs1, 
 		rd     => rd, 
		RWr    => RWr
		);

clkStim:	process (clk)
begin
 if (endOfSim = false) then 
   clk <= not clk after clkPeriod/2;
 end if; 
end process;

STIM_i: PROCESS  
begin 
 rst     <= '0';
 -- Assign default input signals
 imm     <= (others => '0');           		
 f3      <= (others => '0');            -- ADD 		
 rs1     <= (others => '0');            -- source register 0				
 RWr     <= '0';                        -- deasserted RWr
 rd      <= "00";          	   	        -- destination register 0
 
 report "Simulation start"; 
 testNo  <= 0;
 rst 					<= '1';
 wait for 0.7*clkPeriod; -- simulate to just after clk rising edge
 rst 					<= '0';
 wait for clkPeriod;  

 testNo  <= 1;
 RWr     <= '1';
 rd      <= "01";
 rs1     <= "01";
 imm     <= "000000010001";
 wait for clkPeriod;
 
 testNo  <= 2;
 rd      <= "10";
 wait for clkPeriod;
 
 testNo  <= 3;
 f3      <= "001";
 wait for clkPeriod;
 
 testNo  <= 4;
 rd      <= "11";
 imm     <= "111111101110";
 f3      <= "100";
 wait for clkPeriod;
 
 testNo  <= 5;
 rd      <= "00";
 imm     <= "011001101110";
 f3      <= "110";
 wait for clkPeriod;
 
 testNo  <= 6;
 rd      <= "01";
 rs1     <= "11";
 imm     <= "111111111111";
 f3      <= "111";
 wait for clkPeriod;
 
 testNo  <= 7;
 f3      <= "000";
 wait for clkPeriod;
 
 testNo  <= 8;
 rd      <= "10";
 rs1     <= "01";
 f3      <= "100";
 wait for clkPeriod;

 report "simulation done";   -- o/p msg to sim transcript
 endOfSim <= true;
 wait; -- will wait forever
 END PROCESS;

end;