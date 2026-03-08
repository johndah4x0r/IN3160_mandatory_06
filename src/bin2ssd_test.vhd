library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.seg7_pkg.all;

entity bin2ssd_test is
  port
  (
    di        : in std_ulogic_vector(3 downto 0);
    abcdefg   : out std_ulogic_vector(6 downto 0)
  );
end entity bin2ssd_test;

architecture dataflow of bin2ssd_test is
begin
    process (di) is
    begin
        abcdefg <= bin2ssd(di);
    end process;
end dataflow;
