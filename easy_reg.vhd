LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
ENTITY reg IS
 PORT(
	 a : IN std_logic_vector (9 DOWNTO 0); 
	 b : IN std_logic_vector (9 DOWNTO 0); 
	 clk : IN std_logic; 
	 set : in std_logic;
	 mode : IN std_logic_vector ( 2 DOWNTO 0 ); 
	 q : OUT std_logic_vector ( 9 DOWNTO 0 )
 );
-- Declarations
END reg ;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;
ARCHITECTURE reg_arch OF reg IS

function reverse_any_vector (a: in std_logic_vector)
return std_logic_vector is
  variable result: std_logic_vector(a'RANGE);
  alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
begin
  for i in aa'RANGE loop
    result(i) := aa(i);
  end loop;
  return result;
end; -- function reverse_any_vector

signal qq : std_logic_vector (9 downto 0);
BEGIN
 -----------------------------------------------------------------
 process0_proc : PROCESS (clk, set)
 -----------------------------------------------------------------
 BEGIN
	 if (set = '1') then
		qq <= "0000000011";
	 elsif (clk'event and clk = '1') then
		case mode is
			when "000" => qq <= "0000111111";
			when "001" => qq <= reverse_any_vector(b);
			when "010" => qq <= a + conv_std_logic_vector(conv_integer(b) * conv_integer(qq), 10);
			when "011" => qq <= qq + 1;
			when "100" => qq <= qq(1 downto 0) & qq(9 downto 2);
			when "101" => qq <= a xor reverse_any_vector(b);
			when "110" => qq <= b(5 downto 1) & b(9 downto 5);	
			when "111" => qq <= (others => 'Z');
			when others => qq <= qq;		
	 	end case; 
	end if;
 END PROCESS process0_proc;
	q <= qq;
END reg_arch; 
