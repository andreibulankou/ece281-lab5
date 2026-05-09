----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:42:49 PM
-- Design Name: 
-- Module Name: controller_fsm - FSM
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controller_fsm is
    Port ( i_reset : in STD_LOGIC;
           i_adv : in STD_LOGIC;
           o_cycle : out STD_LOGIC_VECTOR (3 downto 0));
end controller_fsm;

architecture FSM of controller_fsm is
    type state_type is (S0, S1, S2, S3); --declare states
    signal s_state : state_type := S0;
begin
    process(i_adv)
    begin
        if rising_edge(i_adv) then
            if i_reset = '1' then
                s_state <= S0;
            else 
                case s_state is
                    when S0 =>
                        s_state <= S1;
                    when S1 =>
                        s_state <= S2;
                    when S2 => 
                        s_state <= S3;
                    when S3 =>
                        s_state <= S0;
                    when others =>
                        s_state <= S0;
                end case;
            end if;
           end if;
          end process;
       
       with s_state select
           o_cycle <= "0001" when S0,
                      "0010" when S1,
                      "0100" when S2,
                      "1000" when S3,
                      "0001" when others;
                        
end FSM;
