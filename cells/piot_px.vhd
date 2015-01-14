--
-- Generated by VASY
--
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY piot_px IS
PORT(
  i	: IN STD_LOGIC;
  b	: IN STD_LOGIC;
  t	: OUT STD_LOGIC;
  pad	: INOUT STD_LOGIC;
  ck	: IN STD_LOGIC;
  vdde	: IN STD_LOGIC;
  vddi	: IN STD_LOGIC;
  vsse	: IN STD_LOGIC;
  vssi	: IN STD_LOGIC
);
END piot_px;

ARCHITECTURE RTL OF piot_px IS
  SIGNAL b1	: STD_LOGIC;
  SIGNAL b2	: STD_LOGIC;
  SIGNAL b3	: STD_LOGIC;
  SIGNAL b4	: STD_LOGIC;
  SIGNAL b5	: STD_LOGIC;
  SIGNAL b6	: STD_LOGIC;
BEGIN
  t <= pad;
  PROCESS ( i, b6 )
  BEGIN
    IF (b6 = '1')
    THEN pad <= i;
    ELSE pad <= 'Z';
    END IF;
  END PROCESS;
  b1 <= b;
  b2 <= b1;
  b3 <= b2;
  b4 <= b3;
  b5 <= b4;
  b6 <= b5;
END RTL;
