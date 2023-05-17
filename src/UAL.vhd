library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ual is
    port (
        op : in std_logic_vector(1 downto 0);
        a, b : in std_logic_vector(31 downto 0);
        s : out std_logic_vector(31 downto 0);
        n : out std_logic
    );
end entity ual;

architecture behavior of ual is
begin
    process (op, a, b)
        variable temp : signed(31 downto 0);
        variable result : std_logic_vector(31 downto 0);
    begin
        case op is
            when "00" =>
                temp := signed(a) + signed(b);
                result := std_logic_vector(temp);
            when "01" =>
                result := b;
            when "10" =>
                temp := signed(a) - signed(b);
                result := std_logic_vector(temp);
            when "11" =>
                result := a;
	    when others =>
            	-- operation is not defined
            	null;
        end case;
        
        s <= result;
        
        if signed(result) < 0 then
            n <= '1';
        else
            n <= '0';
        end if;
    end process;
end architecture behavior;