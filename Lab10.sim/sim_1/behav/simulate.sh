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
ExecStep $xv_path/bin/xsim addsub_test_behav -key {Behavioral:sim_1:Functional:addsub_test} -tclbatch addsub_test.tcl -view /home/hastings/comp541/project2/addsub_test_behav.wcfg -log simulate.log
