----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2025 02:50:18 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( i_A : in STD_LOGIC_VECTOR (7 downto 0);
           i_B : in STD_LOGIC_VECTOR (7 downto 0);
           i_op : in STD_LOGIC_VECTOR (2 downto 0);
           o_result : out STD_LOGIC_VECTOR (7 downto 0);
           o_flags : out STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal s_result : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal s_sum: unsigned(8 downto 0);
begin
    process(i_A, i_B, i_op) -- run process when these change
    begin --set default values for signals
        s_result <= (others => '0');
        s_sum <= (others => '0');
        o_flags <= "0000";
    case i_op is
        when "000" => --Add
            s_sum <= ('0' & unsigned(i_A)) + ('0' & unsigned(i_B));
            s_result <= std_logic_vector(unsigned(i_A) + unsigned(i_B));
        when "001" => --Subtract
            s_sum <= ('0' & unsigned(i_A)) - ('0' & unsigned(i_B));
            s_result <= std_logic_vector(unsigned(i_A) - unsigned(i_B)); 
        when "010" => --And
            s_result <= i_A and i_B;
        when "011" => --Or
            s_result <= i_A or i_B;
        when others =>
            s_result <= (others => '0');
     end case; 
     end process;
     
     o_result <= s_result; --connect signals
      
     --Flags
     o_flags(3) <= s_result(7); --N: negative
     o_flags(2) <= '1' when s_result = "00000000" else '0'; --Z: zero
     o_flags(1) <= s_sum(8) when i_op = "000" else '0';
     o_flags(0) <= '0'; --V: overflow 
                   
end Behavioral;
