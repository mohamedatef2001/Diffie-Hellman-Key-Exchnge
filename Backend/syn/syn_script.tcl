
##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work

################## Design Compiler Library Files #setup ######################

puts "###########################################"
puts "#      #setting Design Libraries           #"
puts "###########################################"

#Add the path of the libraries to the search_path variable
lappend search_path "/home/IC/Diffe/std_cells"
lappend search_path "/home/IC/Diffe/rtl"

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list  $TTLIB $SSLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list *   $TTLIB $SSLIB $FFLIB ]  

######################## Reading RTL Files #################################

puts "###########################################"
puts "#             Reading RTL Files           #"
puts "###########################################"

set file_format verilog

read_file -format $file_format Diffe_TOP.v
read_file -format $file_format CHECK_2.v
read_file -format $file_format CLC_R1.v
read_file -format $file_format CLC_R2.v
read_file -format $file_format CONTROLLER.v
read_file -format $file_format ENCRYPTION_R1.v
read_file -format $file_format ENCRYPTION_R2.v
read_file -format $file_format Exponentiation.v

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

link 

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile

#############################################################################
# Write out Design after initial compile
#############################################################################

write_file -format verilog -hierarchy -output Diffe.v
report_timing -from [all_inputs]  -to [all_outputs] > report-input2output.txt

################# starting graphical user interface #######################

#gui_start

#exit
