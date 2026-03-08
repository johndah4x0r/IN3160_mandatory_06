library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity self_test_unit is
    port (
        mclk, reset : in std_ulogic;
        c : out std_ulogic;
        abcdefg : out std_ulogic_vector(6 downto 0)
    );
end entity self_test_unit;

architecture rtl of self_test_unit is
    signal d0, d1 : std_ulogic_vector(3 downto 0);
begin
    driver: entity work.seg7ctrl(secret)
        generic map (
            LIMIT => 10
        )

        port map (
            mclk => mclk,
            reset => reset,
            c => c,
            d0 => d0,
            d1 => d1,
            abcdefg => abcdefg
        );

    sequencer: entity work.self_test(rtl)
        generic map (
            LIMIT => 100
        )

        port map (
            mclk => mclk,
            reset => reset,
            d0 => d0,
            d1 => d1
        );

    -- no processes, as we're simply wiring everythin together
end architecture ; -- rtl
