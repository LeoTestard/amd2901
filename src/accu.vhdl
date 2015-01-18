library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accu is port (
    clk : in std_logic;

    q_shift  : in  std_logic_vector (2 downto 0);
    q_input  : in  std_logic_vector (3 downto 0);
    q_output : out std_logic_vector (3 downto 0);

    q0_in  : in  std_logic;
    q3_in  : in  std_logic;
    q0_out : out std_logic;
    q3_out : out std_logic
); end accu;

architecture behavioural of accu is
    -- Values of the 2 LSB of Destination control that indicate
    -- whether the Q register input should be its own output, shifter,
    -- or the output of the ALU
    constant Q_WRITE_SHIFT_LEFT  : std_logic_vector (1 downto 0) := "11";
    constant Q_WRITE_SHIFT_RIGHT : std_logic_vector (1 downto 0) := "10";

    signal reg_we  : std_logic;
    signal reg_in  : std_logic_vector (3 downto 0);
    signal reg_out : std_logic_vector (3 downto 0);
begin
    -- accumulator write-enable
    reg_we <= '1' when q_shift (0) = '0' and q_shift (2 downto 1) /= "01" ELSE '0';

    -- value that will be written into the accumulator
    with q_shift (2 downto 1) select reg_in <=
        q3_in & reg_out (3 downto 1) when Q_WRITE_SHIFT_RIGHT,
        reg_out (2 downto 0) & q0_in when Q_WRITE_SHIFT_LEFT,
        q_input                      when others;

    -- q0 and q3 can be used when shifting (resp. right and left) to output
    -- the resp. LSB and MSB of the shifted value. otherwise they are inputs
    q0_out <= reg_out (0);
    q3_out <= reg_out (3);

    -- writing in the Q register (accumulator)
    process(clk) begin
        if rising_edge(clk) and reg_we = '1' then
            reg_out <= reg_in;
        end if;
    end process;

    q_output <= reg_out;
end behavioural;
