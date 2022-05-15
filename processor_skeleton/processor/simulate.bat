@echo off
REM ===========================================================================
REM == SIMULATE.BAT
REM ===========================================================================

set MODULE=computer
set TESTBENCH=%MODULE%_tb.sv
set SOUTPUT=-lxt2

vvp %MODULE%.exe %TESTBENCH% %SOUTPUT%