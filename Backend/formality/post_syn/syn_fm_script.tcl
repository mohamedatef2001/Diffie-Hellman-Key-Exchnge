
############################  Search PATH ################################

lappend search_path "/home/IC/Diffe/rtl"
lappend search_path "/home/IC/Diffe/std_cells"

########################### Define Top Module ############################
                                                   
set top_module Diffe_TOP

######################### Formality Setup File ###########################

set synopsys_auto_setup true

set_svf "/home/IC/Diffe/syn/Diffe_TOP.svf"

####################### Read Reference tech libs ########################
 

set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

###################  Read Reference Design Files ######################## 
read_verilog -container Ref "CHECK_2.v"
read_verilog -container Ref "CLC_R1.v"
read_verilog -container Ref "CLC_R2.v"
read_verilog -container Ref "CONTROLLER.v"
read_verilog -container Ref "ENCRYPTION_R1.v"
read_verilog -container Ref "ENCRYPTION_R2.v"
read_verilog -container Ref "Exponentiation.v"
read_verilog -container Ref "Exponentiation_For_R.v"
read_verilog -container Ref "Diffe_TOP.v"

######################## set the top Reference Design ######################## 

set_reference_design Diffe_TOP
set_top Diffe_TOP

####################### Read Implementation tech libs ######################## 

read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

#################### Read Implementation Design Files ######################## 

read_verilog -container Imp -netlist "/home/IC/Diffe/syn/netlists/Diffe_TOP.v"

####################  set the top Implementation Design ######################

set_implementation_design Diffe_TOP
set_top Diffe_TOP


## matching Compare points
match

## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

report_passing_points > "reports/passing_points.rpt"
report_failing_points > "reports/failing_points.rpt"
report_aborted_points > "reports/aborted_points.rpt"
report_unverified_points > "reports/unverified_points.rpt"


start_gui
