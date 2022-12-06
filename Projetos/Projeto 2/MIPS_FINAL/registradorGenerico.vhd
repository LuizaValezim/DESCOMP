library ieee;
use ieee.std_logic_1164.all;

entity registradorGenerico is
    generic (
        larguradados : natural := 8
    );
    port (
        din : in std_logic_vector(larguradados - 1 downto 0);
        dout : out std_logic_vector(larguradados - 1 downto 0);
        enable : in std_logic;
        clk, rst : in std_logic
    );
end entity;

architecture comportamento of registradorGenerico is
begin
    -- in altera devices, register signals have a set priority.
    -- the hdl design should reflect this priority.
    process (rst, clk)
    begin
        -- the asynchronous reset signal has the highest priority
        if (rst = '1') then
            dout <= (others => '0'); -- código reconfigurável.
        else
            -- at a clock edge, if asynchronous signals have not taken priority,
            -- respond to the appropriate synchronous signal.
            -- check for synchronous reset, then synchronous load.
            -- if none of these takes precedence, update the register output
            -- to be the register input.
            if (rising_edge(clk)) then
                if (enable = '1') then
                    dout <= din;
                end if;
            end if;
        end if;
    end process;
end architecture;