library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_part1 is
end tb_part1;

architecture Behavioral of tb_part1 is
    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal count  : INTEGER range 0 to 9;

    -- 連接到 part1 實體
    component part1
        Port (
            clk    : in STD_LOGIC;
            reset  : in STD_LOGIC;
            count  : out INTEGER range 0 to 9
        );
    end component;

begin
    uut: part1 Port Map (
        clk => clk,
        reset => reset,
        count => count
    );

    -- 時脈產生器
    clk_process: process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

    -- 模擬流程
    stim_proc: process
    begin
        -- 初始化重置訊號
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- 模擬 200 ns
        wait for 200 ns;
        
        -- 結束模擬
        wait;
    end process;
end Behavioral;
