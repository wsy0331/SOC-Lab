library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DualCounter is
    Port (
        clk         : in  std_logic;              -- �����T��
        reset       : in  std_logic;              -- ���m�T��
        count_up1   : in  std_logic;              -- �p�ƾ� 1 �W��/�U�Ʊ���
        count_up2   : in  std_logic;              -- �p�ƾ� 2 �W��/�U�Ʊ���
        max1        : in  unsigned(7 downto 0);   -- �p�ƾ� 1 �W��
        min1        : in  unsigned(7 downto 0);   -- �p�ƾ� 1 �U��
        max2        : in  unsigned(7 downto 0);   -- �p�ƾ� 2 �W��
        min2        : in  unsigned(7 downto 0);   -- �p�ƾ� 2 �U��
        counter1    : out unsigned(7 downto 0);   -- �p�ƾ� 1 ����
        counter2    : out unsigned(7 downto 0)    -- �p�ƾ� 2 ����
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
            -- �p�ƾ� 1 �޿�
            if count_up1 = '1' then
                if count1 < max1 then
                    count1 <= count1 + 1;
                else
                    count1 <= min1;  -- �W�L�W���^��U��
                end if;
            else
                if count1 > min1 then
                    count1 <= count1 - 1;
                else
                    count1 <= max1;  -- �C��U���^��W��
                end if;
            end if;

            -- �p�ƾ� 2 �޿�
            if count_up2 = '1' then
                if count2 < max2 then
                    count2 <= count2 + 1;
                else
                    count2 <= min2;  -- �W�L�W���^��U��
                end if;
            else
                if count2 > min2 then
                    count2 <= count2 - 1;
                else
                    count2 <= max2;  -- �C��U���^��W��
                end if;
            end if;
        end if;
    end process;

    counter1 <= count1;
    counter2 <= count2;
end Behavioral;
