--FILTER--------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity filter is
    Port ( input : in std_logic;
           rst_i : in std_logic;
           clk_i : in std_logic;
           output : out std_logic);
end filter;

architecture Behavioral of filter is
begin
    process(clk_i, rst_i)
        variable filter_bufor : std_logic_vector (7 downto 0) := x"00";
    begin
        if rst_i = '1' then
            filter_bufor := x"ff";
            output <= '1';
        elsif rising_edge(clk_i) then
            filter_bufor(7) := input;
            filter_bufor(6 downto 0) := filter_bufor(7 downto 1);
            
            if filter_bufor = x"00" then
                output <= '0';
            elsif filter_bufor = x"ff" then
                output <= '1';
            end if;         
        end if;     
    end process;

end Behavioral;
