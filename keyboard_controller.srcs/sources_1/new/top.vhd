--TOP------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk_i : in std_logic;
           rst_i : in std_logic;
           ps2_clk_i : in std_logic;
           ps2_data_i : in std_logic;
           led7_an_o : out std_logic_vector (3 downto 0);
           led7_seg_o : out std_logic_vector (7 downto 0));
end top;

architecture Behavioral of top is

component filter is
    Port ( input : in std_logic;
           rst_i : in std_logic;
           clk_i : in std_logic;
           output : out std_logic);
end component filter;

component reciver is
    Port ( clk_i : in std_logic;
           rst_i : in std_logic;
           ps2_clk_i : in std_logic;
           ps2_data_i : in std_logic;
           key_value_o : out std_logic_vector(7 downto 0));
end component reciver;

component encoder is  
    Port ( clk_i : in std_logic;
          rst_i : in std_logic;
          to_encode_i : in std_logic_vector (7 downto 0);
          seg_encoded_o : out std_logic_vector (7 downto 0);
          led7_an_o : out std_logic_vector (3 downto 0));
end component encoder;

signal ps2_clk_filtered : std_logic;
signal ps2_data_filtered : std_logic; 
signal key_value : std_logic_vector(7 downto 0);

begin

clk_filter : filter port map (input => ps2_clk_i, rst_i => rst_i, clk_i => clk_i, output => ps2_clk_filtered);
data_filter : filter port map (input => ps2_data_i, rst_i => rst_i, clk_i => clk_i, output => ps2_data_filtered);
ps2_reciver : reciver port map (clk_i => clk_i, rst_i => rst_i, ps2_clk_i => ps2_clk_filtered, ps2_data_i => ps2_data_filtered, key_value_o => key_value);
seg_encoder : encoder port map (clk_i => clk_i, rst_i => rst_i, to_encode_i => key_value, seg_encoded_o => led7_seg_o, led7_an_o => led7_an_o);
 

end Behavioral;
