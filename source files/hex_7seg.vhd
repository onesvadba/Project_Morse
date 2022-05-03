------------------------------------------------------------
--
-- Template for 7-segment display decoder.
-- Nexys A7-50T, Vivado v2020.1, EDA Playground
--
-- Copyright (c) 2018-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for seven7-segment display decoder
------------------------------------------------------------
entity hex_7seg is
    port(
        abc_i : in  std_logic_vector(15 - 1 downto 0);
        seg_o : out std_logic_vector(6 downto 0)
    );
end entity hex_7seg;

------------------------------------------------------------
-- Architecture body for seven-segment display decoder
------------------------------------------------------------
architecture Behavioral of hex_7seg is
begin
    --------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common
    -- Anode) decoder. Any time "hex_i" is changed, the process
    -- is "executed". Output pin seg_o(6) controls segment A,
    -- seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        +-+|  |   ...   segment G
    --          ||+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------
    p_7seg_decoder : process(abc_i)
    begin
        case abc_i is
            when "100000000000000" =>
                seg_o <= "0001000"; -- A
            when "010000000000000" =>
                seg_o <= "1100000"; -- B
            when "001000000000000" =>
                seg_o <= "0110001"; -- C
            when "000100000000000" =>
                seg_o <= "1000010"; -- D
            when "000010000000000" =>
                seg_o <= "0110000"; -- E
            when "000001000000000" =>
                seg_o <= "0111000"; -- F
            when "000000100000000" =>
                seg_o <= "0100001"; -- G
            when "000000010000000" =>
                seg_o <= "1001000"; -- H
            when "000000001000000" =>
                seg_o <= "1110010"; -- CH              
            when "000000000100000" =>
                seg_o <= "1111001"; -- I
                
            when "100000000000001" =>
                seg_o <= "1000011"; -- J
            when "010000000000001" =>
                seg_o <= "0101000"; -- K
            when "001000000000001" =>           
                seg_o <= "1110001"; -- L
            when "000100000000001" =>
                seg_o <= "0010101"; -- M
            when "000010000000001" =>
                seg_o <= "1101010"; -- N
            when "000001000000001" =>
                seg_o <= "0000001"; -- O                
            when "000000100000001" =>
                seg_o <= "0011000"; -- P
            when "000000010000001" =>
                seg_o <= "0001100"; -- Q              
            when "000000001000001" =>
                seg_o <= "1111010"; -- R
            when "010000000100001" =>
                seg_o <= "0100100"; -- S
                
            when "100000000000010" =>
                seg_o <= "1110000"; -- T
            when "010000000000010" =>
                seg_o <= "1000001"; -- U
            when "001000000000010" =>
                seg_o <= "1010101"; -- V
            when "000100000000010" =>
                seg_o <= "1000000"; -- W
            when "000010000000010" =>
                seg_o <= "0110110"; -- X
            when "000001000000010" =>
                seg_o <= "1000100"; -- Y
            when "000000100000010" =>
                seg_o <= "0010010"; -- Z
            when "000000010000010" =>
                seg_o <= "1110111"; -- MEZERA

                            
            when "100000000000011" =>
                seg_o <= "0000001"; -- 0
            when "010000000000011" =>
                seg_o <= "1001111"; -- 1
            when "001000000000011" =>
                seg_o <= "0010010"; -- 2
            when "000100000000011" =>
                seg_o <= "0000110"; -- 3
            when "000010000000011" =>
                seg_o <= "1001100"; -- 4
            when "000001000000011" =>
                seg_o <= "0100100"; -- 5
            when "000000100000011" =>
                seg_o <= "0100000"; -- 6
            when "000000010000011" =>
                seg_o <= "0001111"; -- 7
            when "000000001000011" =>
                seg_o <= "0000000"; -- 8
            when "000000000100011" =>
                seg_o <= "0000100"; -- 9		
            when others =>
                seg_o <= "1111111"; -- nic
        end case;
    end process p_7seg_decoder;

end architecture Behavioral;
