library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is port (
    -- clock
    clk: in std_logic;

    -- inout pins for shifting
    r0_in  : in  std_logic;
    r3_in  : in  std_logic;
    r0_out : out std_logic;
    r3_out : out std_logic;

    -- control pins
    ram_shift: in std_logic_vector (1 downto 0);
    a_addr:    in std_logic_vector (3 downto 0);
    b_addr:    in std_logic_vector (3 downto 0);

    -- data pins
    ram_input: in  std_logic_vector (3 downto 0);
    a_output:  out std_logic_vector (3 downto 0);
    b_output:  out std_logic_vector (3 downto 0)
); end ram;

architecture behavioural of ram is
    -- our memory of addressable registers
    type RAM is array (15 downto 0) of std_logic_vector (3 downto 0);
    signal memory: RAM;

    -- Values of the 2 MSB of Destination selection
    -- when swifting the RAM input left or right.
    constant MEM_WRITE_SHIFT_LEFT  : std_logic_vector (1 downto 0) := "11";
    constant MEM_WRITE_SHIFT_RIGHT : std_logic_vector (1 downto 0) := "10";
    constant MEM_WRITE_SHIFT_NONE  : std_logic_vector (1 downto 0) := "01";
    constant MEM_WRITE_DISABLED    : std_logic_vector (1 downto 0) := "00";

    signal ram_we: std_logic;
    signal input : std_logic_vector (3 downto 0);
begin
    -- RAM write-enable
    ram_we <= '0' when ram_shift = MEM_WRITE_DISABLED else '1';

    -- value that we will write into RAM
    input <=
        -- right shift
        r3_in & ram_input (3 downto 1) when ram_shift = MEM_WRITE_SHIFT_RIGHT else
        -- left shift
        ram_input (2 downto 0) & r0_in when ram_shift = MEM_WRITE_SHIFT_LEFT  else
        -- no shift
        ram_input;

    -- r0 and r3 can be used when shifting (resp. right and left) to output
    -- the resp. LSB and MSB of the shifted value. otherwise they are inputs
    r0_out <= ram_input (0);
    r3_out <= ram_input (3);

    process(clk) begin
        if rising_edge(clk) and ram_we = '1' then
            memory(to_integer(unsigned(b_addr))) <= input;
        end if;
    end process;

    a_output <= memory(to_integer(unsigned(a_addr)));
    b_output <= memory(to_integer(unsigned(b_addr)));
end behavioural;
