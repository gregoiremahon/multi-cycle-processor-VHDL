library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banc_registres is
    port (
        clk, rst: in std_logic;
        w: in std_logic_vector(31 downto 0); -- writing input
        ra, rb, rw: in std_logic_vector(3 downto 0); -- adress
        we: in std_logic; -- writing : '1', else : '0'
        a, b: out std_logic_vector(31 downto 0) -- outputs, reading a and b values from registers
    );
end entity banc_registres;

architecture behavior of banc_registres is

    -- init of the registers function [given by UPMC project subject]
    type table is array (15 downto 0) of std_logic_vector(31 downto 0);
    function init_banc return table is
        variable result : table;
    begin
        for i in result'range loop
            result(i) := (others => '0');
        end loop;

        result(15) := x"00000030";

        return result;
    end init_banc;

    -- Declaration and initialization of a 16x32 bits register file named Banc
    -- The register file is declared as a table of std_logic_vectors
    -- The initialization of the register file is done using the init_banc function, which sets all registers to 0 except for the last one (index 15) which is set to 0x00000030
    signal Banc : table := init_banc;


begin
    process (clk, rst)
    begin
		-- reset the register file using the function below when reset is HIGH
    if rst = '1' then 
    	banc <= init_banc; 
    elsif rising_edge(clk) then
        if we = '1' then
        	banc(to_integer(unsigned(rw))) <= w;
	end if;
    end if;
    end process;
           
    a <= banc(to_integer(unsigned(ra)));
    b <= banc(to_integer(unsigned(rb)));

end architecture behavior;