----------------------------------------------------------------------------------
-- Lab 6: Radix-4 Multiplier
-- ECE 524/L
-- Engineer: Joel Bailey
--
-- Create Date: 20201105
-- Modified Last: 20201110
-- Module Name: ADDER.vhd
-- Description: Simple combinational adder module
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADDER is
    Port ( A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           SUM : out STD_LOGIC_VECTOR (11 downto 0));
end ADDER;

architecture Behavioral of ADDER is

begin

SUM <= std_logic_vector(unsigned(A) + unsigned(B));

end Behavioral;
