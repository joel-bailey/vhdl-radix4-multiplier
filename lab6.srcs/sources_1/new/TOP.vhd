----------------------------------------------------------------------------------
-- Lab 6: Radix-4 Multiplier
-- ECE 524/L
-- Engineer: Joel Bailey
--
-- Create Date: 20201105
-- Modified Last: 20201110
-- Module Name: TOP.vhd
-- Description: Top level to instantiate each component. Counter added to enable output
--  on the 3rd cycle of each operation when the product is ready.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           LD : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (9 downto 0); -- 10 bit mux
           X : in STD_LOGIC_VECTOR (5 downto 0); --6 bit shift
           PRODUCT : out STD_LOGIC_VECTOR(15 downto 0));
end TOP;

architecture Behavioral of TOP is

signal MUX_OUT, PRODOUT, PRODIN : STD_LOGIC_VECTOR(11 downto 0);
signal SEL : STD_LOGIC_VECTOR(1 downto 0);
signal OE : STD_LOGIC;
signal COUNT : integer;

begin

ADDER: entity work.ADDER(Behavioral)
    port map(A=>MUX_OUT, B=>PRODOUT, SUM=>PRODIN);
 
SHIFTER: entity work.MUL_SHIFT(Behavioral)
    port map(CLK=>CLK, RST=>RST, LD=>LD, DIN=>X, DOUT=>SEL);
    
MUX: entity work.MUX(Behavioral)
    port map(A=>A, SEL=>SEL, MUX_OUT=>MUX_OUT);
    
PROD: entity work.PROD_SHIFT(Behavioral)
    port map(CLK=>CLK, RST=>RST, DIN=>PRODIN, ACCOUT=>PRODOUT, PRODUCT=>PRODUCT, OE=>OE);
    
OUTCOUNT: process(CLK, RST) begin
    if RST = '1' then
        COUNT <= 0;
    elsif rising_edge(CLK) then
        if LD = '1' or COUNT = 3 then
            COUNT <= 0;
        else
            COUNT <= COUNT + 1;
        end if;
    end if;
end process;

with COUNT select 
    OE <= '1' when 3,
          '0' when others;
    
end Behavioral;
