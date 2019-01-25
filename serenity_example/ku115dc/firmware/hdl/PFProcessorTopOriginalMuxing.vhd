library ieee;
use ieee.std_logic_1164.all;

use work.emp_data_types.all;
use work.emp_device_decl.all;
use work.pf_constants.all;
use work.pf_data_types.all;

entity PFProcessorTopOriginalMuxing is
  port(
    clk_p : in std_logic;
    clk_payload: in std_logic_vector(2 downto 0);
    rst_loc: in std_logic_vector(N_REGION - 1 downto 0);
    d : in ldata(4 * N_REGION - 1 downto 0);
    q : out ldata(4 * N_REGION - 1 downto 0)
  );
end PFProcessorTopOriginalMuxing;

architecture rtl of PFProcessorTopOriginalMuxing is 

  signal rst_loc_reg : std_logic_vector(N_REGION - 1 downto 0);
  constant N_FRAMES_USED : natural := 1;
  signal start_pf : std_logic_vector(5 downto 0);
  -- Defined here because of missing Vivado simulator VHDL 2008 support
  -- Should be defined in pf_data_types
  -- type pf_data_array is array (N_PF_IP_CORES - 1 downto 0) of pf_data(N_PF_IP_CORE_IN_CHANS - 1 downto 0);
  signal d_pf : pf_data_array_in; --(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_IN_CHANS - 1 downto 0);
  signal q_pf : pf_data_array_out := (others => (others => (others => '0'))); --(N_PF_IP_CORES - 1 downto 0)(N_PF_IP_CORE_OUT_CHANS - 1 downto 0);

begin


    multiplex : entity work.multiplexer_orig
      PORT MAP (
        clk240                                               => clk_p,
        clk40                                                => clk_payload(2),
        rst                                                  => rst_loc,
        d                                                    => d,
        start_pf                                             => start_pf,
        q_pf(N_PF_IP_CORE_IN_CHANS - 1 downto 0)                     => d_pf(0),
        q_pf(2 * N_PF_IP_CORE_IN_CHANS - 1 downto N_PF_IP_CORE_IN_CHANS)     => d_pf(1),
        q_pf(3 * N_PF_IP_CORE_IN_CHANS - 1 downto 2 * N_PF_IP_CORE_IN_CHANS) => d_pf(2),
        q_pf(4 * N_PF_IP_CORE_IN_CHANS - 1 downto 3 * N_PF_IP_CORE_IN_CHANS) => d_pf(3),
        q_pf(5 * N_PF_IP_CORE_IN_CHANS - 1 downto 4 * N_PF_IP_CORE_IN_CHANS) => d_pf(4),
        q_pf(6 * N_PF_IP_CORE_IN_CHANS - 1 downto 5 * N_PF_IP_CORE_IN_CHANS) => d_pf(5)
    );

   selector_gen : process (clk_p)
   begin  -- process selector_gen
     if clk_p'event and clk_p = '1' then  -- rising clock edge
       rst_loc_reg <= rst_loc;
      end if;
    end process selector_gen;

    generate_pf_cores : for i in N_FRAMES_USED - 1 downto 0 generate
      pf_algo : entity work.pf_ip_wrapper
        PORT MAP (
          clk    => clk_p,
          rst    => rst_loc(i),
          start  => start_pf(i),
          -- start  => start_pf(i),
          input  => d_pf(i),
          done   => open,
          idle   => open,
          ready  => open,
          output => q_pf(i)
        );
    end generate generate_pf_cores;

    demux : entity work.demultiplexer_orig
      port map (
        clk240                                                 => clk_p,
        clk40                                                  => clk_payload(2),
        rst                                                    => rst_loc,
        valid                                                  => '1',  -- d(0).valid, -- TODO: Delay.
        d_pf(1 * N_PF_IP_CORE_OUT_CHANS - 1 downto 0)                  => q_pf(0),
        d_pf(2 * N_PF_IP_CORE_OUT_CHANS - 1 downto 1 * N_PF_IP_CORE_OUT_CHANS) => q_pf(1),
        d_pf(3 * N_PF_IP_CORE_OUT_CHANS - 1 downto 2 * N_PF_IP_CORE_OUT_CHANS) => q_pf(2),
        d_pf(4 * N_PF_IP_CORE_OUT_CHANS - 1 downto 3 * N_PF_IP_CORE_OUT_CHANS) => q_pf(3),
        d_pf(5 * N_PF_IP_CORE_OUT_CHANS - 1 downto 4 * N_PF_IP_CORE_OUT_CHANS) => q_pf(4),
        d_pf(6 * N_PF_IP_CORE_OUT_CHANS - 1 downto 5 * N_PF_IP_CORE_OUT_CHANS) => q_pf(5),
        q                                                      => q(N_PF_IP_CORE_OUT_CHANS - 1 downto 0)
      );

    debug : entity work.Debugger
    generic map( FileName => "LinksOutOrigMuxing.txt", FilePath => "/home/sioni/p2fwk-work/src/GlobalCorrelator_II/serenity_example/ku115dc/test/")
    port map( clk => clk_p, DataIn => q );

end rtl;
