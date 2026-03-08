library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity self_test is
    -- generic `LIMIT` added for easier verification
    generic (
        LIMIT : integer := 100
    );

    port (
        mclk, reset : in std_ulogic;
        d0, d1: out std_ulogic_vector(3 downto 0)
    );
end entity self_test;

architecture rtl of self_test is
    type seq_t is record
        d0 : unsigned(3 downto 0);
        d1 : unsigned(3 downto 0);
    end record;
    type seq_mem_t is array (natural range <>) of seq_t;

    constant seq_mem : seq_mem_t := (
        (d0 => x"1", d1 => x"2"),
        (d0 => x"3", d1 => x"4"),
        (d0 => x"4", d1 => x"0"),
        (d0 => x"0", d1 => x"0"),
        (d0 => x"5", d1 => x"6"),
        (d0 => x"7", d1 => x"3"),
        (d0 => x"0", d1 => x"0"),
        (d0 => x"8", d1 => x"6"),
        (d0 => x"9", d1 => x"0"),
        (d0 => x"0", d1 => x"0"),
        (d0 => x"A", d1 => x"B"),
        (d0 => x"3", d1 => x"0"),
        (d0 => x"0", d1 => x"0"),
        (d0 => x"C", d1 => x"6"),
        (d0 => x"6", d1 => x"5"),
        (d0 => x"0", d1 => x"0")
    );

    signal seq_ctr : integer := 0;
    signal ctr : unsigned(19 downto 0) := x"FFFFF";
    signal ce : std_ulogic := '0';

begin
    ctr_inc: process(mclk)
    begin
        if rising_edge(mclk) then
            if reset then
                ctr <= (others => '0');
                ce <= '0';
            elsif ctr = LIMIT - 1 then
                ctr <= (others => '0');
                ce <= '1';
            else
                ctr <= ctr + 1;
                ce <= '0';
            end if;
        end if;
    end process;

    seq_fetch: process(mclk)
    begin
        -- TODO: decide on reset semantics
        if rising_edge(mclk) then
            if reset then
                seq_ctr <= 0;
            elsif ce then
                -- let the sequence counter overflow
                -- port mapping!
                d0 <= std_ulogic_vector(seq_mem(seq_ctr).d0);
                d1 <= std_ulogic_vector(seq_mem(seq_ctr).d1);

                if seq_ctr = 15 then
                    seq_ctr <= 0;
                else 
                    seq_ctr <= seq_ctr + 1;
                end if;
            end if;
        end if;
    end process;
end architecture rtl; -- rtl
