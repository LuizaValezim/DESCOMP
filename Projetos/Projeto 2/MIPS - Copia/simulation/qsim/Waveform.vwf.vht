-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "11/21/2022 18:31:29"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          Aula17
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY Aula17_vhd_vec_tst IS
END Aula17_vhd_vec_tst;
ARCHITECTURE Aula17_arch OF Aula17_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLOCK_50 : STD_LOGIC;
SIGNAL flagEqual : STD_LOGIC;
SIGNAL Funct : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL habFlagBEQ : STD_LOGIC;
SIGNAL Instru_opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL MEM_INN : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MEM_OUTT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL muxJmp : STD_LOGIC;
SIGNAL PC_OUTT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Rs_End : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL RS_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Rt_End : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL RT_OUTT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ULAA_OUT_AddrRAM : STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT Aula17
	PORT (
	CLOCK_50 : IN STD_LOGIC;
	flagEqual : OUT STD_LOGIC;
	Funct : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	habFlagBEQ : OUT STD_LOGIC;
	Instru_opcode : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	MEM_INN : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	MEM_OUTT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	muxJmp : OUT STD_LOGIC;
	PC_OUTT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	Rs_End : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	RS_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	Rt_End : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	RT_OUTT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	ULAA_OUT_AddrRAM : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : Aula17
	PORT MAP (
-- list connections between master ports and signals
	CLOCK_50 => CLOCK_50,
	flagEqual => flagEqual,
	Funct => Funct,
	habFlagBEQ => habFlagBEQ,
	Instru_opcode => Instru_opcode,
	MEM_INN => MEM_INN,
	MEM_OUTT => MEM_OUTT,
	muxJmp => muxJmp,
	PC_OUTT => PC_OUTT,
	Rs_End => Rs_End,
	RS_OUT => RS_OUT,
	Rt_End => Rt_End,
	RT_OUTT => RT_OUTT,
	ULAA_OUT_AddrRAM => ULAA_OUT_AddrRAM
	);

-- CLOCK_50
t_prcs_CLOCK_50: PROCESS
BEGIN
	CLOCK_50 <= '1';
	WAIT FOR 20000 ps;
	FOR i IN 1 TO 24
	LOOP
		CLOCK_50 <= '0';
		WAIT FOR 20000 ps;
		CLOCK_50 <= '1';
		WAIT FOR 20000 ps;
	END LOOP;
	CLOCK_50 <= '0';
WAIT;
END PROCESS t_prcs_CLOCK_50;
END Aula17_arch;
