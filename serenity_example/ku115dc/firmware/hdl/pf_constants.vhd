library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package pf_constants is

  constant PF_ALGO_LATENCY : natural := 37;  -- Algorithm latency in 240 MHz
                                             -- ticks
  constant MAX_PF_IP_CORES : natural := 6;
  constant N_PF_IP_CORES : natural := 1;  -- Up to 6
  constant N_PF_IP_CORE_IN_CHANS : natural := 72;
  constant N_PF_IP_CORE_OUT_CHANS : natural := 68;
  constant N_CHANS_PER_CORE : natural := 12;
  constant PF_RESHAPE_FACTOR : natural := 6;
  
  constant N_IN_CHANS  : natural := 72;
  constant N_OUT_CHANS : natural := 68;
  
 
  -- Constants for original design
  constant N_QUAD_LINKS : natural := 4;
  constant N_PF_IN_CHANS  : natural := 72;
  constant N_PF_OUT_CHANS : natural := 68;
  
  type QuadAssignment_vector is array (integer range <>) of natural;
  constant INPUT_QUAD_ASSIGNMENT  : QuadAssignment_vector(17 downto 0) := (17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
  constant OUTPUT_QUAD_ASSIGNMENT : QuadAssignment_vector(16 downto 0) := (16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
  
 
end;
    
