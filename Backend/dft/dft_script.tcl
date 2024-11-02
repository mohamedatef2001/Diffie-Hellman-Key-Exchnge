########################### Define Top Module ############################
                                                   
set top_module Diffe_TOP

##################### Define Working Library Directory ######################


##### In Synopsys synthesis tools, the “Define Working Library Directory"
##### command is used to specify the directory where the design libraries are stored. 
##### This is crucial because it tells the tool where to find the necessary files for synthesis
                                                   
define_design_lib work -path ./work

############################# Formality Setup File ##########################

##### The automated setup file (.svf) helps Formality understand design
##### changes caused by other tools used in the design flow. Formality
##### uses this file to assist the compare point matching and verification
##### rocess.---- set_svf -off: This command turns off the SVF setting.
##### It is typically used after the compilation and verification processes
##### are complete to clean up and ensure that no further SVF configurations are applied.

                                                   
set_svf $top_module.svf

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries          #"
puts "###########################################"

#Add the path of the libraries and RTL files to the search_path variable

lappend search_path "/home/IC/Diffe/rtl"
lappend search_path "/home/IC/Diffe/std_cells"

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"


## Standard Cell libraries 

set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 

set link_library [list * $SSLIB $TTLIB $FFLIB]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

set file_format verilog 


read_file -format $file_format CHECK_2.v
read_file -format $file_format mux2X1.v
read_file -format $file_format CLC_R1.v
read_file -format $file_format CLC_R2.v
read_file -format $file_format CONTROLLER.v
read_file -format $file_format ENCRYPTION_R1.v
read_file -format $file_format ENCRYPTION_R2.v
read_file -format $file_format Exponentiation.v
read_file -format $file_format Exponentiation_For_R.v
read_file -format $file_format Diffe_TOP_dft.v

###################### Defining toplevel ###################################

##### By using current_design $top_module, 
##### you inform the tool which module should be treated as the top-level design. 
##### This is crucial for various design tasks such as synthesis, place and route, and timing analysis.
##### 1.Read RTL: Read in your RTL files.
##### 2.Set Top-Level: Use current_design $top_module to specify the top-level module.
##### 3.Synthesis and Verification: Perform synthesis, place and route, and other design tasks.


current_design $top_module


#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link


#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

##### check_design: This command is used to perform a series of checks on your design. It typically looks for issues such as:
##### 1.Combinational loops
##### 2.Unintended latches
##### 3.Floating inputs
##### 4.Dead code  : refers to sections of code in a program that are never executed or, if executed, have no effect on the program’s behavior.
##### 5.Multidriven nets

check_design > reports/check_design.rpt
change_names -rules verilog -hierarchy -verbose


#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source -echo ./cons.tcl


#################### Archirecture Scan Chains #########################
puts "###############################################"
puts "############ Configure scan chains ############"
puts "###############################################"

set_scan_configuration -clock_mixing no_mix  -style multiplexed_flip_flop -replace true -max_length 100  

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile -scan


################################################################### 
# Setting Test Timing Variables
################################################################### 

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0

########################## Define DFT Signals ##########################

set_dft_signal -port [get_ports scan_clk]  -type ScanClock   -view existing_dft  -timing {30 60}
set_dft_signal -port [get_ports scan_rst]  -type Reset       -view existing_dft  -active_state 0
set_dft_signal -port [get_ports test_mode] -type Constant    -view existing_dft  -active_state 1 
set_dft_signal -port [get_ports test_mode] -type TestMode    -view spec          -active_state 1 
set_dft_signal -port [get_ports SE]        -type ScanEnable  -view spec          -active_state 1   -usage scan
set_dft_signal -port [get_ports SI]        -type ScanDataIn  -view spec 
set_dft_signal -port [get_ports SO]        -type ScanDataOut -view spec

############################# Create Test Protocol #####################

create_test_protocol
                            
###################### Pre-DFT Design Rule Checking ####################

dft_drc -verbose

############################# Preview DFT ##############################

preview_dft -show scan_summary

############################# Insert DFT ###############################

insert_dft

######################## Optimize Logic post DFT #######################

compile -scan -incremental

###################### Design Rule Checking post DFT ###################

dft_drc -verbose -coverage_estimate

##################### Close Formality Setup file ###########################

set_svf -off

#############################################################################
# Write out files
#############################################################################

write_file -format verilog -hierarchy -output netlists/$top_module.ddc
write_file -format verilog -hierarchy -output netlists/$top_module.v
write_sdf  sdf/$top_module.sdf
write_sdc  -nosplit sdc/$top_module.sdc

####################### reporting ##########################################

report_area -hierarchy > reports/area.rpt
report_power -hierarchy > reports/power.rpt
report_timing -delay_type min -max_paths 20 > reports/hold.rpt
report_timing -delay_type max -max_paths 20 > reports/setup.rpt
report_clock -attributes > reports/clocks.rpt
report_constraint -all_violators -nosplit > reports/constraints.rpt

################# starting graphical user interface #######################

#gui_start

#exit
