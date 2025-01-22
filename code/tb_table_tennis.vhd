library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity table_tennis_tb is
    -- �����ɤ��ݭn��ŧi
end table_tennis_tb;

architecture Behavioral of table_tennis_tb is

    -- �ŧi�ݴ��椸 (Unit Under Test, UUT) ������
    component table_tennis
        Port (
            i_rst  : in std_logic;  -- �t�έ��m�T��
            i_clk  : in std_logic;  -- �t�ήɯ߰T��
            i_btn_l : in std_logic; -- ���䪱�a����
            i_btn_r : in std_logic; -- �k�䪱�a����
            o_led  : out std_logic_vector (7 downto 0) -- LED ��X���
        );
    end component;

    -- ���իH���ŧi
    signal i_rst  : std_logic := '0';                  -- ���m�T��
    signal i_clk  : std_logic := '0';                  -- �ɯ߰T��
    signal i_btn_l : std_logic := '0';                 -- ������
    signal i_btn_r : std_logic := '0';                 -- �k����
    signal o_led  : std_logic_vector (7 downto 0);     -- LED ��X

    -- �ɯ߶g���]�w�A1 MHz �ɯ� (1us �g��)
    constant CLK_PERIOD : time := 1 us;

begin

    -- �ݴ��椸 (UUT) ����Ҥ�
    uut: table_tennis
        port map (
            i_rst  => i_rst,    -- �s�����m�T��
            i_clk  => i_clk,    -- �s���ɯ߰T��
            i_btn_l => i_btn_l, -- �s��������T��
            i_btn_r => i_btn_r, -- �s���k����T��
            o_led  => o_led     -- �s�� LED ��X
        );

    -- �ɯ߲��͵{��
    clk_process : process
    begin
        while now < 10 ms loop  -- ���� 10 �@���ɯ�
            i_clk <= '0';
            wait for CLK_PERIOD / 2; -- �ɯߧC�q��O���ɶ�
            i_clk <= '1';
            wait for CLK_PERIOD / 2; -- �ɯ߰��q��O���ɶ�
        end loop;
        wait; -- ��������
    end process;

    -- ���ը�E�{��
    stimulus_process : process
    begin
        -- ��l���m
        i_rst <= '0';            -- �N���m�T���]���C�q��
        wait for 2 * CLK_PERIOD; -- ���ݨ�Ӯɯ߶g��
        i_rst <= '1';            -- �Ѱ����m�T��
        wait for 2 * CLK_PERIOD; -- ���ݨt��í�w

        -- ���� 8 �@�������`�若
        -- �Ĥ@���k����U
        i_btn_r <= '1';          -- ���U�k��
        wait for 4 ms;           -- �k��O�����U 4 �@��
        i_btn_r <= '0';          -- ����k��
        wait for 4 ms;           -- ���ݥ���ާ@

        -- �Ĥ@��������U
        i_btn_l <= '1';          -- ���U����
        wait for 4 ms;           -- ����O�����U 4 �@��
        i_btn_l <= '0';          -- ������
        wait for 4 ms;           -- ���ݥk��ާ@

        -- �ĤG���k����U
        i_btn_r <= '1';          -- ���U�k��
        wait for 4 ms;           -- �k��O�����U 4 �@��
        i_btn_r <= '0';          -- ����k��
        wait for 4 ms;           -- ���ݥ���ާ@

        -- �ĤG��������U
        i_btn_l <= '1';          -- ���U����
        wait for 4 ms;           -- ����O�����U 4 �@��
        i_btn_l <= '0';          -- ������

        -- ���������A�[��G
        wait for 1 ms;

        wait; -- ��������
    end process;

end Behavioral;
