library ieee;
library STD;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.standard.all;

entity fsm is
	port(
		clk      : in  std_logic                    := '0';
		vdd      : in  std_logic                    := '1';
		vss      : in  std_logic                    := '0';
		code     : in  std_logic_vector(3 downto 0) := "0000";
		day_time : in  std_logic                    := '0';
		rst      : in  std_logic                    := '0';
		door     : out std_logic                    := '0';
		alarm    : out std_logic                    := '0'
	);
end entity fsm;

ARCHITECTURE moore OF fsm IS
	type state_type is (reset, start, U6, UA, U0, U5, finish, error);
	SIGNAL current_state : state_type := start;
	SIGNAL next_state    : state_type := start;
BEGIN
	cs : PROCESS(clk)
	BEGIN
		IF (clk = '1' and not clk'stable) THEN
			current_state <= next_state;
		END IF;
	END PROCESS cs;

	ns : PROCESS(rst, current_state, code, day_time)
	BEGIN
		IF rst = '1' THEN
			next_state <= reset;
		end if;
		case current_state is
			when start =>
				if code'event then
					if code = "0010" then
						next_state <= U6;
					elsif (day_time = '1' and code = "1101") then
						next_state <= finish;
					else
						next_state <= error;
					end if;
				end if;
			when U6 =>
				if code = "0110" then
					next_state <= UA;
				elsif (day_time = '1' and code = "1101") then
					next_state <= finish;
				else
					next_state <= error;
				end if;
			when UA =>
				if code = "1010" then
					next_state <= U0;
				elsif (day_time = '1' and code = "1101") then
					next_state <= finish;
				else
					next_state <= error;
				end if;
			when U0 =>
				if code = "0000" then
					next_state <= U5;
				elsif (day_time = '1' and code = "1101") then
					next_state <= finish;
				else
					next_state <= error;
				end if;
			when U5 =>
				if code = "0101" then
					next_state <= finish;
				elsif (day_time = '1' and code = "1101") then
					next_state <= finish;
				else
					next_state <= error;
				end if;
			when finish =>
				door       <= '1';
				next_state <= reset;
			when error =>
				alarm      <= '1';
				next_state <= reset;
			when reset =>
				door       <= '0';
				alarm      <= '0';
				next_state <= start;
			when others =>
				assert (false) report "illegal state" severity error;

		end case;
	END PROCESS ns;
END ARCHITECTURE moore;
