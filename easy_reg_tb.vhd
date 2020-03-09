LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity TB is
end entity TB;

architecture TB_arch of TB is
	signal a : std_logic_vector (9 downto 0) := "0000000100";
	signal b : std_logic_vector (9 downto 0) := "0000000010";
	signal clk : std_logic := '0';
	signal set : std_logic := '0';
	signal mode : std_logic_vector (2 downto 0);
	signal q1 : std_logic_vector (9 downto 0);
begin
	G1: entity work.reg(reg_arch) port map(a => a, b => b, clk => clk, set => set, mode => mode, q => q1);
process 
begin
	for i in 1 to 300 loop
		clk <= not clk;
		wait for 20 ns;		
	end loop;
	wait;
end process;

	mode <= "000", "001" after 200 ns, "010" after 400 ns, "011" after 600 ns, "100" after 800 ns, "101" after 1000 ns, 
		"110" after 1200 ns, "111" after 1400 ns;
	a <= "0101010101" after 950 ns;
	b <= "1010101010" after 950 ns;
	set <= '0', '1' after 150 ns, '0' after 180 ns;

end architecture;
