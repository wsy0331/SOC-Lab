library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity part1 is
    Port (
        clk    : in STD_LOGIC;
        reset  : in STD_LOGIC;
        count  : out INTEGER range 0 to 9
    );
end part1;

architecture Behavioral of part1 is
    signal current_count : INTEGER range 0 to 9 := 0;
    signal direction     : STD_LOGIC := '1'; -- '1' means count up, '0' means count down
begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_count <= 0;
            direction <= '1';
        elsif rising_edge(clk) then
            if direction = '1' then -- Count up
                if current_count = 9 then
                    direction <= '0';
                    current_count <= 8; -- Start counting down from 9
                else
                    current_count <= current_count + 1;
                end if;
            else -- Count down
                if current_count = 0 then
                    direction <= '1';
                    current_count <= 1; -- Start counting up from 0
                else
                    current_count <= current_count - 1;
                end if;
            end if;
        end if;
    end process;

    count <= current_count;
end Behavioral;
