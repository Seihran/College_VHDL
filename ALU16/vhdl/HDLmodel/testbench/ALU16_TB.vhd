-- Title / Description / Signal dictionary
-- Description: Testbench for Arithmetic and Logical Unit 
-- Authors: Ciarán McCarthy, National University of Ireland, Galway 
-- Date: 03/11/2020
-- Change History: Original

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ALU16_TB IS END ALU16_TB;
 
architecture behave of ALU16_TB is
COMPONENT ALU16 is
    Port ( opCode          : in  STD_LOGIC_VECTOR(4 downto 0);
	       A               : in  STD_LOGIC_VECTOR(15 downto 0);
	       B               : in  STD_LOGIC_VECTOR(15 downto 0);
           carryIn         : in  STD_LOGIC;
           ALUOut          : out STD_LOGIC_VECTOR(15 downto 0);
  	       carryOut        : out STD_LOGIC
		  );
END COMPONENT;

-- declare testbench signals
signal opCode        :   STD_LOGIC_VECTOR(4 downto 0);
signal A             :   STD_LOGIC_VECTOR(15 downto 0);
signal B             :   STD_LOGIC_VECTOR(15 downto 0);
signal carryIn       :   STD_LOGIC;
signal ALUOut        :   STD_LOGIC_VECTOR(15 downto 0);
signal carryOut      :   STD_LOGIC;
signal selLogical    :   STD_LOGIC;
signal logicalOut    :   STD_LOGIC_VECTOR(15 downto 0);
signal arithOut17    :   STD_LOGIC_VECTOR(16 downto 0);

signal  testNo   : integer; -- test numbers aid locating each simulation waveform test 
signal  endOfSim : boolean := false;  -- assert at end of simulation to show end point
 
BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: ALU16 PORT MAP
           (opCode   => opCode,
            A        => A,
            B        => B,
            carryIn  => carryIn,
            ALUOut   => ALUOut,
            carryOut => carryOut
            );

stim_i: process -- Stimulus process
begin
   report "%N : Simulation start";
   endOfSim <= false;

   testNo  <= 0;
   opCode  <= "00000";
   A       <= "1010010101011010";
   B       <= "0011110011000011";
   carryIn <= '0';
   wait for 10 ns;
   
   testNo  <= 1;
   opCode  <= "00101";
   wait for 10 ns;
   for i in 0 to 9 loop
       opCode <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
       wait for 10 ns;
   end loop;
   
   testNo  <= 2;
   opCode  <= "10000";
   wait for 10 ns;
   
   testNo  <= 3;
   opCode  <= "11010";
   wait for 10 ns;
   for i in 0 to 4 loop
       opCode <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
       wait for 10 ns;
   end loop;
   
   testNo  <= 4;
   A       <= "0101101010100101";
   wait for 10 ns;
   
   testNo  <= 5;
   opCode  <= "10001";
   wait for 10 ns;
   
   testNo  <= 6;
   B       <= "1100001100111100";
   wait for 10 ns;
   
   testNo  <= 7;
   A       <= "1010010101011010";
   B       <= "1001011001101001";
   opCode  <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
   wait for 10 ns;
   
   opCode  <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
   B       <= "0011110011000011";
   wait for 10 ns;
   
   opCode  <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
   B       <= "0101101001010111";
   wait for 10 ns;
   
   for i in 0 to 4 loop
       opCode     <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
       wait for 10 ns;
   end loop;
   
   testNo  <= 8;
   opCode  <= "00001";
   A       <= "1111111111111110";
   B       <= "0000000000000001";
   carryIn <= '0';
   wait for 10 ns;
   
   testNo  <= 9;
   carryIn <= '1';
   wait for 10 ns;
   
   testNo  <= 10;
   opCode  <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
   A       <= "0000000000000001";
   B       <= "0011110011000011";
   carryIn <= '0';
   wait for 10 ns;
   
   testNo  <= 11;
   A       <= "0000000000000000";
   carryIn <= '1';
   wait for 10 ns;
   
   testNo  <= 12;
   opCode  <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
   A       <= "1111111111111110";
   carryIn <= '0';
   wait for 10 ns;
   
   testNo  <= 13;
   A       <= "1111111111111111";
   carryIn <= '1';
   wait for 10 ns;
   
   testNo  <= 14;
   opCode  <= STD_LOGIC_VECTOR(unsigned(opCode) + 1);
   B       <= "1111111111111110";
   carryIn <= '0';
   wait for 10 ns;
   
   endOfSim <= true;
   report "%N : Simulation end";
   
   wait;
end process;

END;