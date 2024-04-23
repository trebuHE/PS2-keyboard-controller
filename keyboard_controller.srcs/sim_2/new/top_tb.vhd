--TOP TB-----------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

component top is
    Port ( clk_i : in std_logic;
           rst_i : in std_logic;
           ps2_clk_i : in std_logic;
           ps2_data_i : in std_logic;
           led7_an_o : out std_logic_vector (3 downto 0);
           led7_seg_o : out std_logic_vector (7 downto 0));
end component  top;

signal clk_i : std_logic := '0';
signal rst_i : std_logic := '0';
signal ps2_clk_i : std_logic := '1';
signal ps2_data_i : std_logic := '1';
signal led7_an_o : std_logic_vector (3 downto 0) := "0000";
signal led7_seg_o : std_logic_vector (7 downto 0) := "00000000";

begin

dut : top port map(clk_i => clk_i, rst_i => rst_i, ps2_clk_i => ps2_clk_i, ps2_data_i => ps2_data_i, led7_an_o => led7_an_o, led7_seg_o => led7_seg_o);

clk : process
		constant clk_T : time := 10ns;
    begin
		clk_i <= '1';
		wait for clk_T / 2;
		clk_i <= '0';		
		wait for clk_T / 2;	
    end process;
    
stim : process
    constant kb_clk_T : time := 66.67us;
    constant make_z : std_logic_vector(10 downto 0) := "10000110100";
    constant make_7 : std_logic_vector(10 downto 0) := "10001111010";
    constant break : std_logic_vector(10 downto 0) := "11000011110";
    begin
        wait for 300us;
        
        for i in 0 to 9 loop
            ps2_data_i <= make_7(i);
            wait for 10us;
            ps2_clk_i <= '0';
            wait for kb_clk_T / 2;
            ps2_clk_i <= '1';
            wait for 5us;
            ps2_data_i <= make_7(i+1);
            wait for kb_clk_T / 2;
        end loop;
        ps2_data_i <= '1';
        ps2_clk_i <= '0';
        wait for kb_clk_T / 2;
        ps2_clk_i <= '1';
        wait for kb_clk_T / 2;
        
        wait for 60us;
        rst_i <= '1';
        wait for 10us;
        rst_i <= '0';
        wait for 10us;
        wait for 60us;
        
        for i in 0 to 9 loop
            ps2_data_i <= break(i);
            wait for 10us;
            ps2_clk_i <= '0';
            wait for kb_clk_T / 2;
            ps2_clk_i <= '1';
            wait for 5us;
            ps2_data_i <= break(i+1);
            wait for kb_clk_T / 2;
        end loop;
        
        ps2_data_i <= '1';
        ps2_clk_i <= '0';
        wait for kb_clk_T / 2;
        ps2_clk_i <= '1';
        wait for kb_clk_T / 2;
        
        wait for 60us;
        
        for i in 0 to 9 loop
            ps2_data_i <= make_7(i);
            wait for 10us;
            ps2_clk_i <= '0';
            wait for kb_clk_T / 2;
            ps2_clk_i <= '1';
            wait for 5us;
            ps2_data_i <= make_7(i+1);
            wait for kb_clk_T / 2;
        end loop;
        
        ps2_data_i <= '1';
        ps2_clk_i <= '0';
        wait for kb_clk_T / 2;
        ps2_clk_i <= '1';
        wait for kb_clk_T / 2;
        
        wait for 10ms;
        
        
        wait for 300us;
        
        for i in 0 to 9 loop
            ps2_data_i <= make_z(i);
            wait for 10us;
            ps2_clk_i <= '0';
            wait for kb_clk_T / 2;
            ps2_clk_i <= '1';
            wait for 5us;
            ps2_data_i <= make_z(i+1);
            wait for kb_clk_T / 2;
        end loop;
        ps2_data_i <= '1';
        ps2_clk_i <= '0';
        wait for kb_clk_T / 2;
        ps2_clk_i <= '1';
        wait for kb_clk_T / 2;
        
        wait for 60us;
        rst_i <= '1';
        wait for 10us;
        rst_i <= '0';
        wait for 10us;
        wait for 60us;
        
        for i in 0 to 9 loop
            ps2_data_i <= break(i);
            wait for 10us;
            ps2_clk_i <= '0';
            wait for kb_clk_T / 2;
            ps2_clk_i <= '1';
            wait for 5us;
            ps2_data_i <= break(i+1);
            wait for kb_clk_T / 2;
        end loop;
        
        ps2_data_i <= '1';
        ps2_clk_i <= '0';
        wait for kb_clk_T / 2;
        ps2_clk_i <= '1';
        wait for kb_clk_T / 2;
        
        wait for 60us;
        
        for i in 0 to 9 loop
            ps2_data_i <= make_z(i);
            wait for 10us;
            ps2_clk_i <= '0';
            wait for kb_clk_T / 2;
            ps2_clk_i <= '1';
            wait for 5us;
            ps2_data_i <= make_z(i+1);
            wait for kb_clk_T / 2;
        end loop;
        
        ps2_data_i <= '1';
        ps2_clk_i <= '0';
        wait for kb_clk_T / 2;
        ps2_clk_i <= '1';
        wait for kb_clk_T / 2;
        
        wait for 10ms;
        
    end process;

end Behavioral;
