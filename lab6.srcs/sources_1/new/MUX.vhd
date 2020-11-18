----------------------------------------------------------------------------------
-- Lab 6: Radix-4 Multiplier
-- ECE 524/L
-- Engineer: Joel Bailey
--
-- Create Date: 20201105
-- Modified Last: 20201110
-- Module Name: MUX.vhd
-- Description: Multiplexer with following select lines:
--  - 0     -> 00
--  - A     -> 01
--  - A * 2 -> 10
--  - A * 3 -> 11
--  Select line is 2 LSB of multiplcand
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX is
    Port ( A : in STD_LOGIC_VECTOR (9 downto 0);
           SEL : in STD_LOGIC_VECTOR (1 downto 0);
           MUX_OUT : out STD_LOGIC_VECTOR (11 downto 0));
end MUX;

architecture Behavioral of MUX is

begin

with SEL select
    MUX_OUT <= "00" & A when "01",
               std_logic_vector(to_unsigned(2,2) * unsigned(A)) when "10",
               std_logic_vector(to_unsigned(3,2) * unsigned(A)) when "11",
               (others=>'0') when others;

end Behavioral;
