-- *******************************************************************************
-- Entity Name: mux4to1
-- Description: This entity represents a 4-to-1 multiplexer. 
-- It takes four 32-bit input bit vectors (A, B, C, D) 
-- and a 2-bit input bit vector (COM). Depending on the value of COM, it passes 
-- one of the inputs to the output S.
-- If COM = "00", then A is passed to S.
-- If COM = "01", then B is passed to S.
-- If COM = "10", then C is passed to S.
-- If COM = "11", then D is passed to S.
-- In the case where COM is some other value, S is put into an indeterminate state (signaled by 'X').
-- Authors: MAHON and LELONG
-- *******************************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
    port (
        A : in std_logic_vector(31 downto 0);
        B : in std_logic_vector(31 downto 0);
        C : in std_logic_vector(31 downto 0);
        D : in std_logic_vector(31 downto 0);
        COM : in std_logic_vector(1 downto 0);
        S : out std_logic_vector(31 downto 0)
    );
end entity mux4to1;

architecture mux4to1_arch of mux4to1 is
begin
    process (A, B, C, D, COM)
    begin
        case COM is
            when "00" =>
                S <= A;
            when "01" =>
                S <= B;
            when "10" =>
                S <= C;
            when "11" =>
                S <= D;
            when others => -- impossible but mandatory in VHDL
                S <= (others => 'X');
        end case;
    end process;
end architecture mux4to1_arch;
