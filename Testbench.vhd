library ieee;
library STD;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.standard.all;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE test OF testbench IS

	COMPONENT fsm IS
		port(
			clk      : in  std_logic;
			vdd      : in  std_logic;
			vss      : in  std_logic;
			code     : in  std_logic_vector(3 downto 0);
			day_time : in  std_logic;
			rst      : in  std_logic;
			door     : out std_logic;
			alarm    : out std_logic
		);
	END COMPONENT fsm;

	FOR dut : fsm USE ENTITY WORK.fsm(moore);

	SIGNAL clk      : std_logic                    := '0';
	SIGNAL vdd      : std_logic                    := '1';
	SIGNAL vss      : std_logic                    := '0';
	SIGNAL code     : std_logic_vector(3 downto 0) := "0000";
	signal day_time : std_logic                    := '0';
	SIGNAL rst      : std_logic                    := '0';
	SIGNAL door     : std_logic                    := '0';
	signal alarm    : std_logic                    := '0';

	-- Constants and Clock period definitions
	constant clk_period : time := 20 ns;
BEGIN

	-- Instantiate the Device Under Test (DUT)
	dut : fsm PORT MAP(clk, vdd, vss, code, day_time, rst, door, alarm);

	-- Clock process definitions( clock with 50% duty cycle )
	clk_process : process
	begin
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;
	end process;

	-- Stimulus process, refer to clock signal
	stim_proc : PROCESS IS
	BEGIN
		code     <= "0010";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0110";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "1010";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0101";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '1' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "1101";
		day_time <= '1';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '1' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0010";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0010";
		day_time <= '1';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "1101";
		day_time <= '1';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '1' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "1111";
		day_time <= '1';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '1') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		code     <= "0000";
		day_time <= '0';
		rst      <= '0';
		wait for 11 ns;
		Assert (door = '0' and alarm = '0') Report "wrong exp. output"
		Severity Error;
		wait for 9 ns;

		WAIT;                           -- stop process simulation run

	END PROCESS;
END ARCHITECTURE test;

