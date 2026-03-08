library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- here, we'll use a different LUT
architecture secret of seg7ctrl is
    signal ctr : std_ulogic_vector(19 downto 0);
    signal next_ctr : u_unsigned(19 downto 0);
    signal cs : std_ulogic;
    signal next_cs : std_ulogic;
    signal d_used : std_ulogic_vector(3 downto 0);

    function bin2ssd (indata : std_ulogic_vector(3 downto 0)) return std_ulogic_vector is
    begin
        case indata is
            when "0000" => return "0000000";
            when "0001" => return "0011110";
            when "0010" => return "0111100";
            when "0011" => return "1001111";
            when "0100" => return "0001110";
            when "0101" => return "0111101";
            when "0110" => return "0011101";
            when "0111" => return "0010101";
            when "1000" => return "0111011";
            when "1001" => return "0111110";
            when "1010" => return "1110111";
            when "1011" => return "0000101";
            when "1100" => return "1111011";
            when "1101" => return "0011100";
            when "1110" => return "0001101";
            when "1111" => return "1111111";
            when others => return "0000000";            
        end case;
    end function bin2ssd;
begin
    -- timer combinational process
    next_ctr <= 
        (others => '0') when unsigned(ctr) = LIMIT - 1 else     -- increments to `LIMIT - 1` then overflows artificially
        unsigned(ctr) + 1;
    next_cs <=
        not cs when unsigned(next_ctr) = 0 else                 -- toggles if `ctr` overflows
        cs;

    -- timer register process
    clocked: process (mclk) is
    begin
        -- (not quite sure whether to make
        --  reset asynchronous, as originally
        --  intended...)
        if rising_edge(mclk) then
            ctr <=
                (others => '0') when reset else
                std_ulogic_vector(next_ctr);

            cs <= '0' when reset else
                next_cs;
        end if;
    end process;

    -- port mapping
    -- TODO: make the pipe dream real!
    c <= cs;

    d_used <=
        d0 when cs = '0' else
        d1;

    abcdefg <= bin2ssd(d_used);
end architecture secret;
