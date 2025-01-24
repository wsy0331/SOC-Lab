library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all; 
use IEEE.std_logic_unsigned.all;

entity tb_speed_ball is
-- Testbench ���ݭn���� Port
end tb_speed_ball;

architecture sim of tb_speed_ball is

    -- �����ɤ����T��
    signal i_rst   : std_logic;
    signal i_clk   : std_logic := '0';
    signal i_btn_l : std_logic;
    signal i_btn_r : std_logic;
    signal o_led   : std_logic_vector(7 downto 0);

    -- �ɯ߶g���`��
    constant CLK_PERIOD : time := 10 ns;

begin

    -- �ҤƳQ���Ҳ� (DUT, Design Under Test)
    uut: entity work.speed_ball
        port map (
            i_rst   => i_rst,
            i_clk   => i_clk,
            i_btn_l => i_btn_l,
            i_btn_r => i_btn_r,
            o_led   => o_led
        );

    -- ���ͮɯ߰T��
    clk_gen: process
    begin
        while true loop
            i_clk <= '0';
            wait for CLK_PERIOD / 2;
            i_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- ���լy�{
    stim_proc: process
    begin
        -- ��l��
        i_rst   <= '0';
        i_btn_l <= '0';
        i_btn_r <= '0';
        wait for 20 ns;

        -- ���񭫸m
        i_rst <= '1';
        wait for 20 ns;

        -- ���ի��U�k���s�A���ʨ쥪��
        i_btn_r <= '1';
        wait for 50 ns;
        i_btn_r <= '0';

--        -- ���ի��U�����s�A���ʨ�k��
--        wait for 100 ns;
--        i_btn_l <= '1';
--        wait for 50 ns;
--        i_btn_l <= '0';

--        -- ���ե����o��
--        wait for 200 ns;
--        i_btn_l <= '1';
--        wait for 50 ns;
--        i_btn_l <= '0';

--        -- ���եk���o��
--        wait for 200 ns;
--        i_btn_r <= '1';
--        wait for 50 ns;
--        i_btn_r <= '0';

--        -- ���է�����Ʋֿn
--        wait for 500 ns;
--        for i in 0 to 15 loop
--            i_btn_r <= '1';
--            wait for 20 ns;
--            i_btn_r <= '0';
--            wait for 100 ns;
--        end loop;

        -- ��������
        wait;
    end process;

end sim;
