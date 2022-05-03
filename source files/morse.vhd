------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for morse code transmitter
------------------------------------------------------------
entity morse is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        send    : in std_logic;
        abc_i   : in std_logic_vector(15 - 1 downto 0);  
        LED16_o : out std_logic_vector(3 - 1 downto 0);
        LED17_o  : out std_logic_vector(3 - 1 downto 0)
    );
end entity morse;
------------------------------------------------------------
-- Architecture declaration for morse code transmitter
------------------------------------------------------------
architecture Behavioral of morse is
    
    type t_state is (MEZERA, MEZERA1, MEZERA2, MEZERA3, MEZERA4, MEZERA5,
                     TECKA, TECKA1, TECKA2, TECKA3, TECKA4, TECKA5,
                     CARKA, CARKA1, CARKA2, CARKA3, CARKA4, CRAKA5,
                     LOMITKO,
                     SMYCKA
                     );
                     
    -- Define the signal that uses different states
    signal s_state : t_state;

    -- Internal clock enable
    signal s_en : std_logic;
    
    --Send chosen symbol
   -- signal s_send : std_logic;

    -- Local delay counter
    signal s_cnt : unsigned(4 downto 0);
    
    --Input signal from switch
  --  signal s_abc : std_logic_vector (15 - 1 downto 0):= b"111111111111111";

    -- Specific values for local counter
    constant c_DELAY_3SEC : unsigned(4 downto 0) := b"0_1100";
    constant c_DELAY_1SEC : unsigned(4 downto 0) := b"0_0100";
    constant c_DELAY_05SEC: unsigned(4 downto 0) := b"0_0010";
    constant c_ZERO       : unsigned(4 downto 0) := b"0_0000";

    -- Output values
    constant c_RED        : std_logic_vector(2 downto 0) := b"100";
    constant c_YELLOW     : std_logic_vector(2 downto 0) := b"110";
    constant c_GREEN      : std_logic_vector(2 downto 0) := b"010";
    constant c_NULL       : std_logic_vector(2 downto 0) := b"000";

begin

    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 250 ms (4 Hz). Remember that 
    -- the frequency of the clock signal is 100 MHz.
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 4 -- FOR SIMULATION PURPOSE ONLY !!!
            -- FOR IMPLEMENTATION: g_MAX = 250 ms / (1/100 MHz)
        )
        port map(
            clk   => clk,
            reset => reset, 
            ce_o  => s_en       
        );

    --------------------------------------------------------
    -- p_morse:
    -- The sequential process with synchronous reset and 
    -- clock_enable entirely controls the s_state signal by 
    -- CASE statement.
    --------------------------------------------------------
    p_morse : process(clk)
    begin
        
        
        if rising_edge(clk) then
            if (reset = '1') then   -- Synchronous reset
                s_state <= SMYCKA;   -- Set initial state
                s_cnt   <= c_ZERO;  -- Clear delay counter
           
    ---------------------------------------------------------- A
            elsif (s_en = '1' and abc_i = "100000000000000"  and send = '1')then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.          
              
                case s_state is
                
                    when MEZERA =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= MEZERA1;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when MEZERA1 =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;  
                           
                    when CARKA =>
                        -- Count up to c_DELAY_3SEC
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if; 
                        
                    when MEZERA2 =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                                                  
                     when LOMITKO =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                      when SMYCKA =>
                        -- Count up to c_DELAY_3SEC
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       

                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case; 
                     
    ---------------------------------------------------------- B
            elsif (s_en = '1' and abc_i = "010000000000000"  and send = '1')then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.          
              
                case s_state is
                
                    when MEZERA =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>
                        -- Count up to c_DELAY_3SEC
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;  
                        end if; 
                        
                     when MEZERA1 =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;  
                              
                    when TECKA =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= MEZERA2;
                            -- Reset local counter value
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA2 =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA3 =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if;   
                        
                     when TECKA2 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA4 =>
                        -- Count up to c_DELAY_05SEC
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;   
                        
                     when LOMITKO =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                      when SMYCKA =>
                        -- Count up to c_DELAY_3SEC
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       

                     when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
             
    ---------------------------------------------------------- C   
             elsif (s_en = '1' and abc_i = "001000000000000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;   
                         
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;
             
    ---------------------------------------------------------- D
       elsif (s_en = '1' and abc_i = "000100000000000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                         
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;
       
     ---------------------------------------------------------- E
       elsif (s_en = '1' and abc_i = "000010000000000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                         
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;      
      
     ---------------------------------------------------------- F
       elsif (s_en = '1' and abc_i = "000001000000000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;  
   
     ---------------------------------------------------------- G
       elsif (s_en = '1' and abc_i = "000000100000000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                   
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;     
   
      ---------------------------------------------------------- H
       elsif (s_en = '1' and abc_i = "000000010000000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA3;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA3 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
   
       ---------------------------------------------------------- CH
       elsif (s_en = '1' and abc_i = "000000001000000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA3;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA3 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
   
      ---------------------------------------------------------- I
       elsif (s_en = '1' and abc_i = "000000000100000" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
       ---------------------------------------------------------- J
       elsif (s_en = '1' and abc_i = "100000000000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- K
       elsif (s_en = '1' and abc_i = "010000000000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
   
       ---------------------------------------------------------- L
       elsif (s_en = '1' and abc_i = "001000000000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
   
        ---------------------------------------------------------- M
       elsif (s_en = '1' and abc_i = "000100000000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                               
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;  
   
       ---------------------------------------------------------- N
       elsif (s_en = '1' and abc_i = "000010000000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
   
       ---------------------------------------------------------- O
       elsif (s_en = '1' and abc_i = "000001000000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                      
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
   
        ---------------------------------------------------------- P
       elsif (s_en = '1' and abc_i = "000000100000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- Q
       elsif (s_en = '1' and abc_i = "000000010000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- R
       elsif (s_en = '1' and abc_i = "000000001000001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
         
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- S
       elsif (s_en = '1' and abc_i = "010000000100001" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
         
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- T
       elsif (s_en = '1' and abc_i = "100000000000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
     
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;     
   
        ---------------------------------------------------------- U
       elsif (s_en = '1' and abc_i = "010000000000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
         
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;   
   
        ---------------------------------------------------------- V
       elsif (s_en = '1' and abc_i = "001000000000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;    
         
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- W
       elsif (s_en = '1' and abc_i = "000100000000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if; 
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;       
   
        ---------------------------------------------------------- X
       elsif (s_en = '1' and abc_i = "000010000000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;    
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;       
      
        ---------------------------------------------------------- Y
       elsif (s_en = '1' and abc_i = "000001000000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;    
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- Z
       elsif (s_en = '1' and abc_i = "000000100000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;    
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- LOMITKO (MEZERA)
       elsif (s_en = '1' and abc_i = "000000100000010" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- 0
       elsif (s_en = '1' and abc_i = "100000000000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA3;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA3 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA4;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when CARKA4 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;     
   
        ---------------------------------------------------------- 1
       elsif (s_en = '1' and abc_i = "010000000000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA3;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when CARKA3 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;      
   
        ---------------------------------------------------------- 2
       elsif (s_en = '1' and abc_i = "001000000000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;      
   
        ---------------------------------------------------------- 3
       elsif (s_en = '1' and abc_i = "000100000000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- 4
       elsif (s_en = '1' and abc_i = "000010000000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA3;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA3 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when CARKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;     
   
        ---------------------------------------------------------- 5
       elsif (s_en = '1' and abc_i = "000001000000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when TECKA =>  
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA3;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA3 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA4;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when TECKA4 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;    
   
        ---------------------------------------------------------- 6
       elsif (s_en = '1' and abc_i = "000000100000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA3;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when TECKA3 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;     
   
        ---------------------------------------------------------- 7
       elsif (s_en = '1' and abc_i = "000000010000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA2;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when TECKA2 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;     
   
        ---------------------------------------------------------- 8
       elsif (s_en = '1' and abc_i = "000000001000011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA1;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when TECKA1 =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;      
   
         ---------------------------------------------------------- 9
       elsif (s_en = '1' and abc_i = "000000000100011" and send = '1')then   
                 case s_state is

                    when MEZERA =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when CARKA =>  
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA1;
                            s_cnt <= c_ZERO;
                        end if;

                    when MEZERA1 =>   
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA1;
                            s_cnt <= c_ZERO;
                        end if;
                             
                    when CARKA1 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA2;
                            s_cnt <= c_ZERO;  
                        end if;  
                        
                    when MEZERA2 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA2;
                            s_cnt <= c_ZERO;
                        end if; 
                          
                    when CARKA2 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA3;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA3 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= CARKA3;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when CARKA3 =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA4;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA4 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= TECKA;
                            s_cnt <= c_ZERO;
                        end if;  
                          
                    when TECKA =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= MEZERA5;
                            s_cnt <= c_ZERO;  
                        end if;   
                     
                    when MEZERA5 =>
                        if (s_cnt < c_DELAY_05SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= LOMITKO;
                            s_cnt <= c_ZERO;
                        end if;
            
                    when LOMITKO =>
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if; 
                        
                    when SMYCKA =>
                        if (s_cnt < c_DELAY_3SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SMYCKA;
                            s_cnt <= c_ZERO;
                        end if;                       
               
                    when others =>
                        s_state <= MEZERA;
                        s_cnt   <= c_ZERO;
                end case;         
              
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_morse;

    --------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state
    -- changes and sets the output signals accordingly.
    -- This is an example of a Moore state machine and
    -- therefore the output is set based on the active state.
    --------------------------------------------------------
    p_output_fsm : process(s_state)
    begin
        case s_state is
        
            when TECKA =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;
            when TECKA1 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;
            when TECKA2 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;
            when TECKA3 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;
            when TECKA4 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;   
                             
            when CARKA =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;  
            when CARKA1 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;      
            when CARKA2 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL; 
            when CARKA3 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL; 
            when CARKA4 =>
                LED16_o  <= c_RED;
                LED17_o  <= c_NULL;       
                
            when MEZERA =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_NULL;       
            when MEZERA1 =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_NULL;
            when MEZERA2 =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_NULL;
            when MEZERA3 =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_NULL;   
            when MEZERA4 =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_NULL;
            when MEZERA5 =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_NULL;
                        
            when SMYCKA =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_NULL;  
                
            when LOMITKO =>
                LED16_o  <= c_NULL;
                LED17_o  <= c_YELLOW;  
    
            when others =>
                LED16_o <= c_NULL;
                LED17_o  <= c_NULL;
                
        end case;
    end process p_output_fsm;

end architecture Behavioral;
