# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {Common-41} -limit 4294967295
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/hastings/Lab10/Lab10.cache/wt [current_project]
set_property parent.project_path /home/hastings/Lab10/Lab10.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_mem {
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/hastings/reg_data.mif
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/c541/sqr_imem.mif
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/c541/sqr_dmem.mif
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/lab11/screentest_imem.mif
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/lab11/screentest_bmem.mif
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/lab11/screentest_nopause_imem.mif
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/lab11/screentest_smem.mif
}
read_verilog -library xil_defaultlib -sv {
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/register_file.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/new/xycounter.v
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/datapath.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/c541/controller.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/new/display640x480.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/new/vgatimer.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/bmem.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/c541/mips.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/smem.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/imem.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/dmem.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/new/vgadisplaydriver.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/imports/lab11/clockdiv.sv
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/screen_top.sv
}
read_verilog -library xil_defaultlib {
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/fulladder.v
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/adder.v
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/shifter.v
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/logical.v
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/comparator.v
  /home/hastings/Lab10/Lab10.srcs/sources_1/new/addsub.v
  /home/hastings/classes/comp541/project_3/project_3.srcs/sources_1/new/ALU.v
}
read_xdc /home/hastings/Lab10/Lab10.srcs/constrs_1/imports/new/vgadisplaydriver.xdc
set_property used_in_implementation false [get_files /home/hastings/Lab10/Lab10.srcs/constrs_1/imports/new/vgadisplaydriver.xdc]

synth_design -top screen_top -part xc7a100tcsg324-1
write_checkpoint -noxdef screen_top.dcp
catch { report_utilization -file screen_top_utilization_synth.rpt -pb screen_top_utilization_synth.pb }
