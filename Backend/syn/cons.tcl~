
####################################################################################
# Constraints
# ----------------------------------------------------------------------------
#
# 0. Design Compiler variables
#
# 1. Master Clock Definitions
#
# 2. Clock Uncertainties
#
# 3. Clock Latencies 
#
# 4. Clock Relationships
#
# 5. set input/output delay on ports
#
# 6. Driving cells
#
# 7. Output load

####################################################################################
           #########################################################
                  #### Section 0 : DC Variables ####
           #########################################################
#################################################################################### 

# Prevent assign statements in the generated netlist (must be applied before compile command)
#-all: This option applies the fix to all nets in the design.
#-buffer_constants: This option ensures that constant values are buffered. Buffering constants can help in optimizing the design and ensuring that constant values are correctly propagated through the netlist.
#-feedthrough: This option allows feedthrough nets to be fixed. Feedthrough nets are those that pass through a module without being used within that module. Fixing these can help in reducing unnecessary logic and improving the #overall design efficiency

set_fix_multiple_port_nets -all -buffer_constant -feedthroughs

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Clock Latencies
# 3. Clock Uncertainties
# 4. Clock Transitions
####################################################################################

# Note : get_ports is used when you need to interact with the external interface of your design, whereas get_clocks is used when you need to manage and analyze the timing characteristics of clock signals

# Master Clock Definitions  [2 MHz]
set CLK_NAME CLK
set CLK_PRE 666
create_clock -name $CLK_NAME -period $CLK_PRE -waveform "0 [expr $CLK_PRE/2]" [get_ports CLK]
# SKEW
set CLK_SETUP_SKEW 0.1
set CLK_HOLD_SKEW 0.1
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks $CLK_NAME]
set_clock_uncertainty -hold  $CLK_HOLD_SKEW  [get_clocks $CLK_NAME]
# CLOCK_LATENCIES
set CLK_LAT 0
set_clock_latency $CLK_LAT [get_clocks $CLK_NAME]
# CLOCK TRANSITION
set CLK_RISE 0.05
set CLK_FALL 0.05
set_clock_transition -rise $CLK_RISE  [get_clocks $CLK_NAME]
set_clock_transition -fall $CLK_FALL  [get_clocks $CLK_NAME]


set_dont_touch_network CLK

####################################################################################
           #########################################################
             #### Section 2 : Clocks Relationship ####
           #########################################################
####################################################################################

# The set_clock_groups command is used in the context of timing analysis and constraint setting in hardware design. This command helps define relationships between different clock domains in your design.
# which dose not exist here 
# ex :set_clock_groups -asynchronous -group [get_clocks clk1] -group [get_clocks clk2]

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################

set IN_DELAY  0.037
set OUT_DELAY 0.037

# INPUT PATH
set_input_delay $IN_DELAY -clock $CLK_NAME [get_ports G]
set_input_delay $IN_DELAY -clock $CLK_NAME [get_ports ST]
set_input_delay $IN_DELAY -clock $CLK_NAME [get_ports P]
set_input_delay $IN_DELAY -clock $CLK_NAME [get_ports X]
set_input_delay $IN_DELAY -clock $CLK_NAME [get_ports Y]

# OUTPUT DELAY
set_output_delay $OUT_DELAY -clock $CLK_NAME [get_ports OUT]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port G]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port ST]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port P]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port X]
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port Y]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.184576 [get_ports OUT]

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################


