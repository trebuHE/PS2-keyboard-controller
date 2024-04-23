--RECIVER-----------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reciver is
    Port ( clk_i : in std_logic;
           rst_i : in std_logic;
           ps2_clk_i : in std_logic;
           ps2_data_i : in std_logic;
           key_value_o : out std_logic_vector(7 downto 0));
end reciver;

architecture Behavioral of reciver is
    type type_state is (start, wait_clk_low, wait_clk_high, get_key);
    signal state : type_state;
    signal key_value_s : std_logic_vector(7 downto 0);
begin

    process(rst_i, clk_i)
        constant BIT_COUNT_MAX : integer := 11;
        variable bit_count : integer := 0;
        variable shift : std_logic_vector(10 downto 0) := (others => '0');
        
    begin
        if rst_i = '1' then
            bit_count := 0;
            shift := (others => '0');
            key_value_s <= (others => '0');
            state <= start;
        elsif rising_edge(clk_i) then 
            case state is
                when start =>
                    if ps2_data_i = '1' then
                        state <= start;
                    elsif ps2_data_i = '0' then
                        state <= wait_clk_low;
                    end if;
                    
                when wait_clk_low =>
                    if bit_count < BIT_COUNT_MAX then
                        if ps2_clk_i = '1' then
                            state <= wait_clk_low;
                        elsif ps2_clk_i = '0' then
                            shift := ps2_data_i & shift(10 downto 1);
                            state <= wait_clk_high;
                        end if;
                    elsif bit_count >= BIT_COUNT_MAX then
                        state <= get_key;
                    end if;
                    
                when wait_clk_high =>
                    if ps2_clk_i = '0' then
                        state <= wait_clk_high;
                    elsif ps2_clk_i = '1' then
                        bit_count := bit_count + 1;
                        state <= wait_clk_low;
                    end if;
                    
                when get_key =>
                    key_value_s <= shift(8 downto 1);
                    bit_count := 0;
                    shift := (others => '0');
                    state <= start;
                 end case;
        end if;
    end process;
    
    key_value_o <= key_value_s;
    
end Behavioral;
