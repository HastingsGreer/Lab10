#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2015.1"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim adder4bit_behav -key {Behavioral:sim_2:Functional:adder4bit} -tclbatch adder4bit.tcl -log simulate.log
