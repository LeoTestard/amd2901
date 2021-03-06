--
-- Generated by VASY
--
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY pvddeck_px IS
PORT(
  cko	: OUT STD_LOGIC;
  ck	: IN STD_LOGIC;
  vdde	: IN STD_LOGIC;
  vddi	: IN STD_LOGIC;
  vsse	: IN STD_LOGIC;
  vssi	: IN STD_LOGIC
);
END pvddeck_px;

ARCHITECTURE RTL OF pvddeck_px IS
BEGIN
  cko <= ck;
END RTL;
