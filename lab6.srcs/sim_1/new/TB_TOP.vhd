----------------------------------------------------------------------------------
-- Lab 6: Radix-4 Multiplier
-- ECE 524/L
-- Engineer: Joel Bailey
--
-- Create Date: 20201105
-- Modified Last: 20201110
-- Module Name: TB_TOP.vhd
-- Description: Test bench for the Radix-4 multiplier. Vectors tested:
--  A=60 X=60, 60 * 60 = 3600
--  A=1023 X=63, 1023 * 63 = 64449
--  A=100 X=0, 100 * 0 = 0
--  A=500 X=1, 500 * 1 = 500
--  A=0 X=60, 0 * 60 = 0
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_TOP is
end TB_TOP;

architecture Behavioral of TB_TOP is

signal CLK, RST, LD : STD_LOGIC;
signal A : STD_LOGIC_VECTOR (9 downto 0);
signal X : STD_LOGIC_VECTOR (5 downto 0);
signal PRODUCT : STD_LOGIC_VECTOR(15 downto 0);

constant CP : time := 20 ns;

begin

DUT: entity work.TOP(Behavioral)
    port map(CLK=>CLK, RST=>RST, LD=>LD, A=>A, X=>X, PRODUCT=>PRODUCT);
    
CLOCK: process begin
    CLK <= '0';
    wait for CP / 2;
    CLK <= '1';
    wait for CP / 2;
end process;


VECTORS: process begin
    RST<='1';
    wait for CP;
    RST<='0'; LD<='1'; 
    A<=std_logic_vector(to_unsigned(60,10));
    X<=std_logic_vector(to_unsigned(60,6));
    wait for CP;
    LD<='0';
    wait for CP * 3;
    RST<='1';
    wait for CP;
    RST<='0'; LD<='1'; 
    A<=std_logic_vector(to_unsigned(1023,10));
    X<=std_logic_vector(to_unsigned(63,6));
    wait for CP;
    LD<='0';
    wait for CP * 3;
    RST<='1';
    wait for CP;
    RST<='0'; LD<='1'; 
    A<=std_logic_vector(to_unsigned(100,10));
    X<=std_logic_vector(to_unsigned(0,6));
    wait for CP;
    LD<='0';
    wait for CP * 3;
    RST<='1';
    wait for CP;
    RST<='0'; LD<='1'; 
    A<=std_logic_vector(to_unsigned(500,10));
    X<=std_logic_vector(to_unsigned(1,6));
    wait for CP;
    LD<='0';
    wait for CP * 3;
    RST<='1';
    wait for CP;
    RST<='0'; LD<='1'; 
    A<=std_logic_vector(to_unsigned(0,10));
    X<=std_logic_vector(to_unsigned(60,6));
    wait for CP;
    LD<='0';
    wait;
end process;

end Behavioral;
