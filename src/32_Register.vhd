-- *******************************************************************************
-- Entity Name: reg32
-- Description: This entity represents a 32-bit register with reset. 
-- It takes a 32-bit input bit vector (DATAIN), a clock signal (CLK), 
-- and a reset signal (RST). At each rising edge of the clock, 
-- the contents of the register are updated with the value of DATAIN. 
-- When the reset signal is active (high, or '1'), the register 
-- is reset to 0.
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity reg32 is
    port (
        DATAIN : in std_logic_vector(31 downto 0);
        CLK : in std_logic;
        RST : in std_logic;
        DATAOUT : out std_logic_vector(31 downto 0)
    );
end entity reg32;

architecture reg32_arch of reg32 is
begin
    process (CLK, RST)
    begin
        if RST = '1' then
            DATAOUT <= (others => '0');
        elsif rising_edge(CLK) then
            DATAOUT <= DATAIN;
        end if;
    end process;
end architecture reg32_arch;
