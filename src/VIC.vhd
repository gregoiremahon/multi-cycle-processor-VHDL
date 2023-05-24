-- *******************************************************************************
-- Entity Name: VIC (vectorized interrupt controller)
-- Description: This entity represents a Vector Interrupt Controller (VIC). It 
-- allows the main program to be interrupted if either of the two interrupt requests
-- (IRQ0 and IRQ1) is active.
-- It samples the values of IRQ0 and IRQ1 to know the current and previous values
-- of these two signals. If a rising edge is detected on any of these signals,
-- it sets a corresponding IRQ0_memo or IRQ1_memo signal high, signaling an interrupt request.
-- IRQ0_memo and IRQ1_memo remain high until an acknowledgment on the IRQ_SERV input is received.
-- If there are no interrupt requests, VICPC is forced to 0. 
-- If IRQ0_memo = 1, the VICPC output is set to 0x9.
-- If IRQ1_memo = 1, the VICPC output is set to 0x15.
-- IRQ0 has priority over IRQ1. The IRQ output sent to the MAE is a logical OR
-- between IRQ1_memo and IRQ0_memo.
-- Authors: MAHON and LELONG
-- *******************************************************************************


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity VIC is
    port (
        CLK : in std_logic;
        RESET : in std_logic;
        IRQ_SERV : in std_logic;
        IRQ0, IRQ1 : in std_logic;
        IRQ : out std_logic;
        VICPC : out std_logic_vector(31 downto 0)
    );
end VIC;

architecture Behavioral of VIC is
    signal IRQ0_prev, IRQ1_prev, IRQ0_memo, IRQ1_memo : std_logic;
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            IRQ0_prev <= '0';
            IRQ1_prev <= '0';
            IRQ0_memo <= '0';
            IRQ1_memo <= '0';
        elsif rising_edge(CLK) then
            IRQ0_prev <= IRQ0;
            IRQ1_prev <= IRQ1;

            -- Detect rising edge on IRQ0
            if IRQ0 = '1' and IRQ0_prev = '0' then
                IRQ0_memo <= '1';
            end if;

            -- Detect rising edge on IRQ1
            if IRQ1 = '1' and IRQ1_prev = '0' then
                IRQ1_memo <= '1';
            end if;

            -- Reset IRQ0_memo and IRQ1_memo if IRQ_SERV is received
            if IRQ_SERV = '1' then
                IRQ0_memo <= '0';
                IRQ1_memo <= '0';
            end if;
        end if;
    end process;

    -- Generate IRQ signal
    IRQ <= IRQ0_memo or IRQ1_memo;

    -- Set VICPC output based on IRQ0_memo and IRQ1_memo
    process(IRQ0_memo, IRQ1_memo)
    begin
        if IRQ0_memo = '1' then
            VICPC <= x"00000009"; -- Set to address 0x9
        elsif IRQ1_memo = '1' then
            VICPC <= x"00000015"; -- Set to address 0x15
        else
            VICPC <= x"00000000"; -- Set to 0 if no interrupt
        end if;
    end process;
end Behavioral;
