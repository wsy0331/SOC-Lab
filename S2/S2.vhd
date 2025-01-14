library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use IEEE.std_logic_unsigned.all;

entity DualCounter is
    Port (
        i_clk       : in  std_logic;                      -- 時鐘訊號
        i_rst       : in  std_logic;                      -- 重置訊號
        i_count_up1   : in  std_logic;                    -- 計數器 1 上數/下數控制
        i_count_up2   : in  std_logic;                    -- 計數器 2 上數/下數控制
        o_count1    : out std_logic_vector(3 downto 0);   -- 計數器 1 的值
        o_count2    : out std_logic_vector(3 downto 0)    -- 計數器 2 的值
    );
end DualCounter;

architecture Behavioral of DualCounter is
    signal count1 : std_logic_vector(3 downto 0) := (others => '0');
    signal count2 : std_logic_vector(3 downto 0) := (others => '0');
    signal min1   : std_logic_vector(3 downto 0) := (others => '0');
    signal min2   : std_logic_vector(3 downto 0) := (others => '0');
    signal max1   : std_logic_vector(3 downto 0) := "1001";
    signal max2   : std_logic_vector(3 downto 0) := "1001";
    signal div_cnt : std_logic_vector(23 downto 0) := (others => '0'); --分頻計數器 (0~23)
begin
	o_count1 <= count1;
	o_count2 <= count2;
	
    -- 除頻器：除頻 24
    process (i_clk, i_rst)
    begin
        if i_rst = '1' then
            div_cnt <= (others => '0');
        elsif rising_edge(i_clk) then
                div_cnt <= div_cnt + 1;
            end if;
    end process;
	
    process(div_cnt, i_rst,i_count_up1,i_count_up2)
    begin
        if i_rst = '1' then
            count1 <= min1;
            count2 <= min2;
        elsif rising_edge(div_cnt(23)) then
            -- 計數器 1 邏輯
            if i_count_up1 = '1' then
                if count1 < max1 then
                    count1 <= count1 + 1;
                else
                    count1 <= min1;  -- 超過上限回到下限
                end if;
            else
                if count1 > min1 then
                    count1 <= count1 - 1;
                else
                    count1 <= max1;  -- 低於下限回到上限
                end if;
            end if;

            -- 計數器 2 邏輯
            if i_count_up2 = '1' then
                if count2 < max2 then
                    count2 <= count2 + 1;
                else
                    count2 <= min2;  -- 超過上限回到下限
                end if;
            else
                if count2 > min2 then
                    count2 <= count2 - 1;
                else
                    count2 <= max2;  -- 低於下限回到上限
                end if;
            end if;
        end if;
    end process;

end Behavioral;
