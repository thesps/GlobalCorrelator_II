-- #########################################################################
-- #########################################################################
-- ###                                                                   ###
-- ###   Use of this code, whether in its current form or modified,      ###
-- ###   implies that you consent to the terms and conditions, namely:   ###
-- ###    - You acknowledge my contribution                              ###
-- ###    - This copyright notification remains intact                   ###
-- ###                                                                   ###
-- ###   Many thanks,                                                    ###
-- ###     Dr. Andrew W. Rose, Imperial College London, 2018             ###
-- ###                                                                   ###
-- #########################################################################
-- #########################################################################

-- .library Utilities

-- -------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.math_real.ALL;
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------
PACKAGE Utilities IS

-- -------------------------------------------------------------------------       
  FUNCTION to_std_logic( arg               : BOOLEAN ) RETURN std_ulogic;
  FUNCTION to_boolean( arg                 : STD_LOGIC ) RETURN BOOLEAN;

  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT SIGNED );
  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT UNSIGNED );
  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT STD_LOGIC_VECTOR );
  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT STD_LOGIC );
-- -------------------------------------------------------------------------       

END PACKAGE Utilities;
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
PACKAGE BODY Utilities IS

-- -------------------------------------------------------------------------       
  FUNCTION to_boolean( arg : STD_LOGIC ) RETURN BOOLEAN IS
  BEGIN
    RETURN( arg = '1' );
  END FUNCTION to_boolean;
-- -------------------------------------------------------------------------       

-- -------------------------------------------------------------------------       
  FUNCTION to_std_logic( arg : BOOLEAN ) RETURN std_ulogic IS
  BEGIN
    IF arg THEN
        RETURN( '1' );
    ELSE
        RETURN( '0' );
    END IF;
  END FUNCTION to_std_logic;
-- -------------------------------------------------------------------------       

-- -------------------------------------------------------------------------       
  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT SIGNED ) IS
    VARIABLE rand                          : REAL; -- Random real-number value in range 0 to 1.0
  BEGIN
    UNIFORM( seed1 , seed2 , rand ); -- generate random number
    RESULT := TO_SIGNED( INTEGER( rand * REAL( 2 ** 30 ) ) , RESULT'LENGTH );
  END SET_RANDOM_VAR;
-- -------------------------------------------------------------------------       

-- -------------------------------------------------------------------------       
  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT UNSIGNED ) IS
    VARIABLE rand                          : REAL; -- Random real-number value in range 0 to 1.0
  BEGIN
    UNIFORM( seed1 , seed2 , rand ); -- generate random number
    RESULT := TO_UNSIGNED( INTEGER( rand * REAL( 2 ** 30 ) ) , RESULT'LENGTH );
  END SET_RANDOM_VAR;
-- -------------------------------------------------------------------------       

-- -------------------------------------------------------------------------       
  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT STD_LOGIC_VECTOR ) IS
    VARIABLE rand                          : REAL; -- Random real-number value in range 0 to 1.0
  BEGIN
    UNIFORM( seed1 , seed2 , rand ); -- generate random number
    RESULT := STD_LOGIC_VECTOR( TO_UNSIGNED( INTEGER( rand * REAL( 2 ** 30 ) ) , RESULT'LENGTH ) );
  END SET_RANDOM_VAR;
-- -------------------------------------------------------------------------       

-- -------------------------------------------------------------------------       
  PROCEDURE SET_RANDOM_VAR( VARIABLE SEED1 : INOUT POSITIVE ; SEED2 : INOUT POSITIVE ; VARIABLE RESULT : OUT STD_LOGIC ) IS
    VARIABLE rand                          : REAL; -- Random real-number value in range 0 to 1.0
    VARIABLE int_rand                      : INTEGER; -- Random integer value in range 0 to 1
  BEGIN
    UNIFORM( seed1 , seed2 , rand ); -- generate random number
    int_rand := INTEGER( ROUND( rand ) );
    IF int_rand = 1 THEN
      RESULT := '1';
    ELSE
      RESULT := '0';
    END IF;
  END SET_RANDOM_VAR;
-- -------------------------------------------------------------------------       

END Utilities;
