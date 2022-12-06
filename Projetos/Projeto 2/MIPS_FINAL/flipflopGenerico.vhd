library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity flipflopGenerico is
    port (
        Din : in STD_LOGIC;
        Dout : out STD_LOGIC;
        ENABLE : in STD_LOGIC;
        CLK, RST : in STD_LOGIC
    );
end entity;

architecture comportamento OF flipflopGenerico is
begin

    process (RST, CLK)
    begin
        IF (RST = '1') THEN
            Dout <= '0';
        else
            IF (rising_edge(CLK)) THEN
                IF (ENABLE = '1') THEN
                    Dout <= Din;
                end IF;
            end IF;
        end IF;
    end process;
end architecture;