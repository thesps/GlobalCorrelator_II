library ieee;
use ieee.std_logic_1164.all;

use work.pf_constants.all;
use work.utilities.all;

USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;


package pf_data_types is

  type pf_data is array (natural range <>) of std_logic_vector(31 downto 0);

  -- type pf_data_array is array (natural range <>) of pf_data;
  type pf_data_array_in is array (N_PF_IP_CORES - 1 downto 0) of pf_data(N_PF_IP_CORE_IN_CHANS - 1 downto 0);
  type pf_data_array_out is array (MAX_PF_IP_CORES - 1 downto 0) of pf_data(N_PF_IP_CORE_OUT_CHANS - 1 downto 0);
  
  --function WriteHeader RETURN STRING;
  --function WriteData( aData : pf_data_array_in ) return string;
  --function WriteData( aData : pf_data_array_out ) return string;

end pf_data_types;
      
--package body pf_data_types is

    --function WriteHeader return string is
--        variable aLine : LINE;
--    begin
--        write(aLine, string' ("ldata"), RIGHT, 15);
--        return aLine.all;
--    end WriteHeader;
    
--    function WriteData( aData : pf_data_array_in ) return string is
--        variable aLine : line;
--    begin
--        for i in 0 to N_PF_IP_CORE_IN_CHANS - 1 loop
--            write(aLine, to_integer(aData(i)), right, 15);
--        end loop;
--        return aLine.all;
--    end WriteData
    
--        function WriteData( aData : pf_data_array_out ) return string is
--        variable aLine : line;
--    begin
--        for i in 0 to N_PF_IP_CORE_IN_CHANS - 1 loop
--            write(aLine, aData(i), right, 15);
--        end loop;
--        return aLine.all;
--    end WriteData

--end pf_data_types;