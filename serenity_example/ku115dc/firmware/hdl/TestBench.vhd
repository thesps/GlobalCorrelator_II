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


-- .library VertexFinder
-- .include TopLevelInterfaces/mp7_data_types.vhd
-- .include ReuseableElements/PkgDebug.vhd
-- .include components/PkgConstants.vhd

-- .include testbench/DummyData.vhd
-- .include TestingAndDebugging/MP7CaptureFileReader.vhd

-- .include top/VertexFinderProcessor.vhd

-- -------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--USE work.mp7_data_types.ALL;
USE work.emp_data_types.all;
--USE Utilities.debugging.ALL;
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------
ENTITY top IS
END top;
-- -------------------------------------------------------------------------


-- -------------------------------------------------------------------------
ARCHITECTURE rtl OF top IS

-- CLOCK SIGNALS
  SIGNAL clk                : STD_LOGIC            := '1';
  SIGNAL clk_payload        : STD_LOGIC_VECTOR(2 downto 0) := (others => '1');

-- LINK SIGNALS
  SIGNAL linksIn , linksInA : ldata( 71 DOWNTO 0 ) := ( OTHERS => LWORD_NULL );
  SIGNAL linksOut           : ldata( 71 DOWNTO 0 ) := ( OTHERS => LWORD_NULL );

-- SELECT THE STIMULUS
-- CONSTANT Stimulus        : STRING               := "Dummy";
  CONSTANT Stimulus         : STRING               := "MP7file";

BEGIN

    clk <= NOT clk AFTER 2.5 ns;
    clk_payload(2) <= NOT clk_payload(2) AFTER 15 ns;

-- -------------------------------------------------------------------------
-- STIMULII FOR THE ALGORITHMS
      MP7CaptureFileReaderInstance : ENTITY work.MP7CaptureFileReader
      GENERIC MAP( FileName                => "/home/sioni/p2fwk-work/src/GlobalCorrelator_II/serenity_example/ku115dc/test/mp7_input_patterns.txt" ,
                   StartFrameInclAnyHeader => 0 ,
                   GapLength               => 8 ,
                   HeaderLength            => 0 ,
                   PayloadLength           => 108 ,
                   DebugMessages           => FALSE
      )
      PORT MAP( clk      => clk ,
                LinkData => linksIn --A
      );

-- Hack to make the frames fixed length - should probably be added as an option into the file reader
--        / * PROCESS( clk )
--      BEGIN
--        IF( RISING_EDGE( clk ) ) THEN
--          LinksIn <= ( OTHERS => LWORD_NULL );
--          IF( ( SimulationClockCounter - 1 ) MOD cPacketLength ) < cPacketLength-6 THEN
--            FOR i IN 0 TO 71 LOOP
--              LinksIn( i ) .data  <= linksInA( i ) .data;
--              LinksIn( i ) .valid <= '1';
--            END LOOP;
--          END IF;
--        END IF;
--      END PROCESS ; * /
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- THE ALGORITHMS UNDER TEST
  --VertexFinderProcessorInstance : ENTITY work.PFProcessorTopOriginalMuxing
  VertexFinderProcessorInstance : ENTITY work.PFProcessorTop
  PORT MAP( clk_p => clk, clk_payload => clk_payload, d => linksIn, q => linksOut, rst_loc => (others => '0'));
-- -------------------------------------------------------------------------

END ARCHITECTURE rtl;
