# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.cache/wt [current_project]
set_property parent.project_path D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property ip_repo_paths d:/Shared/USN_study/Private/VHDL/vivado-library-2018.2-1/vivado-library [current_project]
update_ip_catalog
set_property ip_output_repo d:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/sources_1/imports/Group_2/Main_state_machine.vhd
  D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/sources_1/imports/Group_2/Memory_control.vhd
  D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/sources_1/imports/Group_2/Read_data_state_machine.vhd
  D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/sources_1/imports/Group_2/Self_block_ram_wrapper.vhd
  D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/sources_1/imports/Group_2/Send_data_state_machine.vhd
  D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/sources_1/imports/Group_2/RX_TX_read_write_control.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/constrs_1/imports/Cheating_dice/Basys3.xdc
set_property used_in_implementation false [get_files D:/Shared/USN_study/HW_SW_CO_Design/ABC/Group_2/Hardware/Hardware.srcs/constrs_1/imports/Cheating_dice/Basys3.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top RX_TX_read_write_control -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef RX_TX_read_write_control.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file RX_TX_read_write_control_utilization_synth.rpt -pb RX_TX_read_write_control_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
