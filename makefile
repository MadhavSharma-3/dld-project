# Makefile for cocotb simulation

# SIM is the Verilog simulator we are using
SIM=icarus

# TOPLEVEL_LANG is the language of our toplevel
TOPLEVEL_LANG=verilog

# Tell make to look for source files in the current directory
VPATH = .

# VERILOG_SOURCES is a list of all Verilog files
# We MUST include all .v files used in the design
VERILOG_SOURCES=project.v tb_project.v

# TOPLEVEL is the Verilog module that cocotb will drive
# This MUST match the module name inside your project.v file
TOPLEVEL=traffic_light_controller

# FIX: Use modern COCOTB_TEST_MODULES instead of deprecated MODULE
COCOTB_TEST_MODULES=run_sim

# --- FIX for VVP Stop(0) Error ---
# This adds the "-n" (non-interactive) flag to the vvp command
# This forces the simulation to run in "batch" mode without pausing
SIM_ARGS += -n
# --- End of Fix ---

# This is the standard cocotb setup.
# It finds cocotb's own makefiles and includes them.
include $(shell cocotb-config --makefiles)/Makefile.sim

# The 'sim' target is now correctly provided by the 'include' above.