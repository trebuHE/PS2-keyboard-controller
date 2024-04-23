--ENCODER--------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity encoder is
    Port ( clk_i : in std_logic;
          rst_i : in std_logic;
          to_encode_i : in std_logic_vector (0 to 7);
          seg_encoded_o : out std_logic_vector (7 downto 0);
          led7_an_o : out std_logic_vector (3 downto 0));
end encoder;

architecture Behavioral of encoder is
    function Encode (value : std_logic_vector(7 downto 0) := "00000000")
                     return std_logic_vector is                     
    begin
        case value is 
            when x"45" => return "00000011"; -- 0
            when x"16" => return "10011111"; -- 1
            when x"1E" => return "00100101"; -- 2
            when x"26" => return "01100001"; -- 3
            when x"25" => return "10011001"; -- 4
            when x"2E" => return "01001001"; -- 5
            when x"36" => return "01000001"; -- 6
            when x"3D" => return "00011111"; -- 7
            when x"3E" => return "00000001"; -- 8
            when x"46" => return "00001001"; -- 9
            when x"1C" => return "00010001"; -- A (10)
            when x"32" => return "11000001"; -- B (11) 
            when x"21" => return "01100011"; -- C (12)
            when x"23" => return "10000101"; -- D (13)
            when x"24" => return "01100001"; -- E (14)
            when x"2B" => return "01110001"; -- F (15)
            when others => return "11111111";
        end case;
    end function;
    
begin
     process (rst_i, clk_i)
        variable encoded : std_logic_vector (7 downto 0) := x"ff";
     begin
        if rst_i = '1' then
            seg_encoded_o <= x"ff";
        elsif rising_edge(clk_i) then     
            encoded := Encode(value => to_encode_i); 
            seg_encoded_o <= encoded;
        end if;     
     end process;
     
     led7_an_o <= "0111";
 
end Behavioral;