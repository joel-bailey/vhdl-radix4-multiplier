----------------------------------------------------------------------------------
-- Lab 6: Radix-4 Multiplier
-- ECE 524/L
-- Engineer: Joel Bailey
--
-- Create Date: 20201105
-- Modified Last: 20201110
-- Module Name: PROD_SHIFT.vhd
-- Description: Partial product register. On the clock, the output of the Addder
--  is set into the 12 MSB of the register, with the remaining bits being shifted 2
--  positions to the right.
--  2 Output: 1 has a logical right shift for the operation in the Adder and the
--  other is the product output and is tied to a 3 cycle counter in the top for OE
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PROD_SHIFT is
    Generic(WIDTH : integer := 16);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           OE : in STD_LOGIC;
           DIN : in STD_LOGIC_VECTOR (11 downto 0);
           ACCOUT : out STD_LOGIC_VECTOR (11 downto 0);
           PRODUCT : out STD_LOGIC_VECTOR (15 downto 0));
end PROD_SHIFT;

architecture Behavioral of PROD_SHIFT is

signal REG : STD_LOGIC_VECTOR (15 downto 0);

begin

--async reset
process(CLK, RST) begin
    if RST = '1' then
        REG <= (others=>'0');
    elsif rising_edge(CLK) then
        --Shift out the 2 LSB of REG
        REG <= DIN & REG(5 downto 2);
    end if;
end process;

--Accumulation out is shifted 2 bits to the right for the operation
ACCOUT <= std_logic_vector(unsigned(REG(15 downto 4)) srl 2);

--When output enable is high, the product is ready
with OE select
    PRODUCT <= REG when '1',
               (others=>'Z') when others;

end Behavioral;
