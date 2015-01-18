library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package amd_iss is
	type std_logic_v4 is array(3 downto 0) of std_logic;
	type std_logic_v9 is array(8 downto 0) of std_logic;

	type AMD_PORT is record
		a : std_logic_v4;
		b : std_logic_v4;
		d : std_logic_v4;
		i : std_logic_v9;
		cin : std_logic;
		r0 : std_logic;
		r3 : std_logic;
		q0 : std_logic;
		q3 : std_logic;
		noe : std_logic;
		y : std_logic_v4;
		cout : std_logic;
		np : std_logic;
		ng : std_logic;
		sign : std_logic;
		zero : std_logic;
		ovr : std_logic;
	end record;

	function gen_alea_input return AMD_PORT;

	procedure amd_run (i : AMD_PORT);
	--function amd_run (i : AMD_IN) return AMD_OUT;
	attribute foreign of amd_run : procedure is "VHPIDIRECT amd_run";
end amd_iss;

package body amd_iss is
	procedure amd_run (i : AMD_PORT) is
	--function amd_run (i : AMD_IN) return AMD_OUT is
	begin
		assert false severity failure;
	end amd_run;

	function gen_alea_input return AMD_PORT is
		variable alea_std : std_logic_vector (31 downto 0);
		variable val_in : AMD_PORT;

	begin
		alea_std := std_logic_vector(TO_UNSIGNED (rand, 32));

		val_in.a := std_logic_v4(alea_std(3 downto 0));
		val_in.b := std_logic_v4(alea_std(7 downto 4));
		val_in.d := std_logic_v4(alea_std(11 downto 8));
		val_in.i := std_logic_v9(alea_std(20 downto 12));
		val_in.cin := alea_std(21);

		if ( (val_in.i(8 downto 6) = O"4") or (val_in.i(8 downto 6) = O"5")) then
			val_in.q3 := alea_std(22);
			val_in.r3 := alea_std(23);
		else
			val_in.q3 := 'Z';
			val_in.r3 := 'Z';
		end if;

		if ( (val_in.i(8 downto 6) = O"6") or (val_in.i(8 downto 6) = O"7")) then
			val_in.q0 := alea_std(24);
			val_in.r0 := alea_std(25);
		else
			val_in.q0 := 'Z';
			val_in.r0 := 'Z';
		end if;

		val_in.noe := alea_std(26);

		return val_in;
	end gen_alea_input;
end amd_iss;
