-- *******************************************************************************
-- Entity Name: RAM_64x32
-- Description: This entity represents a 64-word by 32-bit single-clock RAM memory. 
-- It takes a 6-bit address (addr), a write enable signal (we), and a 32-bit input data (DATAIN).
-- At each rising edge of the clock, if write enable signal is high, the word at the address 
-- specified by 'addr' is updated with the value of 'DATAIN'.
-- Regardless of the write operation, at each clock cycle, the value of the word at the 
-- address 'addr' is output on 'DATAOUT'.
-- It provides a simple data memory model suitable for use in a basic processor design.
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RAM_64x32 is
    port (
        clk : in std_logic;
        we : in std_logic; -- write enable
        addr : in std_logic_vector(5 downto 0); -- 6 bit address for 64 words
        DATAIN : in std_logic_vector(31 downto 0); -- data input
        DATAOUT : out std_logic_vector(31 downto 0) -- data output
    );
end RAM_64x32;

architecture Behavioral of RAM_64x32 is
    type memory_type is array (0 to 63) of std_logic_vector(31 downto 0);
    signal memory : memory_type;
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                memory(conv_integer(addr)) <= DATAIN;
            end if;
            DATAOUT <= memory(conv_integer(addr));
        end if;
    end process;
end Behavioral;
