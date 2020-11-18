----------------------------------------------------------------------------------
-- Lab 6: Radix-4 Multiplier
-- ECE 524/L
-- Engineer: Joel Bailey
--
-- Create Date: 20201105
-- Modified Last: 20201110
-- Module Name: MUL_SHIFT.vhd
-- Description: Async reset, parallel load, 2-bit shift register. Designed for 
--  6-bit 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUL_SHIFT is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           LD: in STD_LOGIC;
           DIN : in STD_LOGIC_VECTOR (5 downto 0);
           DOUT : out STD_LOGIC_VECTOR (1 downto 0));
end MUL_SHIFT;

architecture Behavioral of MUL_SHIFT is

signal REG: STD_LOGIC_VECTOR(5 downto 0);

begin

process(CLK, RST) 
begin
    if RST = '1' then
        REG <= (others=>'0');
    elsif rising_edge(CLK) then
        if LD = '1' then
            REG <= DIN;
        else
            REG <= std_logic_vector(unsigned(REG) srl 2);
        end if;
    end if;
end process;

DOUT <= REG(1 downto 0);

end Behavioral;
