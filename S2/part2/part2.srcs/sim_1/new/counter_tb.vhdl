library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_DualCounter is
end TB_DualCounter;

architecture Behavioral of TB_DualCounter is
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal count_up1   : std_logic := '1';
    signal count_up2   : std_logic := '1';
    signal max1, min1  : unsigned(7 downto 0) := (others => '0');
    signal max2, min2  : unsigned(7 downto 0) := (others => '0');
    signal counter1    : unsigned(7 downto 0);
    signal counter2    : unsigned(7 downto 0);

    constant clk_period : time := 10 ns;
begin
    UUT: entity work.DualCounter
        port map (
            clk => clk,
            reset => reset,
            count_up1 => count_up1,
            count_up2 => count_up2,
            max1 => max1,
            min1 => min1,
            max2 => max2,
            min2 => min2,
            counter1 => counter1,
            counter2 => counter2
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus: process
    begin
        -- ﹍て把计
        max1 <= to_unsigned(10, 8);
        min1 <= to_unsigned(0, 8);
        max2 <= to_unsigned(20, 8);
        min2 <= to_unsigned(5, 8);

        -- 竚╰参
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';

        -- 家览计
        count_up1 <= '1';
        count_up2 <= '1';
        wait for clk_period * 50;

        -- 家览计
        count_up1 <= '0';
        count_up2 <= '0';
        wait for clk_period * 50;

        -- 挡家览
        wait;
    end process;
end Behavioral;
