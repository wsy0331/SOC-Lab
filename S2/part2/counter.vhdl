library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DualCounter is
    Port (
        clk         : in  std_logic;              -- 牧癟腹
        reset       : in  std_logic;              -- 竚癟腹
        count_up1   : in  std_logic;              -- 璸计竟 1 计/计北
        count_up2   : in  std_logic;              -- 璸计竟 2 计/计北
        max1        : in  unsigned(7 downto 0);   -- 璸计竟 1 
        min1        : in  unsigned(7 downto 0);   -- 璸计竟 1 
        max2        : in  unsigned(7 downto 0);   -- 璸计竟 2 
        min2        : in  unsigned(7 downto 0);   -- 璸计竟 2 
        counter1    : out unsigned(7 downto 0);   -- 璸计竟 1 
        counter2    : out unsigned(7 downto 0)    -- 璸计竟 2 
    );
end DualCounter;

architecture Behavioral of DualCounter is
    signal count1 : unsigned(7 downto 0) := (others => '0');
    signal count2 : unsigned(7 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count1 <= min1;
            count2 <= min2;
        elsif rising_edge(clk) then
            -- 璸计竟 1 呸胯
            if count_up1 = '1' then
                if count1 < max1 then
                    count1 <= count1 + 1;
                else
                    count1 <= min1;  -- 禬筁
                end if;
            else
                if count1 > min1 then
                    count1 <= count1 - 1;
                else
                    count1 <= max1;  -- 
                end if;
            end if;

            -- 璸计竟 2 呸胯
            if count_up2 = '1' then
                if count2 < max2 then
                    count2 <= count2 + 1;
                else
                    count2 <= min2;  -- 禬筁
                end if;
            else
                if count2 > min2 then
                    count2 <= count2 - 1;
                else
                    count2 <= max2;  -- 
                end if;
            end if;
        end if;
    end process;

    counter1 <= count1;
    counter2 <= count2;
end Behavioral;
