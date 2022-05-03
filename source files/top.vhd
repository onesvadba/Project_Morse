----------------------------------------------------------------------------------
-- Company: VUT FEKT
-- Engineer: Fiala Marek, Neradilek Adam, Nesvadba Ondøej, Peška Vojtìch
-- Create Date: 20/04/2022 18:51:26 PM
-- Design Name: Morse
-- Module Name: top - Behavioral
-- Project Name: Morse transmitter
-- Target Devices: Nexys A7-50T
-- Tool Versions: Vivado v2020.1
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTNC      : in STD_LOGIC;
           SW15      : in STD_LOGIC;
           SW        : in STD_LOGIC_VECTOR (15 - 1 downto 0);
           LED16_R   : out STD_LOGIC;
           LED16_G   : out STD_LOGIC;
           LED16_B   : out STD_LOGIC;
           LED17_R   : out STD_LOGIC;
           LED17_G   : out STD_LOGIC;
           LED17_B   : out STD_LOGIC;          
           CA        : out STD_LOGIC;
           CB        : out STD_LOGIC;
           CC        : out STD_LOGIC;
           CD        : out STD_LOGIC;
           CE        : out STD_LOGIC;
           CF        : out STD_LOGIC;
           CG        : out STD_LOGIC;
           AN        : out STD_LOGIC_VECTOR (7 downto 0);
           LED       : out STD_LOGIC_VECTOR (15 - 1 downto 0));
end top;

architecture Behavioral of top is

begin
    --------------------------------------------------------
    -- Instance (copy) of morse entity
    morse : entity work.morse
        port map(
            clk   => CLK100MHZ,
            reset => BTNC,  
            abc_i => SW,  
            send => SW15,   
            LED16_o(2) => LED16_R,
            LED16_o(1) => LED16_G,
            LED16_o(0) => LED16_B,
            LED17_o(2) => LED17_R,
            LED17_o(1) => LED17_G,
            LED17_o(0) => LED17_B
            );
      
     -- Instance (copy) of hex_7seg entity       
     hex2seg : entity work.hex_7seg
        port map(
            abc_i    => SW,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );        
            
    -- Connect one common anode to 3.3V
    AN <= b"1111_0111";

    -- Display input value on LEDs
    LED(15 - 1 downto 0) <= SW;           
        
end architecture Behavioral;
