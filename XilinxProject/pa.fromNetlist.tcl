
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name MS1553_Interface -dir "C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject/planAhead_run_2" -part xc6slx45tfgg484-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject/System_cs.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Phillip/Dropbox/workspace/class_projects/MS1553_Interface/XilinxProject} {ipcore_dir} }
add_files [list {ipcore_dir/Memory.ncf}] -fileset [get_property constrset [current_run]]
set_param project.pinAheadLayout  yes
set_property target_constrs_file "System.ucf" [current_fileset -constrset]
add_files [list {System.ucf}] -fileset [get_property constrset [current_run]]
link_design
