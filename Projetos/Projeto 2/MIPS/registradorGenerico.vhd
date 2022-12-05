library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity registradorgenerico is
    generic (
        larguraDados : natural := 8
    );
    port (
        Din : in std_logic_vector(larguraDados - 1 downto 0);
        Dout : out std_logic_vector(larguraDados - 1 downto 0);
        ENABLE : in STD_LOGIC;
        CLK, RST : in STD_LOGIC
    );
end entity;

architecture comportamento OF registradorgenerico is
begin
    -- in Altera devices, register signals have a set priority.
    -- The HDL design should reflect this priority.
    process (RST, CLK)
    begin
        -- The asynchronous reset signal has the highest priority
        IF (RST = '1') THEN
            Dout <= (OTHERS => '0'); -- Código reconfigurável.
        else
            -- At a clock edge, if asynchronous signals have not taken priority,
            -- respond to the appropriate synchronous signal.
            -- Check for synchronous reset, then synchronous load.
            -- If none of these takes precedence, update the register output
            -- to be the register input.
            IF (rising_edge(CLK)) THEN
                IF (ENABLE = '1') THEN
                    Dout <= Din;
                end IF;
            end IF;
        end IF;
    end process;
end architecture;