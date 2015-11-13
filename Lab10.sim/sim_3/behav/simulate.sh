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
ExecStep $xv_path/bin/xsim mips_test_sqr_behav -key {Behavioral:sim_3:Functional:mips_test_sqr} -tclbatch mips_test_sqr.tcl -view /home/hastings/Lab9/Lab9_test_behav.wcfg -log simulate.log
