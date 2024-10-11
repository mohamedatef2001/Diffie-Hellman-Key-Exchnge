
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
read_file -format $file_format CLC_R1.v
read_file -format $file_format CLC_R2.v
read_file -format $file_format CONTROLLER.v
read_file -format $file_format ENCRYPTION_R1.v
read_file -format $file_format ENCRYPTION_R2.v
read_file -format $file_format Exponentiation.v
read_file -format $file_format Exponentiation_For_R.v
read_file -format $file_format Diffe_TOP.v

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

check_design >> reports/check_design.rpt
change_names -rules verilog -hierarchy -verbose


#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

source -echo ./cons.tcl

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile
##################### Close Formality Setup file ###########################

set_svf -off 

#############################################################################
# Write out files
#############################################################################
write_file -format verilog -hierarchy -output netlists/$top_module.v
write_sdc  -nosplit sdc/$top_module.sdc
# for formality
write_file -format verilog -hierarchy -output netlists/$top_module.ddc 
# for GLS
write_sdf  sdf/$top_module.sdf 
####################### reporting ##########################################
report_area -hierarchy > reports/area.rpt
report_power -hierarchy > reports/power.rpt
report_timing -delay_type min  > reports/hold.rpt
report_timing -delay_type max  > reports/setup.rpt
report_clock -attributes > reports/clocks.rpt
report_constraint -all_violators -nosplit > reports/constraints.rpt
report_high_fanout_nets > reports/fanout.rpt
#report_timing -from [all_inputs]  -to [all_outputs] > report-input2output.txt

############################################################################
# DFT Preparation Section
############################################################################

#set flops_per_chain 100

#set num_flops [sizeof_collection [all_registers -edge_triggered]]

#set num_chains [expr $num_flops / $flops_per_chain + 1 ]

################# starting graphical user interface #######################

#gui_start

#exit
