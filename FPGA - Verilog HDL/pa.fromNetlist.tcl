
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name cuckooExten -dir "W:/CPE/digital/project/cuckooExten/planAhead_run_3" -part xc3s400tq144-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "W:/CPE/digital/project/cuckooExten/display.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {W:/CPE/digital/project/cuckooExten} }
set_property target_constrs_file "impre_wanava.ucf" [current_fileset -constrset]
add_files [list {impre_wanava.ucf}] -fileset [get_property constrset [current_run]]
link_design
